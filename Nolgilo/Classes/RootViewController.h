//
//  RootViewController.h
//  Nolgilo
//
//  Created by goyange on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadingViewController;
//@class RootGameListViewController;


//이녀석은 나중에 RootGameLIstView로 집어넣을 예정.
@class GameTeamSelectController;


@interface RootViewController : UIViewController {
    LoadingViewController* loadingViewController;
//	RootGameListViewController* gameListViewController;

	
	GameTeamSelectController* gameTeamSelectController;
}

-(IBAction) TitleOnFlipView;
@end