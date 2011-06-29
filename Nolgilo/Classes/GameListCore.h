//
//  GameListCore.h
//  Nolgilo
//
//  Created by goyange on 11. 6. 20..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBcore.h"


@interface GameListCore : NSObject {
	DBcore *db;
	
	NSArray *roomlist;
    
    NSMutableArray *idlist;
    NSMutableArray *maintitlelist;
    NSMutableArray *subtitlelist;
    NSMutableArray *consuerlist;
    NSMutableArray *statelist;
    
    NSInteger count;
    int roomid;
}
-(void)RoomListData;
-(NSInteger)GetCount;
-(NSString *)GetMainTitle:(int)number;
-(NSInteger)GetRoomid;
-(NSString *)GetSubTitle:(int)number;
-(NSString *)GetState:(int)number;
-(bool)GetRoomState:(int)number;
-(int)GetConnectUser:(int)number;
-(void)RoomExit:(int)number;
@end
