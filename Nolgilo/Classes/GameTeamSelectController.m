//
//  GameTeamSelectController.m
//  Nolgilo
//
//  Created by GatGong on 11. 5. 30..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameTeamSelectController.h"
#import "PingGameViewController.h"

@implementation GameTeamSelectController

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
	pingGameViewController = [[PingGameViewController alloc] initWithNibName:@"PingGameViewController" bundle:nil];
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


- (void)dealloc {
    [super dealloc];
}

- (void) GameStart:(NSString *)teamid
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	[self.view addSubview:pingGameViewController.view];
	[pingGameViewController userinit:teamid];
	[UIView commitAnimations];
}

-(void)messageBox:(NSString *)teamid{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"팀 선택" 
													message:[NSString stringWithFormat:@"정말로 %@팀을 선택하실건가요?", teamid]
												   delegate:self
										  cancelButtonTitle:@"No"
										  otherButtonTitles:@"Yes", nil];
	[alert show];
	[alert release];	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex){
		[self GameStart:selectTeam];
	}
}
-(IBAction) teamAselect{
	selectTeam = @"A";
	[self messageBox:@"A"];
}
-(IBAction) teamBselect{
	selectTeam = @"B";
	[self messageBox:@"B"];
}
-(IBAction) teamCselect{
	selectTeam = @"C";
	[self messageBox:@"C"];
}
@end
