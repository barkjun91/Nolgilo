//
//  SoptCore.m
//  Nolgilo
//
//  Created by goyange on 11. 5. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpotCore.h"


@implementation SpotCore
@synthesize arrayLat, arrayLog;

-(DBcore *) db
{
	if(!db){
		db = [[DBcore alloc] init];
	}
	return db;
}
-(pin *)ann
{
	if(!ann){
		ann=[[pin alloc] init];
	}
	
	return ann;
}
-(void)initSpot{
	NSString *list = [[self db] SpotData];
	NSArray *datalist = [list componentsSeparatedByString:@":"];
	
	pindatalist = [[datalist objectAtIndex:0] componentsSeparatedByString:@"-"];
	arrayLat = [[NSMutableArray alloc] init];
	arrayLog = [[NSMutableArray alloc] init];
	
	NSArray *loc = [[pindatalist objectAtIndex:2] componentsSeparatedByString:@"/"];
	[arrayLat addObject:[loc objectAtIndex:0]];
	[arrayLog addObject:[loc objectAtIndex:1]];
}

-(void)addPin:(MKMapView *)mapview{
	ann.title = @"테스트용 좌표입니다.";
	
	CLLocationCoordinate2D center;
	center.latitude = [[arrayLat objectAtIndex:0] doubleValue];
	center.longitude = [[arrayLog objectAtIndex:0] doubleValue];
	NSLog(@"%f %f", center.latitude, center.longitude);
	ann.coordinate = center;

//	[mapview addAnnotation:ann];
}

@end
