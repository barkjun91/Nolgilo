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

#import "GameStage.h"
#import "PingGameCore.h"

@interface PingGameViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate> {
	IBOutlet MKMapView *gameStage;
	IBOutlet UILabel *teamName1, *teamName2;
	IBOutlet UIImageView *teamArrow1, *teamArrow2;
	IBOutlet UIButton *pingButton, *menuButton;
	double heading;
	
	struct other {
		NSString* name;
		double radian;
		bool alive;
		bool check;
	}team1, team2;
	
	bool ping;
	
	CLLocationManager *locationManager;
	CLLocationCoordinate2D location;
	MKCoordinateSpan span;
	MKCoordinateRegion region;

	
	PingGameCore *core;
	
}

@property (nonatomic, retain) CLLocationManager *locationManager;;
@property (nonatomic, readonly) CLLocationCoordinate2D location;
@property (nonatomic, retain) MKMapView *gameStage; 

-(IBAction) PingOut;
-(IBAction) MenuOut;
-(IBAction) Catch;
@end
