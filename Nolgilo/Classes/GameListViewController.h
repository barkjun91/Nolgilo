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
//#define SUB_LABEL_TAG 102

//커스텀 셀 text label 높이
#define LABEL_HEIGHT 20.0

//커스텀 셀 좌측 이미지 크기
#define IMAGE_WIDTH 65  

//커스텀 셀 text size
#define MAIN_LABEL_TEXTSIZE 16

//커스텀 셀 높이
#define TABLE_VIEW_CUSTOM_HEIGHT 100


@interface GameListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
	GameListCore *gamelist;
	
	IBOutlet UITableView *list;
    
    UILabel *mainLabel;
    UILabel *subLabel;
	
}

@end
