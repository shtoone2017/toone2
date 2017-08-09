//
//  BFViewController.m
//  toone
//
//  Created by 上海同望 on 2017/8/4.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "BFViewController.h"
#import "MySegmentedControl.h"
#import "ScreenView.h"
#import "HNT_BHZ_SB_Controller.h"

@interface BFViewController ()
{
    ScreenView *scView;
    BOOL isShowScreenView;
}
@end

@implementation BFViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (scView)
    {
        [scView.tbView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    
    //kvo监听时间变化
    [self addObserver:self forKeyPath:@"selectTime" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"selectTime"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [scView.tbView reloadData];
}

-(void)loadUI{
    //    self.containerView.backgroundColor = BLUECOLOR;
    //顶部UISegmentedControl
    NSArray *titles = @[@"进场过磅",@"出场过磅"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titles];
    seg.frame = CGRectMake(0,0,150,20);
    seg.selectedSegmentIndex = 0;
    seg.tintColor = [UIColor whiteColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:12],
                         NSFontAttributeName,nil];
    
    [seg setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:12],
                          NSFontAttributeName,nil];
    
    [seg setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [seg addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    
    [self createScreenView];
    
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
}

- (void)segmentControlAction:(UISegmentedControl *)seg
{
    NSInteger index = [seg selectedSegmentIndex];
    if (index == 0)
    {
        //进场
    }
    else
    {
        //出场
    }
}

-(void)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 2:
            if (isShowScreenView == YES)
            {
                [self hidenScreenView];
            }
            else
            {
                [self showScreenView];
            }
            isShowScreenView = !isShowScreenView;
            break;
        case 3:
            [super pan];
            break;
            
        default:
            break;
    }
    
}

- (void)createScreenView
{
    NSArray *titleArr = @[@"所属机构:",@"磅房名称:",@"材料名称:",@"进场时间:",@"批次:",@"车牌号:"];
    scView = [[ScreenView alloc] initWithFrame: CGRectMake(Screen_w, 0, Screen_w-30, Screen_h) titleArr:titleArr type:ScreenViewTypeBF];
    scView.backgroundColor = [UIColor cyanColor];
    scView.block = ^(BOOL isShow) {
        isShowScreenView = isShow;
    };
    [self.view addSubview:scView];
}

- (void)showScreenView
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(30, 0, Screen_w-30, Screen_h);
    } completion:nil];
}

- (void)hidenScreenView
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(Screen_w, 0, Screen_w-30, Screen_h);
    } completion:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[HNT_BHZ_SB_Controller class]]) {
        HNT_BHZ_SB_Controller * controller = vc;
        __weak UIButton * weakBtn = sender;
        __weak __typeof(self)  weakSelf = self;
        controller.title = @"选择设备";
//        controller.departId = self.departId;
        controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
            [weakBtn setTitle:banhezhanminchen forState:UIControlStateNormal];
//            weakSelf.shebeibianhao = gprsbianhao;
        };
        
    }
    
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
