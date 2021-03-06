//
//  PingGameCore.m
//  Nolgilo
//
//  Created by GatGong on 11. 4. 12..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "PingGameCore.h"
#import "JSON.h"
#import <math.h>

@implementation PingGameCore

@synthesize datalist, pingdata;

-(DBcore *) db
{
	if(!db){
		db = [[DBcore alloc] init];
	}
	return db;
}

#pragma mark -
#pragma mark 메세지 출력 부분

-(void) GameInitMessage{
	
	baseAlert = [[UIAlertView alloc] 
				 initWithTitle:@"게임 준비중"
				 message:@"게임을 준비하고 있습니다.\n 잠시만 기다려주세요"
				 delegate:self 
				 cancelButtonTitle:nil
				 otherButtonTitles:nil];
	
	[NSTimer scheduledTimerWithTimeInterval:3.0
									 target:self
								   selector:@selector(performDismiss:)
								   userInfo:nil
									repeats:NO
	 ];
	
    
	[baseAlert show];	
	
    
}

-(void) performDismiss: (NSTimer *)timer{
	
	[baseAlert dismissWithClickedButtonIndex:0 animated:NO];
}

#pragma mark -
#pragma mark ImageView Fade in/out

-(void)fadeView:(UIView *) v: (BOOL) appare{
	if(appare){
		v.alpha = 0;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		v.alpha = 1;
		[UIView commitAnimations];
	}else {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		v.alpha = 0;
		[UIView commitAnimations];
	}
	
}

#pragma mark -
#pragma mark 진행 관련 부분

// 함수명 : init
// 리턴값 : void
// PingGameCore를 초기화 시켜주는 함수
// lat:(double)자신의 위도 / log:(double)자신의 경도 / team:(NSString)자신이 속한 팀

-(void)init:(double)lat
		   :(double)log
           :(NSInteger)roomid{
    
	mylat = lat;
	mylog = log;
	myroomid = roomid;
	
	
    //	NSArray *coredata = [[self db] DataBaseConnect:team]; //다른팀의 정보를 가지고 온다.
    //    [self DataSetting:coredata]; //가져온 정보를 정제한다.
}

// 함수명 : setScore
// 리턴값 : void
// 스코어를 갱신해 주는 역할을 한다.

-(void)SetScore:(NSString *)teamid :(long)score{
    [[self db] SetScore:teamid:score:myroomid];
}

// 함수명 : setTeamLabel
// 리턴값 : NSString
// 유저의 팀 라벨을 설정하는 역할을 한다.

- (NSString *)SetTeamLabel:(NSString *)teamid{
	NSString *teamlabel = [NSString stringWithFormat:@"Team%@.png", teamid];
	return teamlabel;
}

// 함수명 : SetQRImage
// 리턴값 : NSString
// 유저의 팀의 정보가 담긴 QR코드를 설정하는 역할을 한다.

- (NSString *)SetQRImage:(NSString *)teamid{
	NSString *teamQR = [NSString stringWithFormat:@"pingteam%@.png", teamid];
	return teamQR;
}

// 함수명 : GetState
// 리턴값 : int
// 자신의 현재 상태를 알아내는 역할을 한다.
// 0 : 상대방에게 잡혔다. 
// 1 : 살아있는 상태
// 2 : 게임에서 나간 경우

-(int)GetState:(NSString *)teamid{
    int state;
    state = [[self db]GetState:teamid:myroomid];
    
    return state;
}

//함수명 : GetTeamName
//리턴값 : NSString : 어떤 팀인지를 확인해 준다.
//인자값 : (int)teamnumber : 몇번째 팀인지 알려준다.
-(NSString *)GetTeamName:(int)teamnumber
{
	NSString *teamname;
	NSDictionary *team = [datalist objectAtIndex:teamnumber];
	teamname = [team objectForKey:@"userid"];
	
//	teamname = [datalist objectAtIndex:teamnumber];
	
	return teamname;
}

-(bool)GetTeamState:(int)teamnumber{
    bool teamstate;
    NSString *state;
    
	NSDictionary *team = [datalist objectAtIndex:teamnumber];
	state = [team objectForKey:@"state"];
    if([state isEqualToString:@"1"]){
        teamstate = TRUE;
    }
    else{
        teamstate = FALSE;
    }
	
	return teamstate;
}

-(double)GetLat:(int)teamnumber{
	double teamlat;
	NSDictionary *team = [datalist objectAtIndex:teamnumber];
	
//	NSArray *location = [[datalist objectAtIndex:teamnumber+2] 
//						 componentsSeparatedByString: @"/"];
	
	teamlat = [[team objectForKey:@"latitude"] doubleValue];
	return teamlat;

}
-(double)GetLog:(int)teamnumber{
	double teamlog;
	NSDictionary *team = [datalist objectAtIndex:teamnumber];
//	NSArray *location = [[datalist objectAtIndex:teamnumber+2] 
//						 componentsSeparatedByString: @"/"];

	teamlog = [[team objectForKey:@"longitude"] doubleValue];
//	teamlog = [[location objectAtIndex:1] doubleValue];
	return teamlog;
}

//함수명 : SetArrowImage
//리턴값 : (NSSting)화살표 이미지 이름
//상대방의 거리에 따른 화살표 이미지 정보
//dis:(double)상대방과 남은 거리, set:(double)맵 크기에 따른 증감값

-(NSString *)GetArrowImage:(double)dis
						  :(double)set{
	NSString *arrowimage;
	
	if(dis >(0.06+set)){
		arrowimage = @"xl_arrow.png";
	}
	else if(dis >(0.005+set)){
		arrowimage = @"l_arrow.png";
	}
	else if(dis > (0.003+set)){
		arrowimage = @"m_arrow.png";
	}
	else if(dis > (0.002+set)){
		arrowimage = @"xm_arrow.png";
	}
	else if(dis > (0.001+set)){
		arrowimage = @"s_arrow.png";
	}
	else {
		arrowimage = @"vs_arrow.png";
	}
	
	return arrowimage;
}

