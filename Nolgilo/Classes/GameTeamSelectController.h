//
//  GameTeamSelectController.h
//  Nolgilo
//
//  Created by GatGong on 11. 5. 30..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PingGameViewController;

@interface GameTeamSelectController : UIViewController {
	PingGameViewController* pingGameViewController;
	NSString* selectTeam;
}


-(IBAction) teamAselect;
-(IBAction) teamBselect;
-(IBAction) teamCselect;
@end
