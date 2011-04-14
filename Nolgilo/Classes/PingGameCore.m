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


-(double) Distance:(double)lat:(double)log{
	
	/*두 점사이의 거리 구하긔*/
	double dis = sqrt(pow((mylat-lat), 2.0)
					  +pow((mylog-log), 2.0));
	return dis;
	
}

-(NSString *) ArrowImageSetting:(NSString *)location{
	NSArray *locdatalist = [location componentsSeparatedByString:@"/"];
//	NSLog(@"%@ %@\n", [locdatalist objectAtIndex:0], [locdatalist objectAtIndex:1]);
	
	double lat = [[locdatalist objectAtIndex:0] doubleValue];
	double log = [[locdatalist objectAtIndex:1] doubleValue];
	
	double dis = [self Distance:lat:log];
	
	dis = round(fmod(dis,0.01)*1000000)/100;
	if(dis > 12){
		return @"arrow";
	}
	return @"arrow";
}
/*
-(double)SetAngle{
//	double angle = acos(
//	return angle;
}
*/
-(NSString *) InfoRead{
	NSString * sql = [NSString
					  stringWithFormat:
					  @"%@:%@:%@:%@",@"B",@"C",@"37.547607/126.913552",@"37.547607/126.913652"];
	
	return sql;
}

-(NSMutableArray *) SearchOtherTeam:(double)mylat:(double)mylog:(NSString *)TeamName{
	/* 각각TEAM에 대한 위도 경도 조사*/
	
	NSString *coredata = [self InfoRead]; //자료 input예시
	NSMutableArray *coredatalist = [coredata componentsSeparatedByString: @":"];

	[coredatalist replaceObjectAtIndex:2 withObject:[self ArrowImageSetting:[coredatalist objectAtIndex:2]]];
	[coredatalist replaceObjectAtIndex:3 withObject:[self ArrowImageSetting:[coredatalist objectAtIndex:3]]];
	
	return coredatalist;
	
}



@end
