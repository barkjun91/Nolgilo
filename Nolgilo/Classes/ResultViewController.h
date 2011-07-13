//
//  ResultViewController.h
//  Nolgilo
//
//  Created by goyange on 11. 6. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameListViewController;

@interface ResultViewController : UIViewController{
    
    GameListViewController* gameListViewController;
    
    IBOutlet UILabel *teamNameLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIImageView *result;
}

-(IBAction) goRoomList;
-(void) resultinit:(NSString *)teamid:(long)sc:(NSString *)state;
@end
