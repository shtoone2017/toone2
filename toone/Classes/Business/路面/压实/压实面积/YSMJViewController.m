//
//  YSMJViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSMJViewController.h"
#import "Exp_Final.h"
#import "AAChartView.h"
#import "YS_MJModel.h"

#define grid_layer @"grid_layer"
#define road_id @"road_id"
#define start_stake @"start_stake"
#define end_stake @"end_stake"


@interface YSMJViewController ()
@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YS_MJModel *model;
@property (nonatomic,strong) AAChartView *aaChartView;
@property (nonatomic,strong) Exp_Final *expView;
@end

@implementation YSMJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestArea];
    [self setUpUI];
}

- (void)setUpUI
{
    self.title = @"压实面积统计";
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 80, Screen_w, Screen_h-80-20)];
    [self.view addSubview:_aaChartView];
    [self drawChartWithModel:nil];
}

- (void)searchButtonClick
{
    [self get_expView];
}

- (Exp_Final *)get_expView
{
    NSMutableArray *tempArr = [NSMutableArray array];
    NSArray *keyArr = @[road_id,start_stake,end_stake,grid_layer];
    NSArray *titleArr = @[@"线路选择",@"起始桩号",@"结束桩号",@"面层选择"];
    NSArray *typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_RoadID],[NSNumber numberWithInteger:YS_Search_Type_StartStack],[NSNumber numberWithInteger:YS_Search_Type_EndStack],[NSNumber numberWithInteger:YS_Search_Type_Layer]];
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
            [weakself requestArea];
        };
    }
    return _expView;
}


- (void)requestArea
{
    __weak typeof(self) weakself = self;
    if (_paraDic)
    {
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:YS_Mianji parameter:_paraDic success:^(id json)
         {
             _model = [[YS_MJModel alloc] initWithDictionary:json error:nil];
             [weakself drawChartWithModel:_model];
         } failure:^(NSError *error) {
             
         }];
    }
}

- (void)drawChartWithModel:(YS_MJModel *)model
{
    if (!model)
    {
        model = [YS_MJModel new];
        model.gy = 0.3;
        model.qy = 0.3;
        model.zc = 0.4;
    }
    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypePie)
    .titleSet(@"压实情况统计")
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .seriesSet(
               @[AAObject(AASeriesElement)
                 .dataSet(@[
                            @[@"过压"  , @(model.gy)],
                            @[@"欠压"  , @(model.qy)],
                            @[@"正常"  , @(model.zc)]
                            ]),
                 ]
               );
    
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
