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

-(PingGameCore *) ping
{
	if(!ping){
		ping = [[PingGameCore alloc] init];
	}
	return ping;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	span.latitudeDelta = 0.002;
	span.longitudeDelta = 0.002;
	
	self.locationManager = [[CLLocationManager alloc] init];	
	[[GameStage alloc] StageInit:gameStage];
	
	ping_enable = FALSE;
	
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
	[locationManager stopUpdatingLocation];
    [locationManager release];
    [super dealloc];
}

-(void) showInfo: (NSTimer *)timer{
	teamName1.hidden = YES;
	teamArrow1.hidden = YES;
	teamName2.hidden = YES;
	teamArrow2.hidden = YES;
	ping_enable = FALSE;
}

-(void) pingTime: (NSTimer *)timer{
	pingButton.enabled = YES;	
}

-(void) DataSet{
	[[self ping] init:location.latitude:location.longitude:@"A"];
	
	team1.name = [[self ping] SetTeamName:0];
	team2.name = [[self ping] SetTeamName:1];
	
	team1.lat = [[self ping] SetLat:0];
	team1.log = [[self ping] SetLog:0];
	team2.lat = [[self ping] SetLat:1];
	team2.log = [[self ping] SetLog:1];
	
	team1.dis = [[self ping] SetDistance:team1.lat:team1.log];
	team2.dis = [[self ping] SetDistance:team2.lat:team2.log];

	team1.radian = [[self ping] SetRadian:team1.lat :team1.log];
	team2.radian = [[self ping] SetRadian:team2.lat :team2.log];
	NSLog(@"%f", team1.radian);
	
	team1.arrowName = [[self ping] SetArrowImage:team1.dis
												:0];
	team2.arrowName = [[self ping] SetArrowImage:team2.dis
												:0];
}
-(void) ImageDataSet{

	
	teamArrow1.image = [UIImage imageNamed:team1.arrowName];
	teamArrow2.image = [UIImage imageNamed:team2.arrowName];
	teamName1.text = [[self ping] SetTeamLabel:team1.name
											  :team1.arrowName];
	teamName2.text = [[self ping] SetTeamLabel:team2.name
											  :team2.arrowName];
	
	if(!ping_enable){
		teamArrow1.transform = CGAffineTransformMakeRotation(team1.radian);
		teamName1.transform = CGAffineTransformMakeRotation(team1.radian);
		teamArrow2.transform = CGAffineTransformMakeRotation(team2.radian);
		teamName2.transform = CGAffineTransformMakeRotation(team2.radian);
	}
	
}

-(void) PingMessageOut{
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
	
	teamName1.hidden = NO;
	teamArrow1.hidden = NO;
	teamName2.hidden = NO;
	teamArrow2.hidden = NO;
	pingButton.enabled = NO;
}

-(IBAction) PingOut{	
	region.center = location;
	[gameStage setRegion:region animated:YES];
	
	
	[self DataSet];
	[self ImageDataSet];
	[self PingMessageOut];
	
}

-(IBAction) Catch{
	
}

-(IBAction) MenuOut{
	

	
	
	
}


@end
