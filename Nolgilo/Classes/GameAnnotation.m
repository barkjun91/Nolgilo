//
//  Annotation.m
//  Nolgilo
//
//  Created by GatGong on 11. 3. 18..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameAnnotation.h"


@implementation GameAnnotation

@synthesize coordinate;
@synthesize mainTitle;
@synthesize subTitle;


-(id) Coordinatelat:(double) lat
	  Coordinatelng:(double) lng
			 title :(NSString *) t
		  subTitle :(NSString *) st{
	coordinate.latitude = lat;
	coordinate.longitude = lng;
	self.mainTitle = t;
	self.subTitle = st;
	return self;
}

-(void) installAnnotation:(CLLocationCoordinate2D)newCoordinate{
	coordinate = newCoordinate;
}

-(NSString *)subtitle{
	return subTitle;
}

-(NSString *)maintitle{
	return mainTitle;
}


-(void) dealloc{
	[mainTitle release];
	[subTitle release];
	[super dealloc];
}
@end
