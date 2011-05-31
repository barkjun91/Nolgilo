//
//  SoptCore.h
//  Nolgilo
//
//  Created by goyange on 11. 5. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DBcore.h"
#import "pin.h"

@interface SpotCore : NSObject <CLLocationManagerDelegate>{
	NSMutableArray *arrayLat;
	NSMutableArray *arrayLog;
	NSArray *pindatalist;
	
	DBcore *db;
	pin *ann;
}

@property (nonatomic, retain) NSMutableArray *arrayLat;
@property (nonatomic, retain) NSMutableArray *arrayLog;

-(void)initSpot;
-(void)addPin:(MKMapView *)mapview;

@end
