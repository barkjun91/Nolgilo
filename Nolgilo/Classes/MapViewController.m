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
	mapView.showsUserLocation = YES; // if yes, shows a bule~;
	mapView.mapType = MKMapTypeStandard;
	mapView.delegate = self;
	mapView.zoomEnabled = YES;
	mapView.scrollEnabled = YES;
	mapView.userInteractionEnabled = YES;
	
	self.locationManager = [[CLLocationManager alloc] init];
	
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	
	[locationManager startUpdatingHeading];
	[locationManager startUpdatingLocation];
	[self presentSheet];
	

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
	self.mapView = nil;
	self.locationManager = nil;
    [super viewDidUnload]; 
	[locationManager stopUpdatingHeading];
}
//나침판과 지도 연동~

- (void)viewWillAppear:(BOOL)animated{

	[super viewWillAppear:YES];
	NSLog(@"Heading init");
	mapView.transform = CGAffineTransformMakeRotation(0.0f);
	if([CLLocationManager headingAvailable]){
		[locationManager startUpdatingHeading];
	}	
	
}
-(void) viewWillDisappear:(BOOL)animated{
	
	[super viewWillAppear:animated];
	if([CLLocationManager headingAvailable]){
		[locationManager stopUpdatingHeading];
	}
}
-(void)locationManager:(CLLocationManager *)manager
	  didUpdateHeading:(CLHeading *)newHeading{
	NSLog(@"Updatding");
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	mapView.transform = CGAffineTransformMakeRotation(M_PI * (360 - newHeading.trueHeading) / 180.0f);
	[UIView commitAnimations];
}

- (void)dealloc {
	[annotation release];
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
	
	annotation = [[GameAnnotation alloc] Coordinatelat:37.549502
										 Coordinatelng:126.913933
												 title: @"여기당"
											  subTitle: @"ㅎㅎㅎ"
				  ];
	
	[mapView addAnnotation:annotation];
}
-(void) performDismiss: (NSTimer *)timer{
	
	[baseAlert dismissWithClickedButtonIndex:0 animated:NO];
}

-(void) presentSheet{
	baseAlert = [[UIAlertView alloc] 
							  initWithTitle:@"[ 동기화중 ]"
							  message:@"위치정보를 설정하고 있습니다. \n 잠시만 기다려주세요."
							  delegate:self 
							  cancelButtonTitle:nil
							  otherButtonTitles:nil];
	
	[NSTimer scheduledTimerWithTimeInterval:3.0
									 target:self
								   selector:@selector(performDismiss:)
								   userInfo:nil
									repeats:NO
	 ];
	
	[baseAlert show];	
}
@end