//함수명 : SetDistance
//리턴값 : (double)거리
//상대방과 내 위치를 비교하여 거리를 계산한다. 
//(double)o_lat : 상대방의 위도, (double) o_log : 상대방의 경도

-(double)GetDistance:(double)o_lat
					:(double)o_log{
	double dx = mylat - o_lat;
	double dy = mylog - o_log;
	
	double dis = sqrt(pow(dx, 2.0)+pow(dy, 2.0));
	
	return dis;
}

//함수명 : SetRadian
//리턴값 : (double)각도
//상대방과 내 위치를 비교하여 각도를 구한다.
//(double)o_lat : 상대방의 위도, (double) o_log : 상대방의 경도

-(double)GetRadian:(double)o_lat
				  :(double)o_log{

	double dx = mylat - o_lat;
	double dy = mylog - o_log;

	float angle = atan2(dy, dx)*(180/M_PI)+180;
	double radian = angle*(2.0 * M_PI / 360.0);
	
	return radian;
	
}

//함수명 : SetTeamLabel
//리턴값 : (NSString)이름
//상대방의 화살표에 맞는 이름을 출력한다.
//(NSString)name:상대방 팀 네임 / (NSString)arrowname:화살표 이름

-(NSString *)GetTeamLabel:(NSString *)teamName
						 :(NSString *)arrowImage{
	
	NSString *nameFormat;
	
	if([arrowImage isEqualToString: @"vs_arrow.png"]){
		nameFormat = [NSString stringWithFormat:@"%@\n\n\n\n", teamName];
	}
	else if([arrowImage isEqualToString: @"s_arrow.png"]){
		nameFormat = [NSString stringWithFormat:@"%@\n\n\n\n\n", teamName];
	}
	else if([arrowImage isEqualToString: @"xm_arrow.png"]){
		nameFormat = [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n", teamName];
	}
	else{
		nameFormat = [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n", teamName];
	}
	
	return nameFormat;
	
}

//함수명 : DataSetting
//리턴값 : void
//각팀에 대한 정보를 Setting한다.
//(NSString)datastring:json으로 받은 데이터

/*
-(void)DataSetting:(NSArray *)datastring{
	NSDictionary *response = [datastring JSONValue];
	
	NSArray *sourceData = [datastring componentsSeparatedByString: @":"];
	datalist = [NSMutableArray arrayWithCapacity:[sourceData count]];
	[datalist setArray:sourceData];
}
 */

//함수명 : GetTeam
//리턴값 : void
//팀을 잡게되면 호출되는 함수, 팀 이름을 받아와 유효성을 검사하고, 맞을경우 서버에 상대팀을 목록에서 삭제한다.
//teamid:(NSString) 잡은 팀의 이름

-(bool)GetTeam:(NSString *)teamid{
	if([[self db] TeamCatch:teamid:myroomid]){
		return TRUE;
	}
	else{
		return FALSE;
	}
	
}
-(void)InitLoc:(NSString *)teamid
              :(double)lat
              :(double)log{	
	[[self db] initMyLoc:teamid:lat:log:myroomid];
}

-(void)UpdateLoc:(NSString *)teamid
				:(double)lat
				:(double)log{	
	[[self db] PostMyLoc:teamid:lat:log:myroomid];
}

-(void)ConnectDB:(NSString *)team{    
    //DB를 연결시킨다.
    self.datalist = [[self db] DataBaseConnect:team:myroomid];
}

-(void)PingCheckEnd:(NSString *)teamid:(NSString *)pingid{
    NSString *pingteam;
    pingteam = [[self db]PingCheck:teamid :myroomid];
    
    if([pingteam isEqual:pingid]){
        [[self db]PingCheckEnd:teamid :myroomid];
    }
}

-(void)PingTeamInfo:(NSString *)teamid{
    self.pingdata = [[self db] PingTeamInfo:teamid:myroomid];
}

-(NSString *)PingCheck:(NSString *)teamid{
    NSString *pingteam;
    
    pingteam = [[self db] PingCheck:teamid:myroomid];

    return pingteam;
}

-(double) GetPingLat{
    double lat;
    lat = [[pingdata objectForKey:@"latitude"] doubleValue];
    
    return lat;
}
-(double) GetPingLog{
    double log;
    log = [[pingdata objectForKey:@"longitude"] doubleValue];
    
    return log;    
}

-(void)alterExit:(NSString *)teamid{
    [[self db] SetTeamStatus:teamid:myroomid:2];
}



#pragma mark -
#pragma mark 결과 결과 연산

- (int)GameResult:(NSString *)teamid{
    NSArray *scorelist;
    int maxscore, teamnum, teamscore;
    
    if([teamid isEqualToString:@"A"]){
        teamnum = maxscore = 0;
    }
    else if([teamid isEqualToString:@"B"]){
        teamnum = maxscore = 1;
    }
    else{
        teamnum = maxscore = 2;
    }
    
    scorelist = [[self db] GetScore:myroomid];
    teamscore = [[scorelist objectAtIndex:teamnum] intValue];
    
    for(int i = 0; i<3; i++){
        if(i != teamnum){
            if([[scorelist objectAtIndex:i] intValue] > teamscore){
                maxscore = i;
            }
        }
    }
    
    if(maxscore == teamnum){
        return 1;
    }
    else{
        return 2;
    }
}

- (void)dealloc {
	[datalist release];
    [pingdata release];
	[super dealloc];
}
@end


