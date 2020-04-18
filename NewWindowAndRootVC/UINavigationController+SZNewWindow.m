//
//  UINavigationController+newWindow.m
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi All rights reserved.
//

#import "UINavigationController+SZNewWindow.h"
#import "SZNewWindowManager.h"
#import "UIViewController+SZNewWindow.h"
#import <objc/runtime.h>

@implementation UINavigationController (SZNewWindow)

#pragma mark - 方法交换

static inline void sz_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


//在load方法中完成方法交换
+ (void)load {
    
    //方法交换
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        sz_swizzleSelector(class, @selector(popViewControllerAnimated:), @selector(sz_popViewControllerAnimated:));
        sz_swizzleSelector(class, @selector(pushViewController: animated:), @selector(sz_pushViewController: animated:));

    });
}


- (UIViewController *)sz_popViewControllerAnimated:(BOOL)animated {
//    if (self.isNewWindow) {
        [SZNewWindowManager manager].StackCount = (int)self.childViewControllers.count;
//    }
    return [self sz_popViewControllerAnimated:animated];
}


- (void)sz_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.isNewWindow = YES;
    [self sz_pushViewController:viewController animated:animated];
}

@end
