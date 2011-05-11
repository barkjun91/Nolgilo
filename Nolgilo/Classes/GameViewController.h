//
//  GameViewController.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 17..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapViewController;

@interface GameViewController : UIViewController {
	
	MapViewController* mapViewController;
	
	IBOutlet UITabBar *tabBar;
	IBOutlet UITabBarItem *tabBaritem;
//	UIViewController *selectViewController;
	
}

@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBaritem;

//@property (nonatomic, retain) UIViewController *selectViewController;


@end
