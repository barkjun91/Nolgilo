//
//  DBcon.h
//  Nolgilo
//
//  Created by goyange on 11. 5. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DBcore : NSObject {
}


-(NSArray *) DataBaseConnect:(NSString *)conteam;
-(NSArray *) RoomListData;
-(bool)TeamCatch:(NSString *)teamid;
-(void)PostMyLoc:(NSString *)teamid :(double)lat :(double)log;
-(NSString *) SpotData;

@end
