    //
//  RootViewController.m
//  Nolgilo
//
//  Created by goyange on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "LoadingViewController.h"
#import "GameTeamSelectController.h"
#import "GameListViewController.h"

@implementation RootViewController


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	loadingViewController = [[LoadingViewController alloc] initWithNibName:@"LoadingViewController" bundle:nil];
	gameListViewController = [[GameListViewController alloc] initWithNibName:@"GameListViewController" bundle:nil];
	
//	gameTeamSelectController = [[GameTeamSelectController alloc] initWithNibName:@"GameTeamSelectController" bundle:nil];
	[self.view addSubview:loadingViewController.view];
}



- (IBAction) TitleOnFlipView 
{

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
//	[self.view addSubview:gameTeamSelectController.view];
	[self.view addSubview:gameListViewController.view];
	[loadingViewController.view removeFromSuperview];
	
	[UIView commitAnimations];

}

@end