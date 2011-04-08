//
//  MapViewController.h
//  Nolgilo
//
//  Created by goyange on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKMapView.h>
#import <AudioToolbox/AudioServices.h>

#import "GameModel.h"
#import "GameStage.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	
	IBOutlet MKMapView *mapView;
	
	CLLocationManager *locationManager;
	CLLocationCoordinate2D location;
	
	GameModel *gameSpot;
}

@property (nonatomic,  retain) CLLocationManager *locationManager;;
@property (nonatomic, readonly) CLLocationCoordinate2D location;
@property (nonatomic, retain) MKMapView * mapView; 


@end
