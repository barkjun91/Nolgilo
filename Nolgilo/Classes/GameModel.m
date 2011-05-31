//
//  Annotation.m
//  Nolgilo
//
//  Created by GatGong on 11. 3. 18..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameModel.h"


@implementation GameModel

//게임 스테이지 초기화

-(void) GameInitMessage{
	
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


-(void)fadeView:(UIView *) v: (BOOL) appare{
	if(appare){
		v.alpha = 0;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		v.alpha = 1;
		[UIView commitAnimations];
	}else {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		v.alpha = 0;
		[UIView commitAnimations];
	}
	
}



-(void) performDismiss: (NSTimer *)timer{
	
	[baseAlert dismissWithClickedButtonIndex:0 animated:NO];
}





-(void) dealloc{
	[super dealloc];
}

@end
