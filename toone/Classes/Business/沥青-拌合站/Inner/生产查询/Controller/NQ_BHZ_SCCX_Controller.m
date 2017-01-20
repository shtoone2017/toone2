//
//  ProductionViewController.m
//  toone
//
//  Created by shtoone on 16/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NQ_BHZ_SCCX_Controller.h"
#import "XFSegementView.h"
#import "NQ_BHZ_SCCX_Inner_Controller.h"
#import "DayQueryTableViewController.h"
#import "MaterialTableViewController.h"
#import "LQ_BHZ_SB_Controller.h"

@interface NQ_BHZ_SCCX_Controller ()<TouchLabelDelegate>
@property (nonatomic, strong) XFSegementView *segementView;
@property (nonatomic, strong) MyTableViewController *tableCont;
@property (nonatomic, copy) NSString *shebStr;
@property (nonatomic, copy) NSString *urlString;

@end
@implementation NQ_BHZ_SCCX_Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    //    初始化分页
    self.tableCont = [[NQ_BHZ_SCCX_Inner_Controller alloc] init];
    if ([self.tableCont isKindOfClass:[NQ_BHZ_SCCX_Inner_Controller class]]) {
        
        [self addChildViewController:self.tableCont];
        [self.view addSubview:self.tableCont.view];
    }
    
    [self setSegement];
}

#pragma mark - 设置分页
-(void)setSegement {
   XFSegementView * segementView = [[XFSegementView alloc]initWithFrame:CGRectMake(0, 65,Screen_w, 35)];
    segementView.backgroundColor = [UIColor snowColor];

    segementView.titleArray = @[@"生产数据",@"日产量",@"材料用量"];
    segementView.touchDelegate = self;
    self.navigationItem.titleView = segementView;
    [self.view addSubview:segementView];

    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_w-40, 0, 40, 40)];
    [searchButton setImage:[UIImage imageNamed:@"black_SX"] forState:UIControlStateNormal];

    [searchButton addTarget:self action:@selector(clickSearchBut:) forControlEvents:UIControlEventTouchUpInside];
    [segementView addSubview:searchButton];
    
    self.segementView =segementView;
}

#pragma mark - 查询
-(void)clickSearchBut:(UIButton *)sender {
    sender.enabled = NO;
    //1.
    UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(0, 64+36, Screen_w, Screen_h  -64-36);
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    backView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        backView.hidden = NO;
    });
    [self.view addSubview:backView];
    
    //2.
    Exp5View * e = [[Exp5View alloc] init];
    e.frame = CGRectMake(0, 64+36, Screen_w, 195);
    __weak __typeof(self)  weakSelf = self;
  
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {
            sender.enabled = YES;
            [backView removeFromSuperview];
            //
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            //重新切换titleButton ， 搜索页码应该回归第一页码
            //            weakSelf.pageNo = @"1";
            //            [weakSelf loadData];
            NSString *urlString = [self loadUI];
            [weakSelf.tableCont reloadData:urlString];
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {//选择设备
            UIButton * btn = (UIButton*)obj1;
            LQ_BHZ_SB_Controller *sbVc = [[LQ_BHZ_SB_Controller alloc] init];
            [self.navigationController pushViewController:sbVc animated:YES];
            
            sbVc.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.shebStr = gprsbianhao;
            };
        }
    };
    [self.view addSubview:e];

}

#pragma mark - 分页控制器跳转
- (void)touchLabelWithIndex:(NSInteger)index{
    if (index == 0) { //生产数据查询
        [self.tableCont removeFromParentViewController];
        [self.tableCont.view removeFromSuperview];
        
        self.tableCont = [[NQ_BHZ_SCCX_Inner_Controller alloc] init];
            
        NQ_BHZ_SCCX_Inner_Controller *producVc =(NQ_BHZ_SCCX_Inner_Controller *) self.tableCont;
            
        [self addChildViewController:producVc];
        [self.view addSubview:producVc.view];
        [self.view addSubview:_segementView];
        
    }else if (index == 1) { //日产量查询
        [self.tableCont removeFromParentViewController];
        [self.tableCont.view removeFromSuperview];
        
        self.tableCont = [[DayQueryTableViewController alloc] init];
            
        DayQueryTableViewController *dayVc =(DayQueryTableViewController *) self.tableCont;
            
        [self addChildViewController:dayVc];
        [self.view addSubview:dayVc.view];
        [self.view addSubview:_segementView];
        
    }else if (index == 2) { //材料用量查询
        [self.tableCont removeFromParentViewController];
        [self.tableCont.view removeFromSuperview];
        
        self.tableCont = [[MaterialTableViewController alloc] init];
        
        MaterialTableViewController *materVc =(MaterialTableViewController *) self.tableCont;
        
        [self addChildViewController:materVc];
        [self.view addSubview:materVc.view];
        [self.view addSubview:_segementView];
        
    }
}
#pragma mark - 筛选刷新
-(NSString *)loadUI {
    __weak __typeof(self)  weakSelf = self;
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *shebStr = @"";
    if (weakSelf.shebStr) {
        shebStr = weakSelf.shebStr;
    }
    NSString *startTime = [TimeTools timeStampWithTimeString:weakSelf.startTime];
    NSString *endTime = [TimeTools timeStampWithTimeString:weakSelf.endTime];
    NSString *page = @"1";
    //判断页面
    if ([weakSelf.tableCont isKindOfClass:[NQ_BHZ_SCCX_Inner_Controller class]]) {//生产数据查询
        NSString *urlString = [NSString stringWithFormat:ProduQuery,userGroupId,shebStr,startTime,endTime,page];
        return urlString;
    }else if ([weakSelf.tableCont isKindOfClass:[DayQueryTableViewController class]]) {//日生产量查询
        NSString *urlString = [NSString stringWithFormat:DayQuery,userGroupId,shebStr,startTime,endTime,page];
        return urlString;
    }else if ([weakSelf.tableCont isKindOfClass:[MaterialTableViewController class]]) {//材料用量查询
        NSString *urlString = [NSString stringWithFormat:LQMaterial,shebStr,startTime,endTime,userGroupId];
        return urlString;
    }
    return nil;
}

@end
