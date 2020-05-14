//
//  ViewController.m
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi. All rights reserved.
//

#import "ViewController.h"
#import "SZNewWindowManager.h"
#import "UIViewController+SZNewWindow.h"
#import "SZUINavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pushNewWindow:(id)sender {
    
    [[SZNewWindowManager manager] addNewWindowWithNav: [[SZUINavigationController alloc] init]];
    UIViewController *pushVC = [[UIViewController alloc] init];
    pushVC.view.backgroundColor = [UIColor redColor];
//    pushVC.shouldNavigationBarHidden = YES;
    [[SZNewWindowManager manager] pushViewControllerToNewWindow:pushVC];
}

@end
