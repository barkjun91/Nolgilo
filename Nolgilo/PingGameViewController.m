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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.locationManager = [[CLLocationManager alloc] init];	
	[[GameStage alloc] StageInit:gameStage];
	
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

-(void)locationManager:(CLLocationManager *)manager
	  didUpdateHeading:(CLHeading *)newHeading{

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	gameStage.transform = CGAffineTransformMakeRotation(M_PI * (360 - newHeading.trueHeading) / 180.0f);
	[UIView commitAnimations];
}

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
	[gameStage setRegion:region animated:YES];
	
}
	

- (void)dealloc {
    [super dealloc];
}

-(IBAction) PingOut{
	
}

-(IBAction) MenuOut{
	
}


@end
