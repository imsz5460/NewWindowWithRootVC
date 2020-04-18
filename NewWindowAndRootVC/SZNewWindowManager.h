//
//  SZNewWindowManager.h
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi All rights reserved.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface SZNewWindowManager : NSObject
@property (nonatomic, assign) int StackCount;


+(instancetype)manager;
- (UIWindow *) addNewWindowWithNav:(UINavigationController *)nav;
+ (void) popWindow;
- (void) pushViewControllerToNewWindow: (UIViewController *)viewController;
+ (void) popWindow:(UIWindow *)window;
@end

NS_ASSUME_NONNULL_END
