//
//  PingGameViewController.m
//  Nolgilo
//
//  Created by GatGong on 11. 4. 8..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "PingGameViewController.h"


@implementation PingGameViewController

@synthesize locationManager, location;
@synthesize gameStage; 


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(PingGameCore *) core
{
	if(!core){
		core = [[PingGameCore alloc] init];
	}
	return core;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	span.latitudeDelta = 0.002;
	span.longitudeDelta = 0.002;
	
	self.locationManager = [[CLLocationManager alloc] init];	
	[[GameStage alloc] StageInit:gameStage];
	
	ping = FALSE;
	
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;

	[locationManager startUpdatingHeading];
	[locationManager startUpdatingLocation];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/* 맵 회전 관련 부분 */
-(void)locationManager:(CLLocationManager *)manager
	  didUpdateHeading:(CLHeading *)newHeading{

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	/* 아이폰 회전 관련 부분 */
	heading = M_PI * (360 - newHeading.trueHeading) / 180.0f;

	gameStage.transform = CGAffineTransformMakeRotation(heading);
	
	if(ping){
		teamName1.transform = CGAffineTransformMakeRotation(team1.radian+heading);
		teamArrow1.transform = CGAffineTransformMakeRotation(team1.radian+heading);
		teamName2.transform = CGAffineTransformMakeRotation(team2.radian+heading);
		teamArrow2.transform = CGAffineTransformMakeRotation(team2.radian+heading);
	}
	
	[UIView commitAnimations];
}

/* 맵 위치 리로딩 */
-(void) locationManager: (CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{

	location = newLocation.coordinate;
	region.center = location;
	region.span = span;
	[gameStage setRegion:region animated:YES];
	
}

/* 일정 영역을 벗어나면 발생
 -(void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
}
*/

- (void)dealloc {

	[locationManager stopUpdatingHeading];
    [locationManager release];
    [super dealloc];
}
-(IBAction) Catch{

	NSString* catchteam = [[self core] CatchCheck];	
	
	if([catchteam isEqualToString: @"team1"]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"잡기 성공" 
														message:@"상대팀을 잡는데 성공하셨습니다!"
													   delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	else if([catchteam isEqualToString: @"team2"]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"잡기 성공" 
														message:@"상대팀을 잡는데 성공하셨습니다!"
													   delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"잡기 실패" 
														message:@"주변에 상대팀이 없습니다."
													   delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
}
-(IBAction) PingOut{	
	region.center = location;
	[gameStage setRegion:region animated:YES];
	
	NSMutableArray *otherteam_info = [[self core] SearchOtherTeam:location.latitude 
														   :location.longitude
														   :@"A"];
	team1.name = [otherteam_info objectAtIndex:0];
	teamName1.text = [[self core] TeamNameSet:team1.name
											 :[otherteam_info objectAtIndex:2]];
	teamArrow1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",
											[otherteam_info objectAtIndex:2]]];
	team1.radian = [[self core] SetAngle:[otherteam_info objectAtIndex:0]];
	team1.alive = [[otherteam_info objectAtIndex:4] boolValue];
	
	team2.name = [otherteam_info objectAtIndex:1];
	teamName2.text = [[self core] TeamNameSet:team2.name
											 :[otherteam_info objectAtIndex:3]];
	teamArrow2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",
											[otherteam_info objectAtIndex:3]]];
	team2.radian = [[self core] SetAngle:[otherteam_info objectAtIndex:1]];
	team2.alive = [[otherteam_info objectAtIndex:5] boolValue];
	
	
	if(!ping){
		teamArrow1.transform = CGAffineTransformMakeRotation(team1.radian);
		teamName1.transform = CGAffineTransformMakeRotation(team1.radian);
		teamArrow2.transform = CGAffineTransformMakeRotation(team2.radian);
		teamName2.transform = CGAffineTransformMakeRotation(team2.radian);
	}
	//3초간 상대방의 위치를 보여준다.
	[NSTimer scheduledTimerWithTimeInterval:6.0
									 target:self
								   selector:@selector(showInfo:)
								   userInfo:nil
									repeats:NO
	];
	//ping버튼은 3초간 coolTime이 존재한다.
	[NSTimer scheduledTimerWithTimeInterval:8.0
									 target:self
								   selector:@selector(pingTime:)
								   userInfo:nil
									repeats:NO
	 ];
	
	if(team1.alive){
		teamName1.hidden = NO;
		teamArrow1.hidden = NO;
	}
	if(team2.alive){
		teamName2.hidden = NO;
		teamArrow2.hidden = NO;
	}
	pingButton.enabled = NO;
	

	
	ping = TRUE;

}

-(void) showInfo: (NSTimer *)timer{
	teamName1.hidden = YES;
	teamArrow1.hidden = YES;
	teamName2.hidden = YES;
	teamArrow2.hidden = YES;
	ping = FALSE;
	
}
-(void) pingTime: (NSTimer *)timer{
	pingButton.enabled = YES;	
}
-(IBAction) MenuOut{
	

	
	
	
}


@end
