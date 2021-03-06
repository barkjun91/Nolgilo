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

/* --- 핑게임 관련 부분 함수 ----*/
-(NSArray *) DataBaseConnect:(NSString *)conteam:(NSInteger)roomid;
-(bool)TeamCatch:(NSString *)teamid:(NSInteger)roomid;
-(void)PostMyLoc:(NSString *)teamid :(double)lat :(double)log:(NSInteger)roomid;
-(void)initMyLoc:(NSString *)teamid :(double)lat :(double)log:(NSInteger)roomid;
-(void)PingOut:(NSString *)team1:(NSString *)team2:(NSString *)myteam:(NSInteger)roomid;
-(NSString *)PingCheck:(NSString *)teamid:(NSInteger)roomid;
-(void)PingCheckEnd:(NSString *)teamid:(NSInteger)roomid;
-(NSDictionary *)PingTeamInfo:(NSString *)teamid:(NSInteger)roomid;
-(void)SetTeamStatus:(NSString *)teamid:(NSInteger)roomid:(int)state;
-(int)GetState:(NSString *)teamid:(NSInteger)roomid;
- (void)SetScore:(NSString *)teamid:(long)score:(NSInteger)roomid;
-(int)GameChecking:(NSInteger)roomid;
-(NSArray *) GetScore:(NSInteger) roomid;

/* --- 대기룸 관련 부분 함수 ----*/
-(NSArray *) RoomListData;
-(void)RoomConnectUpdate:(int)roomid:(int)connuser;
-(int)RoomConnectUser:(int)roomid;
-(void)RoomClose:(int)roomid;
@end
