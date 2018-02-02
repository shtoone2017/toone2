//
//  YS_YLJViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_YLJViewController.h"
#import "Exp_Final.h"
#import "AAChartView.h"
#import "YS_YLJModel.h"

#define start_time @"start_time"
#define road_id @"road_id"
#define end_time @"end_time"
#define device_code @"device_code"
#define pressLayer @"pressLayer"

@interface YS_YLJViewController ()
{
    NSArray *datas;
}

@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YS_YLJModel *model;
@property (nonatomic,strong) AAChartView *aaChartView;
@property (nonatomic,strong) Exp_Final *expView;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation YS_YLJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setUpUI];
}

- (void)setUpUI
{
    _currentIndex = 0;
    self.title = @"压路机运行数据";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 80, Screen_w, Screen_h-80-20)];
    [self.view addSubview:_aaChartView];
    [self drawChartWithData:nil index:_currentIndex];
    NSArray *titles = @[@"温度",@"速度",@"环境温度",@"风速",@"湿度"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titles];
    seg.frame = CGRectMake(0,0,150,20);
    seg.selectedSegmentIndex = _currentIndex;
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
}

- (void)segmentControlAction:(UISegmentedControl *)seg
{
    [self drawChartWithData:datas index:seg.selectedSegmentIndex];
}

- (void)searchButtonClick
{
    [self get_expView];
}

- (Exp_Final *)get_expView
{
    NSMutableArray *tempArr = [NSMutableArray array];
    NSArray *keyArr = @[road_id,start_time,end_time,pressLayer,device_code];
    NSArray *titleArr = @[@"线路选择",@"开始时间",@"结束时间",@"面层选择",@"设备选择"];
    NSArray *typeArr = @[
                         [NSNumber numberWithInteger:YS_Search_Type_RoadID],
                         [NSNumber numberWithInteger:YS_Search_Type_StartTime],
                         [NSNumber numberWithInteger:YS_Search_Type_EndTime],
                         [NSNumber numberWithInteger:YS_Search_Type_Layer],
                         [NSNumber numberWithInteger:YS_Search_Type_Divce]
                         ];
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
        _expView.frame = CGRectMake(0, 64, Screen_w, Screen_h-64);
        [self.view addSubview:_expView];
        __weak typeof(self) weakself = self;
        _expView.SearchBlock = ^(NSArray *arr)
        {
            for (Exp_FinalModel *model in arr)
            {
                if (!model.contentId)
                {
                    [SVProgressHUD showErrorWithStatus:@"请完善查询条件"];
                }
                else
                {
                    [weakself.paraDic setObject:model.contentId forKey:model.para_key];
                }
            }
            [weakself requestData];
        };
    }
    return _expView;
}


- (void)requestData
{
    __weak typeof(self) weakself = self;
    if (_paraDic)
    {
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:YS_YLJ parameter:_paraDic success:^(id json)
         {
             datas = [YS_YLJModel arrayOfModelsFromDictionaries:json error:nil];
             [weakself drawChartWithData:datas index:_currentIndex];
         } failure:^(NSError *error) {
             
         }];
    }
}

- (void)drawChartWithData:(NSArray *)datas index:(NSInteger)index
{
    if (!datas || datas.count <=0)
    {
        return;
    }
    NSArray *danweis = @[@"℃",@"m/min",@"℃",@"m/s",@"RH%"];
    NSMutableArray *x_name = [NSMutableArray array];
    NSMutableArray *wendus = [NSMutableArray array];
    NSMutableArray *sudus = [NSMutableArray array];
    NSMutableArray *huanjingwendus = [NSMutableArray array];
    NSMutableArray *fengsus = [NSMutableArray array];
    NSMutableArray *shidus = [NSMutableArray array];
    
    for (YS_YLJModel *model in datas)
    {
        [wendus addObject:[NSNumber numberWithFloat:model.wendu]];
        [sudus addObject:[NSNumber numberWithFloat:model.sudu]];
        [huanjingwendus addObject:[NSNumber numberWithFloat:model.huanjingwendu]];
        [fengsus addObject:[NSNumber numberWithFloat:model.fengsu]];
        [shidus addObject:[NSNumber numberWithFloat:model.shidu]];
        
        [x_name addObject:model.dinweishijian];
    }
    NSMutableArray *allDatas = [NSMutableArray arrayWithObjects:@[wendus,sudus,huanjingwendus,fengsus,shidus], nil];
    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"压路机运行数据")
    .categoriesSet(x_name)//设置图表横轴的内容
    .yAxisTitleSet(danweis[index])//设置图表 y 轴的单位
    .dataLabelEnabledSet(true)//是否直接显示图数据
    .seriesSet(
               @[AAObject(AASeriesElement)
                 .dataSet(allDatas[index])
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
