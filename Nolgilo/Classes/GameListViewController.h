//
//  GameListViewController.h
//  Nolgilo
//
//  Created by GatGong on 11. 3. 29..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameListCore.h"

//커스텀 셀 text label 태그
#define MAIN_LABEL_TAG 101
#define SUB_LABEL_TAG 102

//커스텀 셀 text label 높이
#define LABEL_HEIGHT 20.0

//커스텀 셀 좌측 이미지 크기
#define IMAGE_WIDTH 65  

//커스텀 셀 text size
#define MAIN_LABEL_TEXTSIZE 16

//커스텀 셀 높이
#define TABLE_VIEW_CUSTOM_HEIGHT 100

@class PingGameViewController;

@interface GameListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
	GameListCore *gamelist;
    PingGameViewController* pingGameViewController;
    
	IBOutlet UIView *roomlist, *createroom, *joinroom;
	IBOutlet UITableView *list;
    IBOutlet UILabel *Connect_User, *Game_Start, *Maintitle, *Subtitle;
    IBOutlet UIButton *exitroom;
    
    NSTimer *updateConnuser;
    NSTimer *refresh;
    
    UILabel *mainLabel;
    UILabel *subLabel;
    
    NSUInteger select_row;
    
    int room_connect_user;
    int teamName;
	
}
-(IBAction) exitRoom;
@end
