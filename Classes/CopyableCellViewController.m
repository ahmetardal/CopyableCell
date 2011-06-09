//
//  CopyableCellViewController.m
//  CopyableCell
//
//  Created by Ahmet Ardal on 6/9/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import "CopyableCellViewController.h"

@implementation CopyableCellViewController

@synthesize demoTableView, tableData;

- (void) initialize
{
    self.tableData = [NSArray arrayWithObjects:
                      @"Hamlet", @"Claudius", @"Gertrude", @"Polonius",
                      @"Horatio", @"Ophelia", @"Laertes", @"Fortinbras",
                      @"The Ghost", @"Rosencrantz and Guildenstern",
                      @"Osric", @"Voltimand and Cornelius",
                      @"Marcellus and Bernardo", @"Francisco", @"Reynaldo", nil];
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        return self;
    }

    [self initialize];
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (void) dealloc
{
    [self.demoTableView release];
    [self.tableData release];
    [super dealloc];
}


#pragma mark -
#pragma mark Table Data Source / Delegate Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *cellId = @"CopyableCell";
    CopyableCell *cell = (CopyableCell *) [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[CopyableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    [cell setIndexPath:indexPath];
    [cell setDelegate:self];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];

    return cell;
}


#pragma mark -
#pragma mark CopyableCellDelegate Methods

- (void) copyableCell:(CopyableCell *)cell selectCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.demoTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void) copyableCell:(CopyableCell *)cell deselectCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.demoTableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSString *) copyableCell:(CopyableCell *)cell dataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.tableData.count) {
        return [self.tableData objectAtIndex:indexPath.row];
    }

    return @"";
}

@end
