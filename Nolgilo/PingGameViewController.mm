//
//  PingGameViewController.m
//  Nolgilo
//
//  Created by GatGong on 11. 4. 8..
//  Copyright 2011 Nolgong. All rights reserved.
//


#import <QRCodeReader.h>
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
-(SpotCore *) spot
{
	if(!spot){
		spot = [[SpotCore alloc] init];
	}
	return spot;
}

- (void)SpotBuilding{
	
}



- (void)userinit{
	info.teamid = @"A";
	if([info.teamid isEqualToString: @"A"]){
		info.qrimage = @"pingteamA.png";
	}
	else if([info.teamid isEqualToString: @"B"]){
		info.qrimage = @"pingteamB.png";
	}
	else {
		info.qrimage = @"pingteamC.png";
	}
	qrcodeimage.image = [UIImage imageNamed:info.qrimage];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self SpotBuilding];
	
	span.latitudeDelta = 0.002;
	span.longitudeDelta = 0.002;
	
	self.locationManager = [[CLLocationManager alloc] init];	
	[[GameStage alloc] StageInit:gameStage];
	[self userinit];
	
	ping_enable = FALSE;
	menu_enable = FALSE;
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
	
	team1.name = [[self ping] GetTeamName:0];
	team2.name = [[self ping] GetTeamName:1];
	
	team1.lat = [[self ping] GetLat:0];
	team1.log = [[self ping] GetLog:0];
	team2.lat = [[self ping] GetLat:1];
	team2.log = [[self ping] GetLog:1];
	
	team1.dis = [[self ping] GetDistance:team1.lat:team1.log];
	team2.dis = [[self ping] GetDistance:team2.lat:team2.log];

	team1.radian = [[self ping] GetRadian:team1.lat:team1.log];
	team2.radian = [[self ping] GetRadian:team2.lat:team2.log];
	
	team1.arrowName = [[self ping] GetArrowImage:team1.dis:0];
	team2.arrowName = [[self ping] GetArrowImage:team2.dis:0];
}
-(void) ImageDataSet{

	
	teamArrow1.image = [UIImage imageNamed:team1.arrowName];
	teamArrow2.image = [UIImage imageNamed:team2.arrowName];
	teamName1.text = [[self ping] GetTeamLabel:team1.name
											  :team1.arrowName];
	teamName2.text = [[self ping] GetTeamLabel:team2.name
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

//Ping버튼이 눌렸을때
-(IBAction) PingOut{	
	region.center = location;
	[gameStage setRegion:region animated:YES];
	
	
	[self DataSet];
	[self ImageDataSet];
	[self PingMessageOut];
	
}


-(void)MenuOpen{
	menu.frame = CGRectMake(195.0f,312.0f, menu.frame.size.width, menu.frame.size.height);
	[self.view addSubview:menu];
	menu_enable = TRUE;
}

-(void)MenuClose{
	[menu removeFromSuperview];
	menu_enable = FALSE;
}

-(IBAction) CallMenu{
	if(!menu_enable){
		[self MenuOpen];
	}
	else{
		[self MenuClose];
	}
}
-(IBAction) SpotCatch{
	
}
-(IBAction) TeamCatch{
	[self MenuClose];
	ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
	QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
	NSSet *readers = [[NSSet alloc] initWithObjects:qrcodeReader,nil];
	[qrcodeReader release];
	widController.readers = readers;
	[readers release];
	[self presentModalViewController:widController animated:YES];
	[widController release];
}

-(IBAction) QRCodeButton{
	[self.view addSubview:qrcode];
}
-(IBAction) QRCodeCancel{
	[qrcode removeFromSuperview];
}

-(void)fadeView:(UIView *) v: (BOOL) appare{
	if(appare){
		v.alpha = 0;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		v.alpha = 1;
		[UIView commitAnimations];
	}else {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		v.alpha = 0;
		[UIView commitAnimations];
	}
	
}

-(void) OnTimer:(NSTimer *)timer
{
	[self fadeView:message:FALSE];
}

-(void) SetMessage:(NSString *)imagename{
	message.image  = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", imagename]];
	[NSTimer scheduledTimerWithTimeInterval:5.0
									 target:self
								   selector:@selector(OnTimer:)
								   userInfo:nil
									repeats:NO
	 ];
	[self fadeView:message:TRUE];
}

- (void) wrongQRCode{
	[self SetMessage:@"wrongQR"];
}

-(void) CatchingTeam:(NSString *)teamname{
	if([teamname isEqualToString:info.teamid]){
		[self wrongQRCode];
	}
	else{
		[self SetMessage:[NSString stringWithFormat:@"catching%@", teamname]];
	}
}

#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	scanResults = result;
	if (self.isViewLoaded) {
		if([[scanResults substringToIndex:8] isEqualToString:@"PingGame"]){
			[self CatchingTeam:[scanResults substringFromIndex:14]];
		}
		else{
			[self wrongQRCode];
		}
	}
	[self dismissModalViewControllerAnimated:NO];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	[self dismissModalViewControllerAnimated:NO];
}


@end
