//
//  GameModel.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 18..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GameModel : NSObject {
    CLLocationCoordinate2D coordinate;
	NSString *mainTitle;
	NSString *subTitle;
	
	UIAlertView  *baseAlert;
	
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *mainTitle;
@property (nonatomic, retain) NSString *subTitle;

//게임 스테이지 초기화
-(void) gameInit:(MKMapView *)mapview;		

-(void) spotSet: (double) lat: (double) lng: (NSString *) t: (NSString *) st: (MKMapView *)map;
-(NSString *)subtitle;
-(NSString *)mainTitle;

@end
