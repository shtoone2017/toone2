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
#import "SYS_PHBViewController.h"
#import "SYS_TZDViewController.h"

@interface HNT_SYS_InnerController ()

@property (nonatomic,strong) UIViewController * currentVC;

@property (nonatomic,strong) NSArray *vcsArr;

@end

@implementation HNT_SYS_InnerController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (self.userGroupId == nil) {//直接跳入试验室
//        self.userGroupId = [UserDefaultsSetting shareSetting].departId;
//        
//        UIButton *btn3 = [UIButton img_20WithName:@"sg_person"];
//        btn3.tag = 3;
//        [btn3 addTarget:self action:@selector(pan) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
//    }
    [self loadUI];
}

-(void)loadUI{
    NSArray *titles = @[@"压力",@"万能",@"统计",@"配合比",@"通知单"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titles];
    seg.frame = CGRectMake(0,0,220,24);
    seg.selectedSegmentIndex = 0;
    seg.tintColor = [UIColor whiteColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:10],
                         NSFontAttributeName,nil];
    
    [seg setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:10],
                          NSFontAttributeName,nil];
    
    [seg setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [seg addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    
    HNT_YLSY_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_YLSY_Controller"];
    [self addChildViewController:ylVC];
    
    HNT_WNSY_Controller *wnVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_WNSY_Controller"];
    [self addChildViewController:wnVC];
    
    HNT_TJFX_Controller *tjVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_TJFX_Controller"];
    [self addChildViewController:tjVC];
    
    SYS_PHBViewController *phbVC = [[SYS_PHBViewController alloc] init];
    [self addChildViewController:phbVC];
    
    SYS_TZDViewController *tzdVC = [[SYS_TZDViewController alloc] init];
    [self addChildViewController:tzdVC];
    
    _vcsArr = @[ylVC,wnVC,tjVC,phbVC,tzdVC];
    
    //设置默认vc
    self.currentVC = ylVC;
    [self.view addSubview:ylVC.view];
}

- (void)segmentControlAction:(UISegmentedControl *)seg
{
    NSInteger _currentSegIndex = [seg selectedSegmentIndex];
    [self replaceFromOldViewController:_currentVC toNewViewController:_vcsArr[_currentSegIndex]];
}

- (void)replaceFromOldViewController:(UIViewController *)oldVc toNewViewController:(UIViewController *)newVc{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController    当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的子视图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options              动画效果(渐变,从下往上等等,具体查看API)UIViewAnimationOptionTransitionCrossDissolve
     *  animations            转换过程中得动画
     *  completion            转换完成
     */
    [self addChildViewController:newVc];
    [self transitionFromViewController:oldVc toViewController:newVc duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVc didMoveToParentViewController:self];
            [oldVc removeFromParentViewController];
            self.currentVC = newVc;
        }else{
            self.currentVC = oldVc;
        }
    }];
}


@end
