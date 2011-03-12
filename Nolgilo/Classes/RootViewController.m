    //
//  RootViewController.m
//  Nolgilo
//
//  Created by goyange on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "LoadingViewController.h"
#import "MapViewController.h"



LoadingViewController* g_LoadingViewController = nil;
MapViewController* g_MapViewController = nil;

@implementation RootViewController


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	g_LoadingViewController = [[LoadingViewController alloc] initWithNibName:@"LoadingViewController" bundle:nil];
	g_MapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
	
	
	[self.view addSubview:g_LoadingViewController.view];
}



- (IBAction) TitleOnFlipView 
{
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	
	[self.view addSubview:g_MapViewController.view];
	[UIView commitAnimations];

}

@end