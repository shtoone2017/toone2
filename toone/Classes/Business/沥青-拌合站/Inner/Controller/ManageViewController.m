//
//  ManageViewController.m
//  toone
//
//  Created by shtoone on 16/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "ManageViewController.h"
#import "NQ_BHZ_SCCX_Controller.h"
#import "ExcessiveViewController.h"
#import "MaterialViewController.h"
#import "MySegmentedControl.h"

@interface ManageViewController ()
@property (nonatomic,strong) UIViewController *indexVc;
@property (nonatomic,assign) int index;

@end
@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    默认初始化
    self.index =1;

    self.indexVc = [[NQ_BHZ_SCCX_Controller alloc] init];
    NQ_BHZ_SCCX_Controller *producVc =(NQ_BHZ_SCCX_Controller *) self.indexVc;
    
    [self addChildViewController:producVc];
    [self.view addSubview:producVc.view];
    
    [self loadUI];

}
-(void)loadUI{
    MySegmentedControl * seg = [[NSBundle mainBundle] loadNibNamed:@"MySegmentedControl" owner:nil options:nil][0];
    seg.frame = CGRectMake(0, 0, 220, 24);
    self.navigationItem.titleView = seg;
    [seg switchToLQBHZ];
    __weak typeof(self) weakSelf = self;
    seg.segBlock = ^(int tag){
        switch (tag) {
            case 1:{//生产查询
                if (weakSelf.index !=1){
                    [self.indexVc removeFromParentViewController];
                    [self.indexVc.view removeFromSuperview];
                    
                    self.indexVc = [[NQ_BHZ_SCCX_Controller alloc] init];
                    NQ_BHZ_SCCX_Controller *producVc =(NQ_BHZ_SCCX_Controller *) self.indexVc;
                    
                    [self addChildViewController:producVc];
                    [self.view addSubview:producVc.view];
                    weakSelf.index = 1;
                }
                break;
            }
            case 2:{
                //总产量统计
                if (weakSelf.index != 2){
                    [self.indexVc removeFromParentViewController];
                    [self.indexVc.view removeFromSuperview];
                    
                    self.indexVc = [[MaterialViewController alloc] init];
                    MaterialViewController *materVc = (MaterialViewController *) self.indexVc;
                    
                    [self addChildViewController:materVc];
                    [self.view addSubview:materVc.view];
                    weakSelf.index = 2;
                }
                break;
            }
            case 3:{
                //待处置报警
                if (weakSelf.index != 3){
                    [self.indexVc removeFromParentViewController];
                    [self.indexVc.view removeFromSuperview];
                    
                    self.indexVc = [[ExcessiveViewController alloc] init];
                    ExcessiveViewController *excessVc = (ExcessiveViewController *) self.indexVc;
                    
                    [self addChildViewController:excessVc];
                    [self.view addSubview:excessVc.view];
                    weakSelf.index = 3;
                }
                break;
            }
        }
    };
}

@end
