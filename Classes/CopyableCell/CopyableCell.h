//
//  CopyableCell.h
//  CopyableCell
//
//  Created by Ahmet Ardal on 6/9/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CopyableCellDelegate;

@interface CopyableCell: UITableViewCell
{
    NSString *data;
    NSIndexPath *indexPath;
    id<CopyableCellDelegate> delegate;
}

@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) id<CopyableCellDelegate> delegate;

@end

@protocol CopyableCellDelegate<NSObject>
@required
- (void) copyableCell:(CopyableCell *)cell selectCellAtIndexPath:(NSIndexPath *)indexPath;
- (void) copyableCell:(CopyableCell *)cell deselectCellAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSString *) copyableCell:(CopyableCell *)cell dataForCellAtIndexPath:(NSIndexPath *)indexPath;
@end
