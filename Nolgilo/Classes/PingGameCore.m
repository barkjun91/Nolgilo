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
-(NSMutableArray *)DataSetting:(NSString *)data{
	NSArray *sourceData = [data componentsSeparatedByString: @":"];
	NSMutableArray *datalist = [NSMutableArray arrayWithCapacity:[sourceData count]];
	[datalist setArray:sourceData];
	team1.TeamName = [datalist objectAtIndex:0];
	team2.TeamName = [datalist objectAtIndex:1];
	
	
	return datalist;
}
-(NSMutableArray *) SearchOtherTeam:(double)mylat:(double)mylog:(NSString *)teamName{
	/* 각각TEAM에 대한 위도 경도 조사*/

	
	NSString *coredata = [self InfoRead]; //자료 input예시
	NSMutableArray *coredatalist= [self DataSetting:coredata];

	NSLog(@"array %@",[coredatalist class]);
	
	[coredatalist replaceObjectAtIndex:2 withObject:[self ArrowImageSetting:[coredatalist objectAtIndex:2]]];
	
	return coredatalist;
	
}



@end
