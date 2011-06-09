//
//  CopyableCellViewController.h
//  CopyableCell
//
//  Created by Ahmet Ardal on 6/9/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopyableCell.h"

@interface CopyableCellViewController: UIViewController<UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        CopyableCellDelegate>
{
    UITableView *demoTableView;
    NSArray *tableData;
}

@property (nonatomic, retain) IBOutlet UITableView *demoTableView;
@property (nonatomic, retain) NSArray *tableData;

@end
