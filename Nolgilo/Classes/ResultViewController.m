//
//  ResultViewController.m
//  Nolgilo
//
//  Created by goyange on 11. 6. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "GameListViewController.h"

@implementation ResultViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    gameListViewController = [[GameListViewController alloc] initWithNibName:@"GameListViewController" bundle:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)resultinit:(NSString *)teamid :(long)sc:(NSString *)state{
    teamNameLabel.text = teamid;
    scoreLabel.text = [NSString stringWithFormat:@"%ld", sc];
    if([state isEqualToString:@"Exit"] || [state isEqualToString:@"Lose"]){
        result.image = [UIImage imageNamed:@"Lose.png"];
    }
    else{
        result.image = [UIImage imageNamed:@"win.png"];
    }
}

-(IBAction) goRoomList{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	[self.view addSubview:gameListViewController.view];
	[UIView commitAnimations];
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
@end
