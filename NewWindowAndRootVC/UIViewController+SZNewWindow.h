//
//  UIViewController+SZNewWindow.h
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SZNewWindow)

@property (nonatomic , assign) BOOL isNewWindow;
@property (nonatomic , assign) BOOL shouldNavigationBarHidden;

@end

NS_ASSUME_NONNULL_END
