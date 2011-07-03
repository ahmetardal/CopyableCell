
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
//  CopyableCell.m
//  CopyableCell
//
//  Created by Ahmet Ardal on 6/9/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import "CopyableCell.h"

static const CFTimeInterval kLongPressMinimumDurationSeconds = 0.3;

@interface CopyableCell(Private)
- (void) initialize;
- (void) menuWillHide:(NSNotification *)notification;
- (void) menuWillShow:(NSNotification *)notification;
- (void) handleLongPress:(UILongPressGestureRecognizer *)longPressRecognizer;
@end

@implementation CopyableCell

@synthesize data, indexPath, delegate;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
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

- (void) initialize
{
    self.data = nil;
    self.indexPath = nil;
    self.delegate = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILongPressGestureRecognizer *recognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [recognizer setMinimumPressDuration:kLongPressMinimumDurationSeconds];
    [self addGestureRecognizer:recognizer];
    [recognizer release];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) dealloc
{
    [self.data release];
    [self.indexPath release];
    [super dealloc];
}


#pragma mark -
#pragma mark Copy Menu related methods

- (BOOL) canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void) copy:(id)sender
{
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(copyableCell:dataForCellAtIndexPath:)]) {
        NSString *dataText = [self.delegate copyableCell:self dataForCellAtIndexPath:self.indexPath];
        [[UIPasteboard generalPasteboard] setString:dataText];
    }
    else if (self.data != nil) {
        [[UIPasteboard generalPasteboard] setString:self.data];
    }

    [self resignFirstResponder];
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (BOOL) becomeFirstResponder
{
    return [super becomeFirstResponder];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isFirstResponder] == NO) {
        return;
    }
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
    [menu update];
    [self resignFirstResponder];
}

- (void) menuWillHide:(NSNotification *)notification
{
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(copyableCell:deselectCellAtIndexPath:)]) {
        [self.delegate copyableCell:self deselectCellAtIndexPath:self.indexPath];
    }

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void) menuWillShow:(NSNotification *)notification
{
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(copyableCell:selectCellAtIndexPath:)]) {
        [self.delegate copyableCell:self selectCellAtIndexPath:self.indexPath];
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuWillHide:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:nil];
}


#pragma mark -
#pragma mark UILongPressGestureRecognizer Handler Methods

- (void) handleLongPress:(UILongPressGestureRecognizer *)longPressRecognizer
{
    if (longPressRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }

    if ([self becomeFirstResponder] == NO) {
        return;
    }

    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.bounds inView:self];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuWillShow:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
    [menu setMenuVisible:YES animated:YES];
}

@end
