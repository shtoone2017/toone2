 //
//  Car_localController.m
//  toone
//
//  Created by 上海同望 on 2017/10/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_localController.h"
#import "HNT_BHZ_SB_Controller.h"

@interface Car_localController ()
@property (nonatomic,strong) UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString *maxPageItems;//一页最多显示条数
@property (nonatomic, copy) NSString *status;//状态

@end
@implementation Car_localController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本地查询";
    [self loadUI];
    [self addPanGestureRecognizer];
//    [self getLocation];
}
-(void)loadUI {
    UIButton * btn = [UIButton img_20WithName:@"white_SX"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
}


-(void)searchButtonClick:(UIButton*)sender{
    switch (sender.tag) {
        case 2:{
            sender.enabled = NO;
            //1.
            UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
            backView.frame = CGRectMake(0, 64+35, Screen_w, Screen_h - 49 -64-35);
            backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            backView.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                backView.hidden = NO;
            });
            [self.view addSubview:backView];
            
            //2.
            Exp5View * e = [[Exp5View alloc] init];
            e.stutas = @"选择状态";
            e.frame = CGRectMake(0, 64, Screen_w, 195);
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
                    weakSelf.pageNo = @"1";
//                    [weakSelf loadData];
                    FuncLog;
                }
                if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
                    UIButton * btn = (UIButton*)obj1;
                    [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
                }
                
                if (type == ExpButtonTypeChoiceSBButton) {
                    UIButton * btn = (UIButton*)obj1;
                    __weak typeof(self) weakSelf = self;
                    HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                    vc.type = SBListTypeStatu;
                    vc.callBlock = ^(NSString *banhezhanminchen, NSString *departid) {
                        [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                        weakSelf.status = departid;
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            [self.view addSubview:e];
            break;
        }
        case 3:{
            [super pan];
            break;
        }
        default:
            FuncLog;
            break;
    }
}

@end
