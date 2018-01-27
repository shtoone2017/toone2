//
//  HNT_SYS_InnerController.m
//  toone
//
//  Created by 十国 on 16/11/29.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_SYS_InnerController.h"
#import "MySYSSegmentedControl.h"
#import "LLQ_RH_Controller.h"
#import "LLQ_MXE_Controller.h"
#import "LLQ_YD_Controller.h"
#import "LLQ_ZR_Controller.h"
@interface LLQ_SYS_InnerController ()
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int index;
@end

@implementation LLQ_SYS_InnerController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.index =1;
    self.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LLQ_MXE_Controller"];
    if ([self.vc isKindOfClass:[LLQ_MXE_Controller class]]) {
        LLQ_MXE_Controller * controller = (LLQ_MXE_Controller *)self.vc;
        controller.conditonDict = self.conditonDict;
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
    }
    
     [self loadUI];
}

-(void)loadUI{
    MySYSSegmentedControl * seg = [[NSBundle mainBundle] loadNibNamed:@"MySYSSegmentedControl" owner:nil options:nil][0];
    seg.frame = CGRectMake(0, 0, 220, 24);
    self.navigationItem.titleView = seg;
    __weak typeof(self) weakSelf = self;
    seg.segBlock = ^(int tag){
        switch (tag) {
            case 1:{//马歇尔
                if (weakSelf.index !=1){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LLQ_MXE_Controller"];
                    if ([weakSelf.vc isKindOfClass:[LLQ_MXE_Controller class]]) {
                        LLQ_MXE_Controller * controller = (LLQ_MXE_Controller *)weakSelf.vc;
                        controller.conditonDict = weakSelf.conditonDict;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 1;
                }
                break;
            }
            case 2:{
                //延度
                if (weakSelf.index != 2){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LLQ_YD_Controller"];
                    if ([weakSelf.vc isKindOfClass:[LLQ_YD_Controller class]]) {
                        LLQ_YD_Controller * controller = (LLQ_YD_Controller *)weakSelf.vc;
                        controller.conditonDict = weakSelf.conditonDict;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 2;
                }
                break;
            }
            case 3:{
                //软化
                if (weakSelf.index != 3){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LLQ_RH_Controller"];
                    if ([weakSelf.vc isKindOfClass:[LLQ_RH_Controller class]]) {
                        LLQ_RH_Controller * controller = (LLQ_RH_Controller *)weakSelf.vc;
                        controller.conditonDict = weakSelf.conditonDict;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 3;
                }
                break;
            }
            case 4:{
                //针入
                if (weakSelf.index != 4){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LLQ_ZR_Controller"];
                    if ([weakSelf.vc isKindOfClass:[LLQ_ZR_Controller class]]) {
                        LLQ_ZR_Controller * controller = (LLQ_ZR_Controller *)weakSelf.vc;
                        controller.conditonDict = weakSelf.conditonDict;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 4;
                }
                break;
            }
        }
    };
    //切换到拌合站
    [seg switchToSYS];
    
}
@end
