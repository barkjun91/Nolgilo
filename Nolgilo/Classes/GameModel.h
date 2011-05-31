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
	UIAlertView  *baseAlert;
	
}

//게임 스테이지 초기화
-(void)GameInitMessage;
-(void)fadeView:(UIView *) v: (BOOL) appare;

@end
