//
//  DBcon.m
//  Nolgilo
//
//  Created by goyange on 11. 5. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DBcore.h"

@implementation DBcore



-(NSString *) OtherTeamData:(NSString *)team1
						   :(NSString *)team2{
	
	NSURL *team1_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@",team1]];
	NSURL *team2_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@",team2]];
	
	
	
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

-(NSString *) DataBaseConnect:(NSString *)conteam{
	NSString * datalist;
	
	if([conteam isEqualToString: @"A"])
	{
		datalist = [self OtherTeamData:@"B":@"C"];
	}
	else if([conteam isEqualToString: @"B"])
	{
		datalist = [self OtherTeamData:@"A":@"C"];
	}
	else
	{
		datalist = [self OtherTeamData:@"A":@"B"];
	}
	
	return datalist;
	
}

-(NSString *) SpotData{
	NSString * sql = [NSString
					  stringWithFormat:
					  //순서-이름-좌표-스코어/ 
					  @"%s", "1-숭실대입구역-37.496325/126.953588-20"];
	return sql;
}

-(void) SpotGet{
	
}

-(void)PostMyLoc:(NSString *)teamid
				:(double) lat
				:(double) log{
	NSString *json = [NSString stringWithFormat:@"http://localhost:8888/test?id=%@&latitude=%f&longitude=%f",teamid,lat,log];
	[NSURL URLWithString:json];
}
	

-(void)Update:(NSTimer *)timer{
	[[self ping] UpdateLoc:info.teamid 
						  :location.latitude 
						  :location.longitude];
	NSLog(@"update");
}

-(bool)GetTeamStatus:(NSString *)teamid{
	return YES;
}

//함수명 : TeamCatch
//리턴값 : bool
//상대팀이 잡혀있는 상태면 False를 반환하고,
//만일 상대팀이 잡혀있지 않는 상태라면, 상대팀을 잡았다는 명령을 날린후, TRUE반환.
-(bool) TeamCatch:(NSString *)teamid{
	return TRUE;
}

@end