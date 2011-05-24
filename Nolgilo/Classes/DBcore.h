//
//  DBcon.h
//  Nolgilo
//
//  Created by goyange on 11. 5. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DBcore : NSObject {
	NSString *response;
}


-(NSString *) DataBaseConnect:(NSString *)conteam;

@end
