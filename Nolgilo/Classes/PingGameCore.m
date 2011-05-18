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
	
	double dx = mylat - lat;
	double dy = mylog - log;
	double y = dy/dx;
	
	float angle;
	
	double dis = sqrt(pow(dx, 2.0)+pow(dy, 2.0));
	
	NSLog(@"dx : %f , dy : %f, y : %f", dx, dy, y);
	
	angle = atan2(dy, dx)*(180/M_PI)+180;
	
	if([teamName isEqualToString: team1.TeamName]){
		team1.radian = angle*(2.0 * M_PI / 360.0);
	}
	else {
		team2.radian = angle*(2.0 * M_PI / 360.0);
	}

	if(dis > 0.06){
		return @"xl_arrow";
	}
	if(dis > 0.005){
		return @"l_arrow";
	}
	if(dis > 0.003){
		return @"m_arrow";
	}
	if(dis > 0.002){
		return @"xm_arrow";
	}
	else if(dis > 0.001){
		return @"s_arrow";
	}
	else if(dis < 0.0005){
		if([teamName isEqualToString: team1.TeamName]){
			team1.catchteam = TRUE;
		}
		else {
			team2.catchteam = TRUE;
		}
	}
	return @"vs_arrow";
}


-(NSString *) TeamNameSet:(NSString *) teamName
						 :(NSString *) arrowImage{

	if([arrowImage isEqualToString: @"vs_arrow"]){
		return [NSString stringWithFormat:@"%@\n\n\n\n", teamName];
	}
	else if([arrowImage isEqualToString: @"s_arrow"]){
		return [NSString stringWithFormat:@"%@\n\n\n\n\n", teamName];
	}
	else if([arrowImage isEqualToString: @"xm_arrow"]){
		return [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n", teamName];
	}
	return [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n", teamName];
}

-(NSString *) InfoRead{
	
	NSString * sql = [NSString
					  stringWithFormat:
					  @"%s:%s:%s:%s:%s:%s","B","C","37.550413/126.921336","37.549533/126.918680","1","1"];
	//파라미터 
	//초콜릿집ㅋㅋㅋ : 37.549533/126.918680
	//숭실대 할리스커피 : 37.4951027/126.957455
	//강원도쪽 어딘가 : 37.31885/127.692683
	//숭실대입구역 : 37.496325/126.953588
	//전산원 : 37.495336/126.959347
    //홍대 조폭떡볶이 : 37.550413/126.921336
	//마니산 : 37.611602/126.434827
	return sql;
}
-(NSMutableArray *)DataSetting:(NSString *)data{
	NSArray *sourceData = [data componentsSeparatedByString: @":"];
	NSMutableArray *datalist = [NSMutableArray arrayWithCapacity:[sourceData count]];
	[datalist setArray:sourceData];
	team1.TeamName = [datalist objectAtIndex:0];
	team2.TeamName = [datalist objectAtIndex:1];
	team1.live = [[datalist objectAtIndex:4] boolValue];
	team2.live = [[datalist objectAtIndex:5] boolValue];
	
	return datalist;
}

-(double)SetAngle:(NSString *)teamName{
	if([teamName isEqualToString: team1.TeamName]){
		return team1.radian;
	}
	else {
		return team2.radian;
	}
}

-(NSMutableArray *) SearchOtherTeam:(double)lat:(double)log:(NSString *)team{
	/* 각각TEAM에 대한 위도 경도 조사*/
	mylat = lat;
	mylog = log;
	NSString *coredata = [self InfoRead]; //자료 input예시
	NSMutableArray *coredatalist= [self DataSetting:coredata];
	[coredatalist replaceObjectAtIndex:2 withObject:[self ArrowImageSetting:[coredatalist objectAtIndex:2]:[coredatalist objectAtIndex:0]]];
	[coredatalist replaceObjectAtIndex:3 withObject:[self ArrowImageSetting:[coredatalist objectAtIndex:3]:[coredatalist objectAtIndex:1]]];
	return coredatalist;
	
}

-(NSString *)CatchCheck{

	if ( team1.catchteam && team1.live){
		return @"team1";
		team1.live = FALSE;
	}
	else if ( team2.catchteam && team2.live){
		return @"team2";
		team2.live = FALSE;
	}
	else{
		return @"none";
	}
}
@end
