//
//  Annotation.m
//  Nolgilo
//
//  Created by GatGong on 11. 3. 18..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameModel.h"


@implementation GameModel

@synthesize coordinate;
@synthesize mainTitle;
@synthesize subTitle;



-(void) spotSet: (double) lat: 
				 (double) lng: 
				 (NSString *) t: 
				 (NSString *) st: 
				 (MKMapView *)map{
	
	coordinate.latitude = lat;
	coordinate.longitude = lng;
	self.mainTitle = t;
	self.subTitle = st;
	
	[map addAnnotation:self];
}

//게임 스테이지 초기화

-(void) gameInit:(MKMapView *)mapview{
	
	baseAlert = [[UIAlertView alloc] 
				 initWithTitle:@"게임 준비중"
				 message:@"게임을 준비하고 있습니다.\n 잠시만 기다려주세요"
				 delegate:self 
				 cancelButtonTitle:nil
				 otherButtonTitles:nil];
	
	[NSTimer scheduledTimerWithTimeInterval:3.0
									 target:self
								   selector:@selector(performDismiss:)
								   userInfo:nil
									repeats:NO
	 ];
	

	[baseAlert show];	
	

}


-(void) performDismiss: (NSTimer *)timer{
	
	[baseAlert dismissWithClickedButtonIndex:0 animated:NO];
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
