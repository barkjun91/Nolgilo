//
//  ResultViewController.h
//  Nolgilo
//
//  Created by goyange on 11. 6. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResultViewController : UIViewController{
    IBOutlet UILabel *teamNameLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIImageView *result;
}

-(IBAction) goRoomList;
-(void) resultinit:(NSString *)teamid:(double)sc:(NSString *)state;
@end
