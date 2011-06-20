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


-(void)RoomListData{
	roomlist = [[self db] RoomListData];
}

-(NSInteger)GetCount{
	NSInteger count;
	count = [roomlist count];
	NSLog(@"%@", roomlist);
	return count;
}

-(NSString *)GetMainTitle:(int)number;{
	NSString *maintitle=@"NULL";
	NSDictionary *data = [roomlist objectAtIndex:number];
	
//	NSLog(@"%@", data);
//	NSLog(@"%d", number);
	NSLog(@"Call");
	maintitle = [data objectForKey:@"maintitle"];
	
//	NSLog(@"%@", maintitle);
	
	return maintitle;
}

-(NSString *)GetSubTitle:(int)number{
	NSString *subtitle=@"NULL";
	NSDictionary *data = [roomlist objectAtIndex:number];
	
	//	NSLog(@"%@", data);
	//	NSLog(@"%d", number);
	
	subtitle = [data objectForKey:@"subtitle"];
	
	//	NSLog(@"%@", maintitle);
	
	return subtitle;
}

-(NSString *)GetState:(int)number{
	NSString *state=@"close";
	NSDictionary *data = [roomlist objectAtIndex:number];
	
	//	NSLog(@"%@", data);
	//	NSLog(@"%d", number);
	
	state = [data objectForKey:@"state"];
	
	//	NSLog(@"%@", maintitle);
	
	return state;
    
}
@end
