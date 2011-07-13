//
//  PingGameViewController.h
//  Nolgilo
//
//  Created by GatGong on 11. 4. 8..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKMapView.h>
#import <ZXingWidgetController.h>

#import "GameStage.h"
#import "PingGameCore.h"
#import "SpotCore.h"
#import "GameModel.h"
@class ResultViewController;

@interface PingGameViewController : UIViewController<ZXingDelegate, MKMapViewDelegate, CLLocationManagerDelegate> {
    
    ResultViewController* resultViewController;
    
	IBOutlet MKMapView *gameStage;
	IBOutlet UIView *menu, *qrcode;
	IBOutlet UIButton *pingButton, *menuButton, *teamButton;
    IBOutlet UIButton *spotcatchButton, *otherteamcatchButton;
    
	NSString * scanResults;
	
	double heading;
	
	struct infolist{
		NSString* teamid;
		NSString* userid;
		NSString* qrimage;
		NSString* teamlabel;
		long score;
		int spotnum;
        NSInteger roomid;
	}info;
	
	struct other {
		NSString* name;
		double dis;
		double radian;
		double lat;
		double log;
		NSString* arrowName;
        bool state;
	}team1, team2;
	IBOutlet UILabel *teamName1, *teamName2;
	IBOutlet UIImageView *teamArrow1, *teamArrow2;

	IBOutlet UIImageView *qrcodeimage, *message, *teamLabel, *alterbox;
	IBOutlet UILabel *altermessage;
    
	bool ping_enable, menu_enable, locupdate, live;
	CLLocationManager *locationManager;
	CLLocationCoordinate2D location;
	MKCoordinateSpan span;
	MKCoordinateRegion region;

	PingGameCore *ping;
	SpotCore *spot;
	GameModel *game;
    
    NSTimer *pingcheck;
}

@property (nonatomic, retain) CLLocationManager *locationManager;;
@property (nonatomic, readonly) CLLocationCoordinate2D location;
@property (nonatomic, retain) MKMapView *gameStage; 

-(IBAction) PingOut;
-(IBAction) CallMenu;
-(IBAction) SpotCatch;
-(IBAction) TeamCatch;
-(IBAction) GameExit;
-(IBAction) QRCodeButton;
-(IBAction) QRCodeCancel;

- (void)userinit:(int)teamselect:(NSInteger)roomid;
@end
