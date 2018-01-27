//
//  HNT_SYS_InnerController.m
//  toone
//
//  Created by 十国 on 16/11/29.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LQ_SW_InnerController.h"
#import "MySegmentedControl.h"
#import "SW_CLHS_Controller.h"
#import "SW_CBCZ_Controller.h"
#import "SW_LSSJ_Controller.h"
@interface LQ_SW_InnerController ()
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int index;
@end

@implementation LQ_SW_InnerController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.index =1;
    self.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SW_LSSJ_Controller"];
    if ([self.vc isKindOfClass:[SW_LSSJ_Controller class]]) {
        SW_LSSJ_Controller * controller = (SW_LSSJ_Controller *)self.vc;
        controller.conditonDict = self.conditonDict;
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
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SW_LSSJ_Controller"];
                    if ([weakSelf.vc isKindOfClass:[SW_LSSJ_Controller class]]) {
                        SW_LSSJ_Controller * controller = (SW_LSSJ_Controller *)weakSelf.vc;
                        controller.conditonDict = weakSelf.conditonDict;
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
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SW_CBCZ_Controller"];
                    if ([weakSelf.vc isKindOfClass:[SW_CBCZ_Controller class]]) {
                        SW_CBCZ_Controller * controller = (SW_CBCZ_Controller *)weakSelf.vc;
                        controller.conditonDict = weakSelf.conditonDict;
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
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SW_CLHS_Controller"];
                    if ([weakSelf.vc isKindOfClass:[SW_CLHS_Controller class]]) {
                        SW_CLHS_Controller * controller = (SW_CLHS_Controller *)weakSelf.vc;
                        controller.conditonDict = weakSelf.conditonDict;
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
