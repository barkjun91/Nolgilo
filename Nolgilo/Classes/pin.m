//
//  pin.m
//  Nolgilo
//
//  Created by GatGong on 11. 5. 31..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "pin.h"


@implementation pin
@synthesize coordinate, title, subtitle;

-(void)dealloc{
    [title release];
    [super dealloc];
}


@end
