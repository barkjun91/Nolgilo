//
//  PingGameCore.m
//  Nolgilo
//
//  Created by GatGong on 11. 4. 12..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "PingGameCore.h"
#import <math.h>

@implementation PingGameCore


-(NSString *) ArrowImageSetting:(NSString *)location:(NSString *)teamName{
	NSArray *locdatalist = [location componentsSeparatedByString:@"/"];
	
	double lat = [[locdatalist objectAtIndex:0] doubleValue];
	double log = [[locdatalist objectAtIndex:1] doubleValue];
	
	double dx = fabs(mylat - lat);
	double dy = fabs(mylog - log);
	double y = dy/dx;
	
	NSLog(@"%f - %f = %f", mylat, lat, dx);
	NSLog(@"%f - %f = %f", mylog, log, dy);

	
	double dis = sqrt(pow(dx, 2.0)+pow(dy, 2.0));
	
	if([teamName isEqualToString: @"B"]){
		team1.angle = atan(y)*(180/M_PI);
			NSLog(@"%f", team1.angle);
	}
	else {
		team2.angle = atan(y)*180/M_PI;
	}

	
	dis = round(fmod(dis,0.01)*1000000)/100;
	
	if(dis > 12){
		return @"arrow";
	}
	
	return @"arrow";
}


-(NSString *) InfoRead{
	NSString * sql = [NSString
					  stringWithFormat:
					  @"%s:%s:%s:%s","B","C","37.547607/126.915652","37.547607/126.913652"];
	
	return sql;
}
-(NSMutableArray *)DataSetting:(NSString *)data{
	NSArray *sourceData = [data componentsSeparatedByString: @":"];
	NSMutableArray *datalist = [NSMutableArray arrayWithCapacity:[sourceData count]];
	[datalist setArray:sourceData];
	team1.TeamName = [datalist objectAtIndex:0];
	team2.TeamName = [datalist objectAtIndex:1];
	
	
	return datalist;
}

-(double)SetAngle:(NSString *)teamName{
	if([teamName isEqualToString: @"B"]){
		return team1.angle;
	}
	else {
		return team2.angle;
	}
}

-(NSMutableArray *) SearchOtherTeam:(double)lat:(double)log:(NSString *)team{
	/* 각각TEAM에 대한 위도 경도 조사*/
	mylat = lat;
	mylog = log;
	NSString *coredata = [self InfoRead]; //자료 input예시
	NSMutableArray *coredatalist= [self DataSetting:coredata];
	[coredatalist replaceObjectAtIndex:2 withObject:[self ArrowImageSetting:[coredatalist objectAtIndex:2]:[coredatalist objectAtIndex:0]]];

	return coredatalist;
	
}


@end
