//
//  GameListCore.m
//  Nolgilo
//
//  Created by goyange on 11. 6. 20..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameListCore.h"


@implementation GameListCore

-(DBcore *)db{
	if(!db){
		db = [[DBcore alloc] init];
	}
	return db;
}
-(NSInteger)GetCount{
    //	NSLog(@"%@", roomlist);
    //   	NSLog(@"Call");
	return count;
}


-(void)ConnRoom:(int)number:(NSString *)state{
    int connectuser = [[consuerlist objectAtIndex:number] intValue]+1;
    
    if([state isEqualToString:@"join"]){
        connectuser = [[consuerlist objectAtIndex:number] intValue]+1;
    }
    else{
        connectuser = [[consuerlist objectAtIndex:number] intValue]-1;
    }
    [[self db] RoomConnectUpdate:[[idlist objectAtIndex:number] intValue]
                                :connectuser];
}

-(NSInteger)GetRoomid{
    return [[idlist objectAtIndex:roomid] intValue];
}

-(NSString *)GetMainTitle:(int)number;{
	NSString *maintitle=@"NULL";
    //	NSDictionary *data = [roomlist objectAtIndex:number];
    //	NSLog(@"%@", data);
    //	NSLog(@"%d", number);
    //	NSLog(@"Call");
    //	maintitle = [data objectForKey:@"maintitle"];	
    //	NSLog(@"%@", maintitle);
    maintitle = [maintitlelist objectAtIndex:number];
	return maintitle;
}

-(NSString *)GetSubTitle:(int)number{
	NSString *subtitle=@"NULL";
	//NSDictionary *data = [roomlist objectAtIndex:number];
	//	NSLog(@"%@", data);
	//	NSLog(@"%d", number);
	//subtitle = [data objectForKey:@"subtitle"];
	//	NSLog(@"%@", maintitle);
    subtitle = [subtitlelist objectAtIndex:number];
    
	return subtitle;
}

-(NSString *)GetState:(int)number{
	NSString *state=@"close";
	//NSDictionary *data = [roomlist objectAtIndex:number];
	//NSLog(@"%@", data);
	//NSLog(@"%d", number);
	//state = [data objectForKey:@"state"]
	//	NSLog(@"%@", maintitle);
	
    state = [statelist objectAtIndex:number];
	return state;
    
}
-(int)GetConnectUser:(int)number{
    int user;
    user = [[self db] RoomConnectUser:[[idlist objectAtIndex:number] intValue]];
    [consuerlist replaceObjectAtIndex:number withObject:[NSString stringWithFormat:@"%d",user]];
    return user;
}
-(bool)GetRoomState:(int)number{
	Boolean result=YES;
    NSString *state;
	//NSDictionary *data = [roomlist objectAtIndex:number];
	
	//NSLog(@"%@", data);
    //	NSLog(@"%d", number);
	
	//state = [data objectForKey:@"state"];
    
    state = [statelist objectAtIndex:number];
	if([state isEqualToString:@"open"]){
        result = TRUE;
        roomid = number;
        [self ConnRoom:roomid:@"join"];
    }
    else{
        result = FALSE;
    }
    
	//	NSLog(@"%@", maintitle);
    
	return result;
}

-(void)RoomExit:(int)number{
    [self ConnRoom:roomid:@"out"];
    int user = [[consuerlist objectAtIndex:number] intValue]-1;
    [consuerlist replaceObjectAtIndex:number withObject:[NSString stringWithFormat:@"%d",user]];
}

-(void)RoomClose:(NSInteger)roomid{
    [[self db] RoomClose:roomid];
}

-(void)SetMaintitle{
    NSDictionary *data; 
    for(int i=0; i<count; i++){
        data = [roomlist objectAtIndex:i];
        [maintitlelist addObject:[data objectForKey:@"maintitle"]];
    }
}

-(void)SetSubtitle{
    NSDictionary *data; 
    for(int i=0; i<count; i++){
        data = [roomlist objectAtIndex:i];
        [subtitlelist addObject:[data objectForKey:@"subtitle"]];
    }
}

-(void)SetId{
    NSDictionary *data; 
    for(int i=0; i<count; i++){
        data = [roomlist objectAtIndex:i];
        [idlist addObject:[data objectForKey:@"roomid"]];
        NSLog(@"%@", [idlist objectAtIndex:i]);
    }
}

-(void)SetState{
    NSDictionary *data; 
    for(int i=0; i<count; i++){
        data = [roomlist objectAtIndex:i];
        [statelist addObject:[data objectForKey:@"state"]];
    }
}

-(void)SetConnectUser{
    NSDictionary *data; 
    for(int i=0; i<count; i++){
        data = [roomlist objectAtIndex:i];
        [consuerlist addObject:[data objectForKey:@"connuser"]];
//        NSLog(@"%@", [data objectForKey:@"connuser"]);
    }
}

-(void)RoomListSetting{
    count = [roomlist count];
    
    maintitlelist = [[NSMutableArray alloc] init];
    subtitlelist = [[NSMutableArray alloc] init];
    consuerlist = [[NSMutableArray alloc] init];
    statelist = [[NSMutableArray alloc] init];
    idlist = [[NSMutableArray alloc] init];
    
    [self SetMaintitle];
    [self SetSubtitle];
    [self SetState];
    [self SetConnectUser];
    [self SetId];
    
}

-(void)RoomListData{
	roomlist = [[self db] RoomListData];
    [self RoomListSetting];
}

- (void)dealloc {
    [super dealloc];
    [maintitlelist dealloc];
    [subtitlelist dealloc];
    [consuerlist dealloc];
    [statelist dealloc];
    [idlist dealloc];
}

@end
