//
//  HNT_SYS_InnerController.m
//  toone
//
//  Created by 十国 on 16/11/29.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_BHZ_InnerController.h"
#import "MySegmentedControl.h"
#import "HNT_CLHS_Controller.h"
#import "HNT_CBCZ_Controller.h"
#import "HNT_SCCX_Controller.h"
@interface HNT_BHZ_InnerController ()
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int index;
@end

@implementation HNT_BHZ_InnerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index =1;
    self.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_SCCX_Controller"];
    if ([self.vc isKindOfClass:[HNT_SCCX_Controller class]]) {
        HNT_SCCX_Controller * controller = (HNT_SCCX_Controller *)self.vc;
        controller.departId = self.departId;
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
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_SCCX_Controller"];
                    if ([weakSelf.vc isKindOfClass:[HNT_SCCX_Controller class]]) {
                        HNT_SCCX_Controller * controller = (HNT_SCCX_Controller *)weakSelf.vc;
                        controller.departId = weakSelf.departId;
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
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_CBCZ_Controller"];
                    if ([weakSelf.vc isKindOfClass:[HNT_CBCZ_Controller class]]) {
                        HNT_CBCZ_Controller * controller = (HNT_CBCZ_Controller *)weakSelf.vc;
                        controller.departId = weakSelf.departId;
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
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_CLHS_Controller"];
                    if ([weakSelf.vc isKindOfClass:[HNT_CLHS_Controller class]]) {
                        HNT_CLHS_Controller * controller = (HNT_CLHS_Controller *)weakSelf.vc;
                        controller.departId = weakSelf.departId;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 3;
                }
                break;
            }
        }
    };
    //切换到拌合站
    [seg switchToBHZ];
    
}
@end
