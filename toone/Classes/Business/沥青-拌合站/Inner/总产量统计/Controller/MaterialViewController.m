//
//  MaterialViewController.m
//  toone
//
//  Created by shtoone on 16/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MaterialViewController.h"
#import "XFSegementView.h"
#import "LQ_ZCL_CL_Controller.h"
#import "LQ_ZCL_CBL_Controller.h"
#import "LQ_BHZ_SB_Controller.h"

@interface MaterialViewController ()<TouchLabelDelegate>

@property (nonatomic, strong) XFSegementView *segementView;
@property (nonatomic, strong) MyTableViewController *controVc;
@property (nonatomic, copy) NSString *shebStr;
@property (nonatomic, copy) NSString *urlString;
@end
@implementation MaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    初始化分页
    self.controVc = [[LQ_ZCL_CL_Controller alloc] init];
    if ([self.controVc isKindOfClass:[LQ_ZCL_CL_Controller class]]) {
        
        [self addChildViewController:self.controVc];
        [self.view addSubview:self.controVc.view];
    }
    [self setSegement];
}

-(void)setSegement {
    self.segementView = [[XFSegementView alloc]initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 35)];
    self.segementView.backgroundColor = [UIColor snowColor];
    self.segementView.titleArray = @[@"产量",@"超标率"];
    self.segementView.touchDelegate = self;
    [self.view addSubview:self.segementView];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_w-40, 0, 40, 40)];
    [searchButton setImage:[UIImage imageNamed:@"black_SX"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.segementView addSubview:searchButton];
}

#pragma mark - 筛选按钮
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
    Exp7View * e = [[Exp7View alloc] init];
    e.frame = CGRectMake(0, 64+36, Screen_w, 294);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2, int buttonTag){
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {//查询
            sender.enabled = YES;
            [backView removeFromSuperview];
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            //重新切换titleButton ， 搜索页码应该回归第一页码
            //            weakSelf.pageNo = @"1";
            //            weakSelf.chuzhileixing = @"";
            switch (buttonTag) {
                case 10://季度
                    NSLog(@"季度");
                    weakSelf.urlString = [self loadUI:@"1"];
                    [weakSelf.controVc reloadData:weakSelf.urlString];
                    break;
                case 20://月份
                    NSLog(@"月份");
                    weakSelf.urlString = [self loadUI:@"2"];
                    [weakSelf.controVc reloadData:weakSelf.urlString];
                    break;
                case 40://周
                    NSLog(@"周");
                    weakSelf.urlString = [self loadUI:@"3"];
                    [weakSelf.controVc reloadData:weakSelf.urlString];
                    break;
                case 50://天
                    NSLog(@"天");
                    weakSelf.urlString = [self loadUI:@"4"];
                    break;
                default:
                    weakSelf.urlString = [self loadUI:@"1"];
                    [weakSelf.controVc reloadData:weakSelf.urlString];
                    break;
            }
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        if (type == ExpButtonTypeChoiceSBButton) {//选择设备
            UIButton * btn = (UIButton*)obj1;
            LQ_BHZ_SB_Controller *sbVc = [[LQ_BHZ_SB_Controller alloc] init];
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.callBlock = ^(NSString *banhezhanminchen,NSString *gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.shebStr = gprsbianhao;
            };
        }
        
    };
    [self.view addSubview:e];
}

- (void)touchLabelWithIndex:(NSInteger)index{
    if (index == 0) { //产量
        [self.controVc removeFromParentViewController];
        [self.controVc.view removeFromSuperview];
        
        self.controVc = [[LQ_ZCL_CL_Controller alloc] init];
        LQ_ZCL_CL_Controller *clVc =(LQ_ZCL_CL_Controller *) self.controVc;
        
        [self addChildViewController:clVc];
        [self.view addSubview:clVc.view];
        [self.view addSubview:self.segementView];
        
    }else if (index == 1) { //超标率
        [self.controVc removeFromParentViewController];
        [self.controVc.view removeFromSuperview];
        
        self.controVc = [[LQ_ZCL_CBL_Controller alloc] init];
        LQ_ZCL_CBL_Controller *cblVc =(LQ_ZCL_CBL_Controller *) self.controVc;
        
        [self addChildViewController:cblVc];
        [self.view addSubview:cblVc.view];
        [self.view addSubview:self.segementView];
    }
}

-(NSString *)loadUI:(NSString *)leixing {
    __weak __typeof(self)  weakSelf = self;
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *startTime = [TimeTools timeStampWithTimeString:weakSelf.startTime];
    NSString *endTime = [TimeTools timeStampWithTimeString:weakSelf.endTime];
    NSString *shebStr = @"";
    if (weakSelf.shebStr) {
        shebStr = weakSelf.shebStr;
    }
    NSString *urlString = [NSString stringWithFormat:LQTotal,shebStr,startTime,endTime,userGroupId,leixing];
    
        return urlString;
}



@end
