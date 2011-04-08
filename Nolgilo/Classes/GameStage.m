//
//  GameStage.m
//  Nolgilo
//
//  Created by GatGong on 11. 4. 8..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameStage.h"


@implementation GameStage

-(void) StageInit:(MKMapView *)mapView{
	mapView.showsUserLocation = YES; // if yes, shows a bule~;
	mapView.mapType = MKMapTypeStandard;
	mapView.delegate = self;
	mapView.zoomEnabled = YES;
	mapView.scrollEnabled = YES;
	mapView.userInteractionEnabled = YES;	
	mapView.transform = CGAffineTransformMakeRotation(0.0f);
}
@end
