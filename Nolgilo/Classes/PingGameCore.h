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
	struct otherTeam {
		NSString * TeamName;
		double lat;
		double log;
		double angle;
	}team1, team2;
}
-(NSMutableArray *) SearchOtherTeam:(double)lat:(double)log:(NSString *)name;
-(double)SetAngle:(NSString *)teamname;
@end
