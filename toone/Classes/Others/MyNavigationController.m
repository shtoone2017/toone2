//
//  MyNavigationController.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyNavigationController.h"
/*
 + (instancetype)tealColor;
 + (instancetype)steelBlueColor;
 + (instancetype)robinEggColor;
 + (instancetype)pastelBlueColor;
 + (instancetype)turquoiseColor;
 + (instancetype)skyBlueColor;
 + (instancetype)indigoColor;
 + (instancetype)denimColor;
 + (instancetype)blueberryColor;
 + (instancetype)cornflowerColor;
 + (instancetype)babyBlueColor;
 + (instancetype)midnightBlueColor;
 + (instancetype)fadedBlueColor;
 + (instancetype)icebergColor;
 + (instancetype)waveColor;
 */


@interface MyNavigationController ()

@end

@implementation MyNavigationController

-(void)viewDidLoad{
    [super viewDidLoad];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, Screen_w, 20)];
    statusBarView.backgroundColor= BLUECOLOR;
    [self.navigationBar addSubview:statusBarView];
    [[UINavigationBar appearance] setBackgroundColor:BLUECOLOR];
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        UIButton * btn = [UIButton img_20_leftWithName:@"ic_keyboard_arrow_left_white_24dp"];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
//         viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_keyboard_arrow_left_white_24dp"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        //隐藏底部
        viewController.hidesBottomBarWhenPushed = YES;
    }
    viewController.automaticallyAdjustsScrollViewInsets = NO;//关闭自动布局，默认YES
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self popViewControllerAnimated:YES];
}
@end
