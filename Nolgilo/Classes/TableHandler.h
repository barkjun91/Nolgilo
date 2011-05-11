//
//  TableHandler.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 31..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"

@class RootViewController;

@interface TableHandler : NSObject <UITableViewDelegate, UITableViewDataSource>{
	NSArray * tableDataList;
	RootViewController *rootView;
}

@property (nonatomic, retain) NSArray * tableDataList;
@property (nonatomic, retain) RootViewController *rootView;

- (void) fillList;

@end
