//
//  YS_ActualController.m
//  toone
//
//  Created by 上海同望 on 2018/2/26.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_ActualController.h"
#import "MyTPSegmentedControl.h"
#import "SSYSViewController.h"

@interface YS_ActualController ()
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int index;

@end
@implementation YS_ActualController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UserDefaultsSetting shareSetting].road_id == nil)
    {
        //选择线路
        [UserDefaultsSetting shareSetting].road_id = @"f9a816c15f7aa4ca015f7cbf18aa004d";
        [UserDefaultsSetting shareSetting].road_name = @"贵阳-花石";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.index =1;
    self.vc = [[SSYSViewController alloc] init];;
    if ([self.vc isKindOfClass:[SSYSViewController class]]) {
        SSYSViewController * controller = (SSYSViewController *)self.vc;
        controller.type = 1;
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
    }
    
    [self loadUI];
}

-(void)loadUI {
    MyTPSegmentedControl *seg = [[NSBundle mainBundle] loadNibNamed:@"MyTPSegmentedControl" owner:nil options:nil][0];
    seg.frame = CGRectMake(0, 0, 220, 24);
    self.navigationItem.titleView = seg;
    __weak typeof(self) weakSelf = self;
    seg.segBlock = ^(int tag){
        switch (tag) {
            case 1:{//压力试验
                if (weakSelf.index !=1){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[SSYSViewController alloc] init];
                    if ([self.vc isKindOfClass:[SSYSViewController class]]) {
                        SSYSViewController * controller = (SSYSViewController *)self.vc;
                        controller.type = 1;
                        [self addChildViewController:controller];
                        [self.view addSubview:controller.view];
                    }
                    weakSelf.index = 1;
                }
                break;
            }
            case 2:{
                //万能试验
                if (weakSelf.index != 2){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[SSYSViewController alloc] init];
                    if ([self.vc isKindOfClass:[SSYSViewController class]]) {
                        SSYSViewController * controller = (SSYSViewController *)self.vc;
                        controller.type = 2;
                        [self addChildViewController:controller];
                        [self.view addSubview:controller.view];
                    }
                    weakSelf.index = 2;
                }
                break;
            }
        }
    };
    //切换到拌合站
    [seg switchToYS];
}

@end
