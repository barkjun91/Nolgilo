//
//  TableHandler.m
//  Nolgilo
//
//  Created by GatGong on 11. 3. 31..
//  Copyright 2011 Nolgong. All rights reserved.
//

#import "TableHandler.h"

@implementation TableHandler

@synthesize tableDataList;
@synthesize rootView;

-(void) fillList{
	NSArray * tempArray = [[[NSArray alloc] initWithObjects:@"TestGame1", @"TestGame2", nil] autorelease];
	self.tableDataList = tempArray;
	
	[rootView GameStartView];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
	return [self.tableDataList count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];

	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:@"acell"] autorelease];
	}
	cell.textLabel.text = [self.tableDataList objectAtIndex:[indexPath row]];
	cell.textLabel.numberOfLines = 4;
	return cell;
}

- (NSIndexPath *) tableView:(UITableView *) tableView
 willSelectRowAtIndexPath:(NSIndexPath *) indexPath{
	switch (indexPath.row) {
		case 0:
			NSLog(@"asdf");
			break;
		default:
			break;
	}
	return indexPath;
}
	

-(void) dealloc{
	[tableDataList release];
	[super dealloc];
}

@end
