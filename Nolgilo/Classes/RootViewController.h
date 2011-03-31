//
//  RootViewController.h
//  Nolgilo
//
//  Created by goyange on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadingViewController;
@class MapViewController;
@class RootGameListViewController;

@interface RootViewController : UIViewController {
    LoadingViewController* loadingViewController;
    MapViewController* mapViewController;
	RootGameListViewController* gameListViewController;
    	
}

-(IBAction) TitleOnFlipView;
-(void) GameStartView;
@end