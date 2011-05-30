//
//  GameInfoViewController.m
//  Nolgilo
//
//  Created by GatGong on 11. 3. 29..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameInfoViewController.h"


@implementation GameInfoViewController

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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

-(void)ReQuestion:(NSString *)teamid{
	
	UIAlertView *message = [[UIAlertView alloc]
							initWithTitle:@"팀선택"
							message:[NSString stringWithFormat:@"정말로 %@팀을 선택하실건가요?", teamid]
							delegate:nil
							cancelButtonTitle:@"아니오"
							otherButtonTitles:@"예",nil];
	[message show];
	[message release];
};

-(IBAction)TeamAselect{
	NSLog(@"asdf");
//	[self ReQuestion:@"A"];
}
-(IBAction)TeamBselect{
//	[self ReQuestion:@"B"];
}
-(IBAction)TeamCselect{
//	[self ReQuestion:@"C"];
}
@end
