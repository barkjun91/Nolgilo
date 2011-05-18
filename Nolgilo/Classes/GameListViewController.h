//
//  GameListViewController.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 29..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableHandler.h"

@interface GameListViewController : UIViewController {
	IBOutlet TableHandler * list;
}
@property (nonatomic, retain) IBOutlet TableHandler * list;

@end
