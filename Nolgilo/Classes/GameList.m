//
//  GameList.m
//  Nolgilo
//
//  Created by GatGong on 11. 5. 30..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameList.h"


@implementation GameList

- (NSArray *)SetGameList {
    NSArray *gameList;
    gameList = [[NSArray alloc] initWithObjects:@"육개장", @"삼선 짬뽕", @"물만두", @"만안전석", @"칠리새우", @"짜장면",nil];
	
	return gameList;
}
@end
