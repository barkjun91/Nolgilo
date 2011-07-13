//
//  PingGameCore.h
//  Nolgilo
//
//  Created by GatGong on 11. 4. 12..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBcore.h"


@interface PingGameCore : NSObject {
	NSString * TeamName;
	
    NSArray *datalist;
    NSDictionary *pingdata;
    
	double mylat;
	double mylog;
	NSInteger myroomid;
    
	DBcore *db;
}

-(void)init:(double)lat:(double)log:(NSInteger)roomid;
-(void)ConnectDB:(NSString *)team;

-(NSString *)GetTeamName:(int)teamnumber;
-(bool)GetTeamState:(int)teamnumber;
-(NSString *)GetArrowImage:(double)dis:(double)set;
-(double)GetDistance:(double)o_lat:(double)o_log;
-(double)GetLat:(int)teamnumber;
-(double)GetLog:(int)teamnumber;
-(double)GetRadian:(double)o_lat:(double)o_log;
-(NSString *)GetTeamLabel:(NSString *)teamName:(NSString *)arrowImage;
-(bool)GetTeam:(NSString *)teamid;
-(int)GetState:(NSString *)teamid;
-(void)InitLoc:(NSString *)teamid :(double)lat :(double)log;
-(void)UpdateLoc:(NSString *)teamid :(double)lat :(double)log;

-(double) GetPingLat;
-(double) GetPingLog;

-(void)alterExit:(NSString *)teamid;
-(void)PingTeamInfo:(NSString *)teamid;

-(NSString *)PingCheck:(NSString *)teamid;
-(void)PingCheckEnd:(NSString *)teamid:(NSString *)pingid;

- (NSString *)SetTeamLabel:(NSString *)teamid;
- (NSString *)SetQRImage:(NSString *)teamid;
- (void)SetScore:(NSString *)teamid:(long)score;

- (bool)GameCheking:(NSString *)teamid;
- (int)GameResult:(NSString *)teamid;


@property (nonatomic, retain) NSArray *datalist;
@property (nonatomic, retain) NSDictionary *pingdata;

@end
