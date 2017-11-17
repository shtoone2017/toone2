//
//  HNT_TJFX_Controller.m
//  toone
//
//  Created by 十国 on 16/12/8.
//  Copyright © 2016年 shtoone. All rights reserved.
//
#import "Exp1View.h"
#import "HNT_TJFX_Controller.h"
#import "HNT_TJFX_Model.h"
#import "BarModel.h"
#import "BarChartViewController.h"
#import "HNT_TJFX_HeaderView.h"
#import "HNT_TJFX_TxtView.h"
#import "SW_ZZJG_Controller.h"
@interface HNT_TJFX_Controller ()
@property (nonatomic,strong) NSMutableArray * datas;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UIView *container0; //sc的内置控件默认高度1000
@property (weak, nonatomic) IBOutlet UIView *container1; //chat1父视图
@property (weak, nonatomic) IBOutlet UIView *container2; //chat2父视图
@property (weak, nonatomic) IBOutlet UIView *container3; //表格视图父视图
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sc_container_height;

@property (nonatomic,strong)  SW_ZZJG_Data * condition;
@end

@implementation HNT_TJFX_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"统计分析";
    self.view.backgroundColor = [UIColor snowColor];
    self.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",super.startTime,super.endTime];
    [self loadData];
}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
    for (UIView * subView in self.container1.subviews) {
        if ([subView isKindOfClass:[BarChartViewController class]]) {
            [subView removeFromSuperview];
        }
    }
    for (UIView * subView in self.container2.subviews) {
        if ([subView isKindOfClass:[BarChartViewController class]]) {
            [subView removeFromSuperview];
        }
    }
    for (UIView * subView in self.container3.subviews) {
        if ([subView isKindOfClass:[HNT_TJFX_TxtView class]]) {
            [subView removeFromSuperview];
        }
    }
    NSString * urlString = TJFXList;
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * biaoshi = @"";
    NSString * departType = @"";
    if ([self.condition.departType isEqualToString:@"1"] || !self.condition) {//第一次
        departType = @"1";
        
    }else if ([[UserDefaultsSetting shareSetting].userType isEqualToString:@"6"]) {
        biaoshi = [UserDefaultsSetting shareSetting].biaoshi;
        departType = @"6";
    }else {
        biaoshi = self.condition.biaoshiid;
        departType = self.condition.departType;
    }
    NSDictionary * dict = @{@"departType":departType,
                            @"biaoshiid":biaoshi,
                            @"endTime":endTimeStamp,
                            @"startTime":startTimeStamp,
                            };
    __weak __typeof(self)  weakSelf = self;
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:dict success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
               
                for (NSDictionary * dict in json[@"data"]) {
                    HNT_TJFX_Model * model = [HNT_TJFX_Model modelWithDict:dict];
                    [datas addObject:model];
                }
                weakSelf.datas = datas;
            }
        }
        
        //数据处理加载ui
        //1.试验总数
        NSMutableArray * tests = [NSMutableArray array];
        for (HNT_TJFX_Model * model in datas) {
            BarModel * bar = [[BarModel alloc] init];
            bar.name = model.testName;
            bar.value = model.testCount;
            [tests addObject:bar];
        }
        BarChartViewController * chat1VC = [[BarChartViewController alloc] initWithArr:tests];
        chat1VC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 360);
        [self addChildViewController:chat1VC];
        [self.container1 addSubview:chat1VC.view];
        
        //2.notqualifiedCount  不合格的试验数
        NSMutableArray * notqs = [NSMutableArray array];
        for (HNT_TJFX_Model * model in datas) {
            BarModel * bar = [[BarModel alloc] init];
            bar.name = model.testName;
            bar.value = model.notqualifiedCount;
            [notqs addObject:bar];
        }
        BarChartViewController * chat2VC = [[BarChartViewController alloc] initWithArr:notqs];
        chat2VC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 360);
        [self addChildViewController:chat2VC];
        [self.container2 addSubview:chat2VC.view];
        
        //3.0
        HNT_TJFX_HeaderView * header = [[NSBundle mainBundle] loadNibNamed:@"HNT_TJFX_HeaderView" owner:self options:nil].firstObject;
        header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
        [self.container3 addSubview:header];
        
        int i=0;
        for (HNT_TJFX_Model * model in datas) {
            HNT_TJFX_TxtView * txtView =  [[NSBundle mainBundle] loadNibNamed:@"HNT_TJFX_TxtView" owner:self options:nil].firstObject;
            txtView.frame = CGRectMake(0, CGRectGetMaxY(header.frame)+1+20*i, self.view.bounds.size.width, 20);
            [self.container3 addSubview:txtView];
            
            txtView.model = model;
            i++;
        }
        
        //移除指示器
        [Tools removeActivity];

    } failure:^(NSError *error) {
    }];
}


-(void)dealloc{
    FuncLog;
}
- (IBAction)searchButtonClick:(UIButton *)sender {
        sender.enabled = NO;
        //1.
        UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
        backView.frame = CGRectMake(0, 64+35, Screen_w, Screen_h -64-35);
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        backView.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            backView.hidden = NO;
        });
        [self.view addSubview:backView];
        
        //2.
        Exp52View * e = [[Exp52View alloc] init];
        e.txfx = @"组织机构";
        e.frame = CGRectMake(0, 64+35, Screen_w, 190);
        __weak __typeof(self)  weakSelf = self;
        e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
//            NSLog(@"%d",type);
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
                weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",weakSelf.startTime,weakSelf.endTime];
                [weakSelf loadData];
                FuncLog;
            }
            if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
                UIButton * btn = (UIButton*)obj1;
                [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
            }
//            if (type == ExpButtonTypeChoiceSBButton) {
//            }
            if (type == ExpButtonTypeUsePosition) {
                UIButton * btn = (UIButton*)obj1;
                SW_ZZJG_Controller * controller = [[SW_ZZJG_Controller alloc] init];
                __weak typeof(self) weakSelf = self;
                controller.modelType = @"3,4";
                controller.zzjgCallBackBlock = ^(SW_ZZJG_Data * data){
                    weakSelf.condition = data;
                    [btn setTitle:weakSelf.condition.name forState:UIControlStateNormal];
                };
                [self.navigationController pushViewController:controller animated:YES];
            }
        };
        [self.view addSubview:e];
}

-(void)loadEquipment {
    
}


@end
