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
		double radian;
		bool live;
		bool catchteam;
	}team1, team2;
}
-(NSMutableArray *) SearchOtherTeam:(double)lat:(double)log:(NSString *)name;
-(NSString *) TeamNameSet:(NSString *) teamName :(NSString *) arrowImage;
-(double)SetAngle:(NSString *)teamname;
-(NSString *)CatchCheck;
@end
