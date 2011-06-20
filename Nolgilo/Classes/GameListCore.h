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
}
-(void)RoomListData;
-(NSInteger)GetCount;
-(NSString *)GetMainTitle:(int)number;
-(NSString *)GetSubTitle:(int)number;
-(NSString *)GetState:(int)number;
@end
