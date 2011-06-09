//
//  CopyableCellAppDelegate.h
//  CopyableCell
//
//  Created by Ahmet Ardal on 6/9/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CopyableCellViewController;

@interface CopyableCellAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CopyableCellViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CopyableCellViewController *viewController;

@end

