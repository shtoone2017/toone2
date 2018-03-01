//
//  YS_JLViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_JLViewController.h"

#import "Exp_Final.h"
#import "AAChartView.h"
#import "YS_JLModel.h"

#define start_time @"start_time"
#define road_id @"road_id"
#define end_time @"end_time"
#define device_code @"device_code"


@interface YS_JLViewController ()
@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YS_JLModel *model;
@property (nonatomic,strong) AAChartView *aaChartView;
@property (nonatomic,strong) Exp_Final *expView;
@end

@implementation YS_JLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setUpUI];
}

- (void)setUpUI
{
    self.title = @"压路机距离统计";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 80, Screen_w, Screen_h-80-20)];
    [self.view addSubview:_aaChartView];
    [self drawChartWithData:nil];
}

- (void)searchButtonClick
{
    [self get_expView];
}

- (Exp_Final *)get_expView
{
    NSMutableArray *tempArr = [NSMutableArray array];
    NSArray *keyArr = @[road_id,start_time,end_time,device_code];
    NSArray *titleArr = @[@"线路选择",@"开始时间",@"结束时间",@"设备选择"];
    NSArray *typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_RoadID],[NSNumber numberWithInteger:YS_Search_Type_StarTime],[NSNumber numberWithInteger:YS_Search_Type_EndTimes],[NSNumber numberWithInteger:YS_Search_Type_Divce_YLJ]];
    for (int i = 0; i<titleArr.count; i++)
    {
        Exp_FinalModel *model = [[Exp_FinalModel alloc] init];
        model.title = titleArr[i];
        model.type = [typeArr[i] integerValue];
        model.para_key = keyArr[i];
        [tempArr addObject:model];
    }
    ;
    if (!_expView) {
        _expView = [[[NSBundle mainBundle] loadNibNamed:@"Exp_Final" owner:self options:nil] objectAtIndex:0];
        _expView.dataArr = tempArr;
//        _expView.frame = CGRectMake(0, 64, Screen_w, Screen_h-64);
        [self.view addSubview:_expView];
        __weak typeof(self) weakself = self;
        _expView.SearchBlock = ^(NSArray *arr)
        {
            for (Exp_FinalModel *model in arr)
            {
                if (!model.contentId)
                {
                    [SVProgressHUD showErrorWithStatus:@"请完善查询条件"];
                    return;
                }
                else
                {
                    [weakself.paraDic setObject:model.contentId forKey:model.para_key];
                }
            }
            [weakself requestData];
        };
    }
    else{
        [self.view addSubview:_expView];
        
    }
    return _expView;
}


- (void)requestData
{
    __weak typeof(self) weakself = self;
    if (_paraDic)
    {
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:YS_JuLi parameter:_paraDic success:^(id json)
         {
             NSArray *data = [YS_JLModel arrayOfModelsFromDictionaries:[json objectForKey:@"obj"] error:nil];
             [weakself drawChartWithData:data];
         } failure:^(NSError *error) {
             
         }];
    }
}

- (void)drawChartWithData:(NSArray *)datas
{
    NSMutableArray *names = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];

    for (YS_JLModel *model in datas)
    {
        [names addObject:model.date];
        [values addObject:[NSNumber numberWithFloat:model.statistics]];
    }
    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"运行距离统计")
    .categoriesSet(names)//设置图表横轴的内容
    .yAxisTitleSet(@"km")//设置图表 y 轴的单位
    .dataLabelEnabledSet(true)//是否直接显示图数据
    .seriesSet(
               @[AAObject(AASeriesElement)
                 .dataSet(values)
               ]);
    
    /*图表视图对象调用图表模型对象,绘制最终图形*/
    [_aaChartView aa_drawChartWithChartModel:chartModel];
}

- (NSMutableDictionary *)paraDic
{
    if (!_paraDic)
    {
        _paraDic = [NSMutableDictionary dictionary];
    }
    return _paraDic;
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
