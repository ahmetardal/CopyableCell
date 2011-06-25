
/*
 Copyright 2011 Ahmet Ardal

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

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
