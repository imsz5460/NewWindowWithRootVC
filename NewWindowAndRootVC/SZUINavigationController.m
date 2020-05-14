//
//  SZUINavigationController.m
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi All rights reserved.
//

#import "SZUINavigationController.h"
#import "UIViewController+SZNewWindow.h"
#import "SZNewWindowManager.h"
@interface SZUINavigationController ()<UINavigationControllerDelegate>

@end

@implementation SZUINavigationController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}


/**
 *  当控制器, 拿到导航控制器(需要是这个子类), 进行压栈时, 都会调用这个方法
 *
 *  @param viewController 要压栈的控制器
 *  @param animated       动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.isNewWindow = YES;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [SZNewWindowManager manager].StackCount = (int)self.childViewControllers.count;
    return [super popViewControllerAnimated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (viewController.shouldNavigationBarHidden != self.navigationBarHidden) {
        [self setNavigationBarHidden:viewController.shouldNavigationBarHidden animated:animated];
    }
}

@end

