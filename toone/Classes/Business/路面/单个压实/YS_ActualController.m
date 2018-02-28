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
#import "YS_SSYSController.h"
#import "YS_SB_Controller.h"

@interface YS_ActualController ()
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int index;

@end
@implementation YS_ActualController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _type = @"1";
    if ([UserDefaultsSetting shareSetting].road_id == nil) {//选择线路
        YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
        sbVc.type = SBListTypeYSLX;
        [self.navigationController pushViewController:sbVc animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (EqualToString(_type, @"1")) {
        [self addPanGestureRecognizer];
        UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
        btn3.tag  = 3;
        [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.index =1;
    self.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_SSYSController"];
    if ([self.vc isKindOfClass:[YS_SSYSController class]]) {
        YS_SSYSController * controller = (YS_SSYSController *)self.vc;
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
            case 1:{
                if (weakSelf.index !=1){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_SSYSController"];
                    //weakSelf.vc = [[YS_SSYSController alloc] init];
                    if ([self.vc isKindOfClass:[YS_SSYSController class]]) {
                        YS_SSYSController * controller = (YS_SSYSController *)self.vc;
                        
                        controller.type = 1;
                        [self addChildViewController:controller];
                        [self.view addSubview:controller.view];
                    }
                    weakSelf.index = 1;
                }
                break;
            }
            case 2:{
                if (weakSelf.index != 2){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_SSYSController"];
                    //weakSelf.vc = [[YS_SSYSController alloc] init];
                    if ([self.vc isKindOfClass:[YS_SSYSController class]]) {
                        YS_SSYSController * controller = (YS_SSYSController *)self.vc;
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
-(void)searchButtonClick:(UIButton*)sender{
    switch (sender.tag) {
        case 3:{
            [super pan];
            break;
        }
        default:
            FuncLog;
            break;
    }
}
@end
