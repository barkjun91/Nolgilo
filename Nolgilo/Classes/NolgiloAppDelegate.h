//
//  NolgiloAppDelegate.h
//  Nolgilo
//
//  Created by goyange on 11. 2. 10..
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface NolgiloAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    IBOutlet RootViewController* root;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

