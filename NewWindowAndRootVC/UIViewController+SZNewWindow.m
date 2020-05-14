//
//  UIViewController+SZNewWindow.m
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi All rights reserved.
//

#import "UIViewController+SZNewWindow.h"
#import "SZNewWindowManager.h"
#import <objc/runtime.h>


@implementation UIViewController (SZNewWindow)

- (BOOL)isNewWindow{
    return [objc_getAssociatedObject(self, @selector(isNewWindow)) boolValue];
}

- (void)setIsNewWindow:(BOOL)isNewWindow{
    objc_setAssociatedObject(self, @selector(isNewWindow), @(isNewWindow), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)shouldNavigationBarHidden {
    return [objc_getAssociatedObject(self, @selector(shouldNavigationBarHidden)) boolValue];
}

- (void)setShouldNavigationBarHidden:(BOOL)shouldNavigationBarHidden{
    objc_setAssociatedObject(self, @selector(shouldNavigationBarHidden), @(shouldNavigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}

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
        sz_swizzleSelector(class, @selector(didMoveToParentViewController:), @selector(sz_didMoveToParentViewController:));
    });
}

- (void)sz_didMoveToParentViewController:( nullable UIViewController *)parent {
    [self sz_didMoveToParentViewController:parent];
    if(!parent) {
        if (self.isNewWindow) {  // 此时拿不到导航控制器
            if ( [SZNewWindowManager manager].StackCount == 2) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SZDidMoveToParentNOti" object:self userInfo:nil];
                [SZNewWindowManager manager].StackCount = 0;
                self.isNewWindow = NO;
            }
        }
    }
}
@end
