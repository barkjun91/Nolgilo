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
-(NSString *)SetTeamName:(int)teamnumber;
-(NSString *)SetArrowImage:(double)dis:(double)set;
-(double)SetDistance:(double)o_lat:(double)o_log;
-(double)SetLat:(int)teamnumber;
-(double)SetLog:(int)teamnumber;
-(double)SetRadian:(double)o_lat:(double)o_log;

-(NSString *) SetTeamLabel:(NSString *)teamName:(NSString *)arrowImage;
@end
