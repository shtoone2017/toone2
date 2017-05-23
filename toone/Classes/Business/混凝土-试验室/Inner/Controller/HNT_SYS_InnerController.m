//
//  HNT_SYS_InnerController.m
//  toone
//
//  Created by 十国 on 16/11/29.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SYS_InnerController.h"
#import "MySegmentedControl.h"
#import "HNT_YLSY_Controller.h"
#import "HNT_WNSY_Controller.h"
#import "HNT_TJFX_Controller.h"
@interface HNT_SYS_InnerController ()
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int index;
@end

@implementation HNT_SYS_InnerController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.userGroupId == nil) {//直接跳入试验室
        self.userGroupId = [UserDefaultsSetting shareSetting].departId;
        
        UIButton *btn3 = [UIButton img_20WithName:@"sg_person"];
        btn3.tag = 3;
        [btn3 addTarget:self action:@selector(pan) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    }
   
    
    self.index =1;
    self.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_YLSY_Controller"];
    if ([self.vc isKindOfClass:[HNT_YLSY_Controller class]]) {
        HNT_YLSY_Controller * controller = (HNT_YLSY_Controller *)self.vc;
        controller.userGroupId = self.userGroupId;
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
    }
    
     [self loadUI];
}

-(void)loadUI{
    MySegmentedControl * seg = [[NSBundle mainBundle] loadNibNamed:@"MySegmentedControl" owner:nil options:nil][0];
    seg.frame = CGRectMake(0, 0, 220, 24);
    self.navigationItem.titleView = seg;
    __weak typeof(self) weakSelf = self;
    seg.segBlock = ^(int tag){
        switch (tag) {
            case 1:{//压力试验
                if (weakSelf.index !=1){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_YLSY_Controller"];
                    if ([weakSelf.vc isKindOfClass:[HNT_YLSY_Controller class]]) {
                        HNT_YLSY_Controller * controller = (HNT_YLSY_Controller *)weakSelf.vc;
                        controller.userGroupId = weakSelf.userGroupId;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
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
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_WNSY_Controller"];
                    if ([weakSelf.vc isKindOfClass:[HNT_WNSY_Controller class]]) {
                        HNT_WNSY_Controller * controller = (HNT_WNSY_Controller *)weakSelf.vc;
                        controller.userGroupId = weakSelf.userGroupId;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 2;
                }
                break;
            }
            case 3:{
                //统计分析
                if (weakSelf.index != 3){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_TJFX_Controller"];
                    if ([weakSelf.vc isKindOfClass:[HNT_TJFX_Controller class]]) {
                        HNT_TJFX_Controller * controller = (HNT_TJFX_Controller *)weakSelf.vc;
                        controller.userGroupId = weakSelf.userGroupId;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 3;
                }
                break;
            }
        }
    };
}
@end
