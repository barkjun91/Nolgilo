//
//  DBcon.m
//  Nolgilo
//
//  Created by goyange on 11. 5. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DBcore.h"
#import "JSON.h"

@implementation DBcore



/* --- 핑게임 관련 부분 함수 ----*/
-(void)alterExit:(NSString *)teamid :(NSInteger)roomid{
    NSString *url = [NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d&state=%d", teamid, roomid, 2];
    NSURL *exit_url = [NSURL URLWithString:url];
	NSString *response = [NSString stringWithContentsOfURL:exit_url encoding:NSUTF8StringEncoding error:NULL];
}

-(NSDictionary *)PingTeamInfo:(NSString *)teamid
                   :(NSInteger)roomid{
    NSURL *test_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d",teamid,roomid]];
	NSString *response = [NSString stringWithContentsOfURL:test_url encoding:NSUTF8StringEncoding error:NULL];
    
    //	NSLog(@"response : %@", response);
    //  NSLog(@"%@ %@ %d", team1, team2, roomid);
    
    NSDictionary *responseDic = [response JSONValue];
    
    return responseDic;
}

-(void)PingCheckEnd:(NSString *)teamid
                    :(NSInteger)roomid
{
    NSURL *ping_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d&ping=0",teamid,roomid]];
    NSString *response = [NSString stringWithContentsOfURL:ping_url encoding:NSUTF8StringEncoding error:NULL];
}

-(NSString *)PingCheck:(NSString *)teamid 
                      :(NSInteger)roomid{
    NSString *pingteam;
    NSURL *ping_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d",teamid,roomid]];
    NSString *response = [NSString stringWithContentsOfURL:ping_url encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *responseDic = [response JSONValue];
    
    pingteam = [responseDic objectForKey:@"ping"];
    
    return pingteam;
}

-(void)PingOut:(NSString *)team1
              :(NSString *)team2
              :(NSString *)myteam
              :(NSInteger)roomid{
    NSURL *ping_url =  [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d&ping=%@",team1,roomid,myteam]];
    NSString *response = [NSString stringWithContentsOfURL:ping_url encoding:NSUTF8StringEncoding error:NULL];
    
    ping_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d&ping=%@",team2,roomid,myteam]];
	response = [NSString stringWithContentsOfURL:ping_url encoding:NSUTF8StringEncoding error:NULL];
    
    NSLog(@"정상적으로 핑이 쏴졌습니다.");
}
-(NSArray *) OtherTeamData:(NSString *)team1
                          :(NSString *)team2
                          :(NSInteger)roomid{
	
    NSURL *test_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d",team1,roomid]];
	NSString *response = [NSString stringWithContentsOfURL:test_url encoding:NSUTF8StringEncoding error:NULL];
    
    //	NSLog(@"response : %@", response);
    //  NSLog(@"%@ %@ %d", team1, team2, roomid);
    
    NSDictionary *responseDic = [response JSONValue];
	NSMutableArray *data = [NSMutableArray arrayWithCapacity:2];
	[data addObject:responseDic];
    
    test_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/test?id=%@&roomid=%d",team2,roomid]];
    
	response = [NSString stringWithContentsOfURL:test_url encoding:NSUTF8StringEncoding error:NULL];
    
    //	NSLog(@"response : %@", response);
	responseDic = [response JSONValue];
	[data addObject:responseDic];
	
	
	
    /*	NSString * sql = [NSString
     stringWithFormat:
     @"%s:%s:%s:%s:%s:%s","B","C","37.550413/126.921336","37.549533/126.918680","1","1"];*/
	//파라미터 
	//초콜릿집ㅋㅋㅋ : 37.549533/126.918680
	//숭실대 할리스커피 : 37.4951027/126.957455
	//강원도쪽 어딘가 : 37.31885/127.692683
	//숭실대입구역 : 37.496325/126.953588
	//전산원 : 37.495336/126.959347
    //홍대 조폭떡볶이 : 37.550413/126.921336
	//마니산 : 37.611602/126.434827
	
	return data;
	
}

-(NSArray *) DataBaseConnect:(NSString *)conteam
                            :(NSInteger)roomid{
	NSArray * datalist;
	
	if([conteam isEqualToString: @"A"])
	{
		datalist = [self OtherTeamData:@"B":@"C":roomid];
        [self PingOut:@"B":@"C":@"A":roomid];
	}
	else if([conteam isEqualToString: @"B"])
	{
		datalist = [self OtherTeamData:@"A":@"C":roomid];
        [self PingOut:@"A":@"C":@"B":roomid];
	}
	else
	{
		datalist = [self OtherTeamData:@"A":@"B":roomid];
        [self PingOut:@"A":@"B":@"C":roomid];
	}
	
	return datalist;
	
}

-(NSString *) SpotData:(NSInteger)roomid{
	NSString * sql = [NSString
					  stringWithFormat:
					  //순서-이름-좌표-스코어/ 
					  @"%s", "1-홍대떡뽁이-37.550413/126.921336-20"];
	return sql;
}

-(void) SpotGet{
	
}
-(void)initMyLoc:(NSString *)teamid 
                :(double)lat
                :(double)log 
                :(NSInteger)roomid{
    NSString *json = [NSString stringWithFormat:@"http://localhost:8888/test?id=%@&latitude=%f&longitude=%f&roomid=%d&state=1&ping=0",teamid,lat,log,roomid];
	NSLog(@"%@", json);
    
	NSURL *url = [NSURL URLWithString:json];
	NSString *response = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];

}
-(void)PostMyLoc:(NSString *)teamid
				:(double) lat
				:(double) log
                :(NSInteger)roomid{
    
	 NSString *json = [NSString stringWithFormat:@"http://localhost:8888/test?id=%@&latitude=%f&longitude=%f&roomid=%d",teamid,lat,log,roomid];
	
	NSURL *url = [NSURL URLWithString:json];
	NSString *response = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
    
    //	NSLog(@"reponse : %@", response);
	
}

-(bool)GetTeamStatus:(NSString *)teamid{
	return YES;
}

//함수명 : TeamCatch
//리턴값 : bool
//상대팀이 잡혀있는 상태면 False를 반환하고,
//만일 상대팀이 잡혀있지 않는 상태라면, 상대팀을 잡았다는 명령을 날린후, TRUE반환.
-(bool) TeamCatch:(NSString *)teamid:(NSInteger)roomid{
	return TRUE;
}


/* --- 대기룸 관련 부분 함수 ----*/


-(void)RoomClose:(int)roomid{
    
    NSString *json = [NSString stringWithFormat:@"http://localhost:8888/room?roomid=%d&connuser=%d",roomid];
    
	NSURL *url = [NSURL URLWithString:json];
	NSString *response = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
	NSLog(@"reponse : %@", response); 
}

-(NSArray *) RoomListData{
	 
    NSURL *test_url = [NSURL URLWithString:@"http://localhost:8888/room?roomid=ALL"];
	NSString *response = [NSString stringWithContentsOfURL:test_url encoding:NSUTF8StringEncoding error:NULL];
	NSArray *data = [response JSONValue];
	
	return data;
}

-(void)RoomConnectUpdate:(int)roomid:(int)connuser{
    NSString *json = [NSString stringWithFormat:@"http://localhost:8888/room?roomid=%d&connuser=%d",roomid,connuser];
	NSURL *url = [NSURL URLWithString:json];
	NSString *response = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
	NSLog(@"reponse : %@", response);    
}

-(int)RoomConnectUser:(int)roomid{
    int connect;
    
    NSString *json = [NSString stringWithFormat:@"http://localhost:8888/room?roomid=%d",roomid];
	NSURL *url = [NSURL URLWithString:json];
	NSString *response = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *responseDic = [response JSONValue];
    
    connect = [[responseDic objectForKey:@"connuser"] intValue];
    return connect;
}

@end