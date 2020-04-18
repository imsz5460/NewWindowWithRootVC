//
//  SZTranslucentViewController.m
//  NewWindowAndRootVC
//
//  Created by shizhi on 2020/4/18.
//  Copyright © 2020 shizhi All rights reserved.
//

#import "SZTranslucentViewController.h"

@interface SZTranslucentViewController ()

@end

@implementation SZTranslucentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) loadView {
    UIView *view = [UIView new];
    view.frame = [UIScreen mainScreen].bounds;
    view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    
    self.view = view;
}



@end
