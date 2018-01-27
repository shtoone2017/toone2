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
#import "AAChartView.h"
#import "HNT_TJFX_HeaderView.h"
#import "HNT_TJFX_TxtView.h"
#import "NodeViewController.h"

@interface HNT_TJFX_Controller ()
@property (nonatomic,strong) NSMutableArray * datas;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UIView *container0; //sc的内置控件默认高度1000
@property (weak, nonatomic) IBOutlet UIView *container1; //chat1父视图
@property (weak, nonatomic) IBOutlet UIView *container2; //chat2父视图
@property (weak, nonatomic) IBOutlet UIView *container3; //表格视图父视图
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sc_container_height;

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartView  *aaChartView2;
@end

@implementation HNT_TJFX_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor snowColor];
    self.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",super.startTime,super.endTime];
    [self loadData];
    self.title =@"统计分析";
}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
    for (UIView * subView in self.container3.subviews) {
        if ([subView isKindOfClass:[HNT_TJFX_TxtView class]]) {
            [subView removeFromSuperview];
        }
    }

    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * userGroupId = self.userGroupId;
//    NSString *userGroupId= [UserDefaultsSetting shareSetting].departId;
    NSString * urlString = [NSString stringWithFormat:sysCountAnalyze_3,userGroupId,startTimeStamp,endTimeStamp];
    __weak __typeof(self)  weakSelf = self;
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
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
            AASeriesElement *mode = [[AASeriesElement alloc] init];
            mode.nameSet(model.testName);
            double value =  [(NSString*)model.testCount doubleValue];
            NSNumber *num = [NSNumber numberWithDouble:value];
            mode.dataSet(@[num]);
            [tests addObject:mode];
        }
        self.aaChartView1 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, weakSelf.view.bounds.size.width, 360)];
        self.aaChartView1.contentHeight = 360;
        [self.container1 addSubview:weakSelf.aaChartView1];
        
        self.aaChartModel = AAObject(AAChartModel)
        .chartTypeSet(AAChartTypeColumn)//图表的类型
        .titleSet(@"")//图表标题
        .subtitleSet(@"")//图表副标题
        .categoriesSet(@[@""])//设置图表横轴的内容
        .yAxisTitleSet(@"")//设置图表 y 轴的单位
        .seriesSet(tests);
        self.aaChartModel.dataLabelEnabled = YES;
        [self.aaChartView1 aa_drawChartWithChartModel:_aaChartModel];
        
        //2.notqualifiedCount  不合格的试验数
        NSMutableArray * notqs = [NSMutableArray array];
        for (HNT_TJFX_Model * model in datas) {
            AASeriesElement *mode = [[AASeriesElement alloc] init];
            mode.nameSet(model.testName);
            double value =  [(NSString*)model.notqualifiedCount doubleValue];
            NSNumber *num = [NSNumber numberWithDouble:value];
            mode.dataSet(@[num]);
            [notqs addObject:mode];
        }
        self.aaChartView2 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, weakSelf.view.bounds.size.width, 360)];
        self.aaChartView2.contentHeight = 360;
        [self.container2 addSubview:weakSelf.aaChartView2];
        
        self.aaChartModel = AAObject(AAChartModel)
        .chartTypeSet(AAChartTypeColumn)//图表的类型
        .titleSet(@"")//图表标题
        .subtitleSet(@"")//图表副标题
        .categoriesSet(@[@""])//设置图表横轴的内容
        .yAxisTitleSet(@"")//设置图表 y 轴的单位
        .seriesSet(notqs);
        self.aaChartModel.dataLabelEnabled = YES;
        [self.aaChartView2 aa_drawChartWithChartModel:_aaChartModel];
        
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
        Exp1View * e = [[Exp1View alloc] init];
        if ([_zt isEqualToString:@"1"]) {
            e.frame = CGRectMake(0, 64+35, Screen_w, 190);
            [e hiddenView];
        }
        __weak __typeof(self)  weakSelf = self;
        e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
            NSLog(@"%d",type);
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
            if (type == ExpButtonTypeUsePosition) {//组织机构
                UIButton * btn = (UIButton*)obj1;
                NodeViewController *vc = [[NodeViewController alloc] init];
                vc.type = NodeTypeZZJG;
                vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                    weakSelf.userGroupId = identifier;
                    [btn setTitle:name forState:UIControlStateNormal];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
                UIButton * btn = (UIButton*)obj1;
                [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
            }
        };
        [self.view addSubview:e];
}


@end
