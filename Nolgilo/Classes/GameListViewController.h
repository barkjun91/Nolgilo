//
//  GameListViewController.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 29..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameList.h"

@interface GameListViewController : UIViewController {
	GameList *gamelist;
	IBOutlet UITableView *list;
	
}

@end
