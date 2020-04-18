//
//  ViewController.m
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi. All rights reserved.
//

#import "ViewController.h"
#import "SZNewWindowManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pushNewWindow:(id)sender {
    
    [[SZNewWindowManager manager] addNewWindowWithNav: [[UINavigationController alloc] init]];
    
    UIViewController *pushVC = [[UIViewController alloc] init];
    pushVC.view.backgroundColor = [UIColor redColor];
    
    
    [[SZNewWindowManager manager] pushViewControllerToNewWindow:pushVC];
}

@end
