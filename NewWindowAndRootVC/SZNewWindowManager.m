//
//  SZNewWindowManager.m
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi All rights reserved.
//

#import "SZNewWindowManager.h"
#import "SZTranslucentViewController.h"
#import "UIViewController+SZNewWindow.h"

@interface SZNewWindowManager ()
@property (nonatomic, strong) UIWindow *addWindow;
@property (nonatomic, strong) NSMutableArray <UIWindow *>*widowStack;
@property (nonatomic, strong) UINavigationController *curNavController;

@end
@implementation SZNewWindowManager

static SZNewWindowManager *__lazyInstance;


+ (instancetype)manager
{
    @synchronized (self) {
        if(!__lazyInstance) {
            __lazyInstance = [[SZNewWindowManager alloc] init];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMoveToSuperview:) name: @"SZDidMoveToParentNOti" object:nil];
        }
    }
    return __lazyInstance;
}

- (UIWindow *) addNewWindowWithNav:(UINavigationController *)nav {
    
    SZTranslucentViewController *vc = [SZTranslucentViewController new];
    UIWindow *addwindow = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    nav = [nav initWithRootViewController:vc];
    nav.isNewWindow = YES;
    addwindow.rootViewController = nav;
    _curNavController = nav;
    [addwindow makeKeyAndVisible];
    [__lazyInstance.widowStack addObject:addwindow];
    return addwindow;
}

- (void) pushViewControllerToNewWindow: (UIViewController *)viewController {
    if (viewController) {
        [_curNavController pushViewController:viewController animated:YES];
    } else {
        [[self class] didMoveToSuperview:nil];
    }
}

//窗口栈
- (NSMutableArray *) widowStack {
    if (!_widowStack) {
        _widowStack = [NSMutableArray array];
    }
    return _widowStack;
}

+ (void) didMoveToSuperview: (NSNotification *)noti {
    UIViewController *vc = noti.object;
    vc.isNewWindow = NO;// 若为单例控制器，需要恢复属性；
    [__lazyInstance.widowStack.lastObject resignKeyWindow];
    __lazyInstance.widowStack.lastObject.windowLevel = -1000;
    __lazyInstance.widowStack.lastObject.hidden = YES;
    __lazyInstance.curNavController.isNewWindow = NO;
    [__lazyInstance.widowStack.lastObject.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [__lazyInstance.widowStack removeLastObject];
}

+ (void) popWindow {
    [[self class] didMoveToSuperview:nil];
}

+ (void) popWindow:(UIWindow *)window {
    if (!window) {
        [[self class] didMoveToSuperview:nil];
        return;
    }
    [window resignKeyWindow];
    window.windowLevel = -1000;
    window.hidden = YES;

    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [__lazyInstance.widowStack removeObject:window];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}




@end
