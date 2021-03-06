//
//  MapViewController.m
//  Nolgilo
//
//  Created by goyange on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "RootViewController.h"


@implementation MapViewController


@synthesize locationManager, location;
@synthesize mapView; 


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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[[GameModel alloc] gameInit:mapView];
	
	
	self.locationManager = [[CLLocationManager alloc] init];
	
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	
	[locationManager startUpdatingHeading];
	[locationManager startUpdatingLocation];
	
	mapView.showsUserLocation = YES; // if yes, shows a bule~;
	mapView.mapType = MKMapTypeStandard;
	mapView.delegate = self;
	mapView.zoomEnabled = YES;
	mapView.scrollEnabled = YES;
	mapView.userInteractionEnabled = YES;	
	mapView.transform = CGAffineTransformMakeRotation(0.0f);
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
	[locationManager stopUpdatingHeading];
    [super viewDidUnload]; 
}


-(void)locationManager:(CLLocationManager *)manager
	  didUpdateHeading:(CLHeading *)newHeading{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	mapView.transform = CGAffineTransformMakeRotation(M_PI * (360 - newHeading.trueHeading) / 180.0f);
	[UIView commitAnimations];
}

- (void)dealloc {
    [super dealloc];
}

//위치 확인
-(void) locationManager: (CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
	location = newLocation.coordinate;
	
	MKCoordinateRegion region;
	region.center = location;
	
	MKCoordinateSpan span;
	span.latitudeDelta = 0.002;
	span.longitudeDelta = 0.002;
	region.span = span;
	[mapView setRegion:region animated:YES];
	
}


@end
