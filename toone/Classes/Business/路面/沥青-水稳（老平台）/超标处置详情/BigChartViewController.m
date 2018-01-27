//
//  BigChartViewController.m
//  toone
//
//  Created by sg on 2017/3/30.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "BigChartViewController.h"

@interface BigChartViewController ()

@end

@implementation BigChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (BOOL)shouldAutorotate
{
    return YES;
}
// 画面一开始加载时就是竖向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}
@end
