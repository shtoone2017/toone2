//
//  WZ_GCB_InnerController.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "WZ_GCB_InnerController.h"
#import "GCB_RWD_Controller.h"
#import "GCB_JZL_Controller.h"
#import "GCB_JCH_Controller.h"
#import "GCB_JCB_Controller.h"
#import "MySYSSegmentedControl.h"

@interface WZ_GCB_InnerController ()
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int index;

@end
@implementation WZ_GCB_InnerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index =1;
    self.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_RWD_Controller"];
    if ([self.vc isKindOfClass:[GCB_RWD_Controller class]]) {
        GCB_RWD_Controller * controller = (GCB_RWD_Controller *)self.vc;
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
    }
    [self loadUI];
}

-(void)loadUI {
    MySYSSegmentedControl * seg = [[NSBundle mainBundle] loadNibNamed:@"MySYSSegmentedControl" owner:nil options:nil][0];
    seg.frame = CGRectMake(0, 0, 220, 24);
    self.navigationItem.titleView = seg;
    [seg switchToWZ];
    __weak typeof(self) weakSelf = self;
    seg.segBlock = ^(int tag) {
        switch (tag) {
            case 1:{
                if (weakSelf.index !=1){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_RWD_Controller"];
                    if ([weakSelf.vc isKindOfClass:[GCB_RWD_Controller class]]) {
                        GCB_RWD_Controller * controller = (GCB_RWD_Controller *)weakSelf.vc;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 1;
                }
                break;
            }
            case 2:{
                if (weakSelf.index !=2){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_JZL_Controller"];
                    if ([weakSelf.vc isKindOfClass:[GCB_JZL_Controller class]]) {
                        GCB_JZL_Controller * controller = (GCB_JZL_Controller *)weakSelf.vc;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 2;
                }
                break;
            }
            case 3:{
                if (weakSelf.index !=3){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_JCB_Controller"];
                    if ([weakSelf.vc isKindOfClass:[GCB_JCB_Controller class]]) {
                        GCB_JCB_Controller * controller = (GCB_JCB_Controller *)weakSelf.vc;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 3;
                }
                break;
            }
            case 4:{
                if (weakSelf.index !=4){
                    [weakSelf.vc removeFromParentViewController];
                    [weakSelf.vc.view removeFromSuperview];
                    weakSelf.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_JCH_Controller"];
                    if ([weakSelf.vc isKindOfClass:[GCB_JCH_Controller class]]) {
                        GCB_JCH_Controller * controller = (GCB_JCH_Controller *)weakSelf.vc;
                        [weakSelf addChildViewController:controller];
                        [weakSelf.view addSubview:controller.view];
                    }
                    weakSelf.index = 4;
                }
                break;
            }
        }
    };
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
