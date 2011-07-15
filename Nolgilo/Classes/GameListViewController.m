//
//  GameListViewController.m
//  Nolgilo
//
//  Created by GatGong on 11. 3. 29..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "GameListViewController.h"
#import "PingGameViewController.h"

@implementation GameListViewController


-(GameListCore *) gamelist
{
	if(!gamelist){
		gamelist = [[GameListCore alloc] init];
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


-(void) setRereshTiemer{
    refresh = [NSTimer scheduledTimerWithTimeInterval:3
                                               target:self 
                                             selector:@selector(refreshTable) 
                                             userInfo:nil
                                              repeats:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

-(void)refreshTable{
    [list reloadData];
}


-(int) ConnectUser{
    int connect_user=0;
    connect_user = [[self gamelist] GetConnectUser:select_row];
    return connect_user;
}

-(void)teamSetting{
    if(teamName == 0){
        teamName = room_connect_user;        
    }
    else{
        if(teamName > room_connect_user){
            teamName = room_connect_user;
        }
    }
}

-(void) RoomJoin{    
    room_connect_user = [self ConnectUser];
    [self teamSetting];
    
    NSLog(@"room_connect_user : %d", room_connect_user);
    
    Connect_User.text = [NSString stringWithFormat:@"%d", room_connect_user];
    Maintitle.text = [[self gamelist] GetMainTitle:select_row];
    Subtitle.text = [[self gamelist] GetSubTitle:select_row];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[self.view addSubview:joinroom];
	[UIView commitAnimations];
    
    if(room_connect_user == 3){
        Game_Start.hidden = NO;
        exitroom.hidden = YES;
        [self performSelector:@selector(ReadyGame) withObject:NULL afterDelay:5.0];
    }
    else{
        updateConnuser = [[NSTimer scheduledTimerWithTimeInterval:2.0
                                                           target:self
                                                         selector:@selector(connuser:)
                                                         userInfo:nil
                                                          repeats:YES] retain]; 
        
    }
    [refresh invalidate];
}

-(void) connuser:(NSTimer*)timer
{
    room_connect_user = [[self gamelist] GetConnectUser:select_row];
    [self teamSetting];
    Connect_User.text = [NSString stringWithFormat:@"%d", room_connect_user];
    if(room_connect_user == 3){
        [updateConnuser invalidate];
        //[updateConnuser release];
        Game_Start.hidden = NO;
        exitroom.hidden = YES;
        [self performSelector:@selector(ReadyGame) withObject:NULL afterDelay:5.0];
    }

}

-(void) RoomExit{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	[joinroom removeFromSuperview];
	[UIView commitAnimations];
    
    Game_Start.hidden = YES;
    
    [updateConnuser invalidate];
    [updateConnuser release];
    
    [self setRereshTiemer];
}

-(IBAction)exitRoom{
    [self RoomExit];
    [[self gamelist] RoomExit:select_row];
}


-(void)GameStart{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[self.view addSubview:pingGameViewController.view];
	[UIView commitAnimations];
    [pingGameViewController userinit:teamName:[[self gamelist] GetRoomid]];
    
}


-(void) ReadyGame{
    [self GameStart];
    //[[self gamelist] RoomClose];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    list.backgroundColor = [UIColor clearColor];
    list.separatorStyle = UITableViewCellSeparatorStyleNone;
    list.rowHeight = TABLE_VIEW_CUSTOM_HEIGHT;
    
    pingGameViewController = [[PingGameViewController alloc] initWithNibName:@"PingGameViewController" bundle:nil];
    
    [self setRereshTiemer];
    
}


//테이블뷰 설정
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1 ;
}

//줄 몇개 쓸건가여?
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	[[self gamelist] RoomListData];
	NSInteger count;
	count = [[self gamelist] GetCount];
	
	return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"Cell";
	//NSUInteger sectionRow = [tableView numberOfRowsInSection:[indexPath section]];
	NSUInteger currentRow = [indexPath row];
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if(cell != nil){
       cell = nil;
    }
    
    if(cell == nil){
        
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellID] autorelease];    
        
        UIImage *customIndicator = [UIImage imageNamed:@"moreselect.png"];
        cell.accessoryView = [[[UIImageView alloc] initWithImage:customIndicator] autorelease];
        
        //메인 label 생성, 초기화
        mainLabel = [[[UILabel alloc] initWithFrame:CGRectMake(
                                                             IMAGE_WIDTH + cell.indentationWidth,
                                                             (tableView.rowHeight - LABEL_HEIGHT * 2)/2+10,
                                                             tableView.bounds.size.width -
                                                             IMAGE_WIDTH - customIndicator.size.width - cell.indentationWidth,
                                                             LABEL_HEIGHT)] autorelease];
        mainLabel.tag = MAIN_LABEL_TAG;
        mainLabel.textColor = [UIColor whiteColor];
        mainLabel.backgroundColor = [UIColor clearColor];
        mainLabel.highlightedTextColor = [UIColor whiteColor];
        mainLabel.font = [UIFont systemFontOfSize:MAIN_LABEL_TEXTSIZE];
        
        [cell.contentView addSubview:mainLabel];
      
        subLabel = [[[UILabel alloc] initWithFrame:CGRectMake(IMAGE_WIDTH + cell.indentationWidth,
                                                              (tableView.rowHeight - LABEL_HEIGHT * 2) / 2 + LABEL_HEIGHT + 10,
                                                              mainLabel.bounds.size.width,
                                                              LABEL_HEIGHT)] autorelease];
        
        subLabel.tag = SUB_LABEL_TAG;
        subLabel.backgroundColor = [UIColor clearColor];
        subLabel.textColor = mainLabel.textColor;
        subLabel.highlightedTextColor = mainLabel.highlightedTextColor;
        subLabel.font = [UIFont systemFontOfSize:MAIN_LABEL_TEXTSIZE - 2];
        
        
        [cell.contentView addSubview:subLabel];
        
        cell.backgroundView = [[[UIImageView alloc] init] autorelease] ;
        cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];	

        int room_connuser = [[self gamelist] GetConnectUser:currentRow];;
        int rows = (currentRow % [[self gamelist] GetCount]);
        mainLabel.text = [[self gamelist] GetMainTitle:rows];
        subLabel.text = [NSString stringWithFormat:@"(%d/3)", room_connuser];
        
        
        NSString *room_state = [[self gamelist] GetState:rows];
        
        UIImage *cellBackGroundImage;
		UIImage *cellBackGroundSelected;
		
		cellBackGroundImage = [UIImage imageNamed:@"table_cell.png"];
        cellBackGroundSelected = [UIImage imageNamed:@"table_cell_sel.png"];        
        
     
		((UIImageView *)cell.backgroundView).image = cellBackGroundImage;
		((UIImageView *)cell.selectedBackgroundView).image = cellBackGroundSelected;
		
		cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_room.png",room_state]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    select_row = [indexPath row];
    if([[self gamelist] GetRoomState:select_row]){
        [self RoomJoin];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"참여불가" 
                                                        message:@"이미 게임이 진행중입니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];     
        [alert show];
        [alert release];
    }
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
