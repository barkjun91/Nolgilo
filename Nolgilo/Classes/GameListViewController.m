//
//  GameListViewController.m
//  Nolgilo
//
//  Created by GatGong on 11. 3. 29..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameListViewController.h"

@implementation GameListViewController


-(GameList *) gamelist
{
	if(!gamelist){
		gamelist = [[GameList alloc] init];
	}
	return gamelist;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
//    list.separatorStyle = UITableViewCellSeparatorStyleNone;
//    list.rowHeight = TABLE_VIEW_CUSTOM_HEIGHT;
//    list.backgroundColor = [UIColor blueColor];
}




//테이블뷰 설정
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

//줄 몇개 쓸건가여?
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if(cell != nil){
        cell = nil;
    }
    
    if(cell == nil){
        
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellID] autorelease];    
        
        UIImage *customIndicator = [UIImage imageNamed:@"image_more.png"];
        cell.accessoryView = [[[UIImageView alloc] initWithImage:customIndicator] autorelease];
        
        //메인 label 생성, 초기화
        mainLabel = [[[UILabel alloc] initWithFrame:CGRectMake(
                                                             IMAGE_WIDTH + cell.indentationWidth,
                                                             (tableView.rowHeight - LABEL_HEIGHT * 2)/2,
                                                             tableView.bounds.size.width -
                                                             IMAGE_WIDTH - customIndicator.size.width - cell.indentationWidth,
                                                             LABEL_HEIGHT)] autorelease];
        mainLabel.tag = MAIN_LABEL_TAG;
        mainLabel.backgroundColor = [UIColor clearColor];
        mainLabel.highlightedTextColor = [UIColor whiteColor];
        mainLabel.font = [UIFont systemFontOfSize:MAIN_LABEL_TEXTSIZE];
        
        [cell.contentView addSubview:mainLabel];
        
        mainLabel.text = @"테스트 메인입니다";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
