//
//  SYS_TZD_DetailViewController.m
//  toone
//
//  Created by 景晓峰 on 2017/9/12.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SYS_TZD_DetailViewController.h"
#import "SJ_PHB_ViewController.h"
#import "TZD_DetailViewController.h"
#import "GCB_RWD_DetailController.h"

@interface SYS_TZD_DetailViewController ()

@property (nonatomic,strong) UIViewController * currentVC;

@property (nonatomic,strong) NSArray *vcsArr;

@end

@implementation SYS_TZD_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"详情";
    [self setUpUI];
}

-(void)setUpUI
{
    NSArray *titles = @[@"任务单",@"设计配合比",@"配比通知单"];
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
    
    SJ_PHB_ViewController *phbVC = [[SJ_PHB_ViewController alloc] init];
    phbVC.detailNum = _model.llphbNo;
    [self addChildViewController:phbVC];
    
    TZD_DetailViewController *tzdVC = [[TZD_DetailViewController alloc] init];
    tzdVC.detailNum = _model.sgphbNo;
    [self addChildViewController:tzdVC];
    
    GCB_RWD_DetailController *rwdVC = [[GCB_RWD_DetailController alloc] init];
    rwdVC.detailId = _model.renwuNo;
    rwdVC.biaoshi = @"1";
    [self addChildViewController:rwdVC];
    
    _vcsArr = @[rwdVC,phbVC,tzdVC];
    
    //设置默认vc
    self.currentVC = rwdVC;
    [self.view addSubview:rwdVC.view];
}

- (void)segmentControlAction:(UISegmentedControl *)seg
{
    UIViewController *newVC = _vcsArr[seg.selectedSegmentIndex];
    [self transitionFromViewController:self.currentVC toViewController:newVC duration:0.1 options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
    self.currentVC = newVC;
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
