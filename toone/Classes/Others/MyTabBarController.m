//
//  MyTabBarViewController.m
//  toone
//
//  Created by 十国 on 16/11/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    //保存时间
    [UserDefaultsSetting shareSetting].startTime = [TimeTools time_3_monthsAgo] ;
    [UserDefaultsSetting shareSetting].endTime   = [TimeTools currentTime] ;
    [[UserDefaultsSetting shareSetting] saveToSandbox];
}

#pragma  mark - 支持横竖屏
// 不支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

// 只支持竖向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

// 画面一开始加载时就是竖向
 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
     return UIInterfaceOrientationPortrait;
 }
@end
