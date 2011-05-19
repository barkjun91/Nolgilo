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
	NSMutableArray *datalist;
	double mylat;
	double mylog;
	
	DBcore *db;
}

-(void) init:(double)lat:(double)log:(NSString *)name;
-(NSString *)GetTeamName:(int)teamnumber;
-(NSString *)GetArrowImage:(double)dis:(double)set;
-(double)GetDistance:(double)o_lat:(double)o_log;
-(double)GetLat:(int)teamnumber;
-(double)GetLog:(int)teamnumber;
-(double)GetRadian:(double)o_lat:(double)o_log;
-(NSString *)GetTeamLabel:(NSString *)teamName:(NSString *)arrowImage;
@end
