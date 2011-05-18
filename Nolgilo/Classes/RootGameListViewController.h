//
//  RootGameListViewController.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 29..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootGameListViewController : UIViewController<UINavigationControllerDelegate>{
	IBOutlet UIView *window;
	IBOutlet UINavigationController * navController;
}

@property (nonatomic, retain) IBOutlet UIView *window;
@property (nonatomic, retain) IBOutlet UINavigationController * navController;


@end
