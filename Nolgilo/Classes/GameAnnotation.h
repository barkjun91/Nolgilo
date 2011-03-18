//
//  Annotation.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 18..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GameAnnotation : NSObject {
	CLLocationCoordinate2D coordinate;
	NSString *mainTitle;
	NSString *subTitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *mainTitle;
@property (nonatomic, retain) NSString *subTitle;

-(id) Coordinatelat:(double) lat
	  Coordinatelng:(double) lng
			 title :(NSString *) t
		  subTitle :(NSString *) st;
-(void) installAnnotation: (CLLocationCoordinate2D) newCoordinate;
-(NSString *)subtitle;
-(NSString *)mainTitle;

@end
