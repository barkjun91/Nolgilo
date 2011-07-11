//
//  PingGameViewController.m
//  Nolgilo
//
//  Created by GatGong on 11. 4. 8..
//  Copyright 2011 Nolgong. All rights reserved.
//


#import <QRCodeReader.h>
#import "PingGameViewController.h"
#import "ResultViewController.h"

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

-(GameModel *) game
{
	if(!game){
		game = [[GameModel alloc] init];
	}
	return game;
}


-(void) OnTimer:(NSTimer *)timer
{
	[[self game] fadeView:message:FALSE];
}

-(void) SetMessage:(NSString *)imagename:(double)sc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@.png", imagename]);
	message.image  = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", imagename]];
	[NSTimer scheduledTimerWithTimeInterval:sc
									 target:self
								   selector:@selector(OnTimer:)
								   userInfo:nil
									repeats:NO
	 ];
	[[self game] fadeView:message:TRUE];
}

- (void)SpotBuilding{
//	[[self spot] initSpot];
//	[[self spot]addPin:gameStage];
}





- (void)userinit:(int)teamselect:(NSInteger)roomid{
    if(teamselect == 1){
        info.teamid = @"A";
    }
    else if(teamselect == 2){
        info.teamid = @"B";
    }
    else{
        info.teamid = @"C";
        altermessage.textColor = [UIColor blackColor];
    }
    info.roomid = roomid;
	info.teamlabel = [[self ping] SetTeamLabel:info.teamid];
	info.qrimage = [[self ping] SetQRImage:info.teamid];
	
	qrcodeimage.image = [UIImage imageNamed:info.qrimage];
	teamLabel.image = [UIImage imageNamed:info.teamlabel];
    alterbox.image = [UIImage imageNamed:[NSString stringWithFormat:@"team%@Alerts.png", info.teamid]];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self SpotBuilding];
	[[self game] GameInitMessage];

	span.latitudeDelta = 0.002;
	span.longitudeDelta = 0.002;
	
	self.locationManager = [[CLLocationManager alloc] init];	
	[[GameStage alloc] StageInit:gameStage];
	
	ping_enable = FALSE;
	menu_enable = FALSE;
    locupdate = FALSE;
    live = TRUE;
    
    info.score = 0;
    
    pingcheck = [[NSTimer scheduledTimerWithTimeInterval:4.0
                                                  target:self
                                                selector:@selector(check:)
                                                userInfo:nil
                                                 repeats:YES] retain]; 
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;

	[locationManager startUpdatingHeading];
	[locationManager startUpdatingLocation];
	
    resultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
    
}

-(void)goResult:(int)state{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	[self.view addSubview:resultViewController.view];
    if(state == 1){
        [resultViewController resultinit:info.teamid:info.score:@"win"];
    }
    else if(state == 2){
        [resultViewController resultinit:info.teamid:info.score:@"Lose"];
    }
	[UIView commitAnimations];
    [pingcheck release];
}

-(void)pingChecking{
    NSString *pingteam;
    pingteam = [[self ping] PingCheck:info.teamid];
    if([pingteam isEqual:@"0"]){
    }
    else{
        
        [[self ping] PingTeamInfo:pingteam];
        altermessage.text = [NSString stringWithFormat:@"%@팀에서 발사된 핑이 감지되었습니다", pingteam];
        double radian, lat, log, dis;
        NSString *arrowName;
        
        lat = [[self ping]GetPingLat];
        log = [[self ping]GetPingLog];
        NSLog(@"%f, %f", lat, log);
        
        radian = [[self ping] GetRadian:lat:log];
        dis = [[self ping] GetDistance:lat:log];
        
        arrowName = [[self ping] GetArrowImage:dis:0];
        
        teamArrow1.transform = CGAffineTransformMakeRotation(radian);
		teamName1.transform = CGAffineTransformMakeRotation(radian);
        
        
        teamArrow1.image = [UIImage imageNamed:arrowName];
        teamName1.text = [[self ping] GetTeamLabel:pingteam
                                                  :arrowName];
        
        [NSTimer scheduledTimerWithTimeInterval:4.0
                                         target:self
                                       selector:@selector(show:)
                                       userInfo:nil
                                        repeats:NO
         ];
        
        altermessage.hidden = NO;
        alterbox.hidden = NO;
        ping_enable = TRUE;
        
        teamArrow1.hidden = NO;
        teamName1.hidden = NO;
        [[self ping] PingCheckEnd:info.teamid:pingteam];
    }
}
-(void) end:(NSTimer*)timer
{
    int result;
    result = [[self ping] GameResult:info.teamid];
    [self goResult:result];
}
-(void) gameChecking{
    if([[self ping] GameCheking:info.teamid]){
        [pingcheck invalidate];
        [self SetMessage:@"GameEnd":5.0];
        [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(end:)
                                       userInfo:nil
                                        repeats:NO
         ];
    }
}
-(void) check:(NSTimer*)timer
{
    if(live){
        [self pingChecking];
    }
    [self gameChecking];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void) show: (NSTimer *)timer{
	altermessage.hidden = YES;
	alterbox.hidden = YES;
    teamArrow1.hidden = YES;
    teamName1.hidden = YES;
    ping_enable = FALSE;
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
	
	if(ping_enable){
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
    if(locupdate != TRUE){
        [[self ping] init:location.latitude:location.longitude:info.roomid];
        [[self ping] InitLoc:info.teamid 
                            :location.latitude
                            :location.longitude];
        locupdate = TRUE;
    }
    else{
        [[self ping] UpdateLoc:info.teamid 
                              :location.latitude 
                              :location.longitude];
    }
//	NSLog(@"update");
	
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
	[[self ping] ConnectDB:info.teamid];
	
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
    ping_enable = YES;
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
	menu.frame = CGRectMake(195.0f,272.0f, menu.frame.size.width, menu.frame.size.height);
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

-(IBAction) GameExit{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"게임종료" 
                                                    message:@"게임을 종료하실건가요?\n 게임을 종료하면 같은방에 다시 참여하실 수 없습니다."
                                                   delegate:self
                                          cancelButtonTitle:@"아니오"
                                          otherButtonTitles:@"네", nil];
    [alert show];
    [alert release];	
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex){
        [[self ping] alterExit:info.teamid];
        NSLog(@"정상적으로 종료가 되었습니다.");
        [self goResult:2];

    }
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
    int state = [[self ping] GetState:info.teamid];
    
    if(state){
        //1이니까 살아있는것.
    }
    else{
        pingButton.enabled = NO;
        otherteamcatchButton.enabled = NO;
        teamButton.enabled = NO;
        live = FALSE;
        
        [self SetMessage:@"Catched":8.0];
    }
}

- (void) wrongQRCode{
	[self SetMessage:@"wrongQR":5.0];
}


-(void) CatchingTeam:(NSString *)teamid{
	if([teamid isEqualToString:info.teamid]){
		[self wrongQRCode];
	}
	else{
		if([[self ping] GetTeam:teamid]){
			[self SetMessage:[NSString stringWithFormat:@"catching%@", teamid]:5.0];
            info.score += 30;
            [[self ping] SetScore:info.teamid:info.score];
		}
        else{
            [self wrongQRCode];
        }
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

#pragma mark -
#pragma mark MapAnotation

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	MKPinAnnotationView* pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"asdf"];
	pinView.pinColor = MKPinAnnotationColorPurple;
	pinView.animatesDrop = YES;
	pinView.canShowCallout = YES;
	
	return pinView;
}
@end
