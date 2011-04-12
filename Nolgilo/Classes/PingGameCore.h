//
//  PingGameCore.h
//  Nolgilo
//
//  Created by GatGong on 11. 4. 12..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PingGameCore : NSObject {
	NSString * TeamName;
	double mylat;
	double mylog;
}
-(NSMutableArray *) SearchOtherTeam:(double)mylat:(double)mylog:(NSString *)teamname;
@end
