//
//  YS_TPWDViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_TPWDViewController.h"
#import "Exp_Final.h"
#import "AAChartView.h"
#import "YS_YLJModel.h"
#import "YS_TPJCell.h"

#define start_time @"startTime"
#define roadid @"roadId"
#define end_time @"endTime"
#define device_code @"deviceCode"
#define pressLayer @"pressLayer"

@interface YS_TPWDViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *datas;
}

@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YS_YLJModel *model;
@property (nonatomic,strong) AAChartView *aaChartView;
@property (nonatomic,strong) Exp_Final *expView;
@property (nonatomic,assign) NSInteger currentIndex;  //选中的模块
@property (nonatomic,strong) UITableView *tabview;
@property (nonatomic,assign) NSInteger currentPage;  //当前页数

@end

@implementation YS_TPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.paraDic setObject:[UserDefaultsSetting shareSetting].road_id forKey:@"roadId"];
    [self setUpUI];
}

- (void)setUpUI
{
    _currentIndex = 0;
    self.title = @"摊铺机运行数据";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    NSArray *titles = @[@"温度",@"速度"];
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
    
    _tabview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_w, Screen_h) style:UITableViewStyleGrouped];
    _tabview.delegate = self;
    _tabview.dataSource = self;
    _tabview.rowHeight = UITableViewAutomaticDimension;
    _tabview.estimatedRowHeight = 40;
    _tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tabview];
    [_tabview registerNib:[UINib nibWithNibName:@"YS_TPJCell" bundle:nil] forCellReuseIdentifier:@"YS_TPJCell"];
    
    __weak typeof(self) weakself = self;
    _tabview.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        [weakself requestDataWithTag:0];
    }];
    [_tabview.mj_header beginRefreshing];
    
    _tabview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage ++;
        [weakself requestDataWithTag:1];
    }];
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
    NSArray *keyArr = @[roadid,start_time,end_time,pressLayer,device_code];
    NSArray *titleArr = @[@"线路选择",@"开始时间",@"结束时间",@"面层选择",@"设备选择"];
    NSArray *typeArr = @[
                         [NSNumber numberWithInteger:YS_Search_Type_RoadID],
                         [NSNumber numberWithInteger:YS_Search_Type_StartTime],
                         [NSNumber numberWithInteger:YS_Search_Type_EndTime],
                         [NSNumber numberWithInteger:YS_Search_Type_Layer],
                         [NSNumber numberWithInteger:YS_Search_Type_Divce_TPJ]
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
//        _expView.frame = CGRectMake(0, 64, Screen_w, Screen_h-64);
        [self.view addSubview:_expView];
        __weak typeof(self) weakself = self;
        _expView.SearchBlock = ^(NSArray *arr)
        {
            for (Exp_FinalModel *model in arr)
            {
                Exp_FinalModel *model1 = [[Exp_FinalModel alloc] init];
                model1 = arr[0];
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
            [weakself requestDataWithTag:0];
        };
    }
    else
    {
        [self.view addSubview:_expView];
    }
    return _expView;
}


- (void)requestDataWithTag:(NSInteger)tag
{
    //tag 0下拉刷新  1上拉加载
    __weak typeof(self) weakself = self;
    NSString *roadId = [_paraDic objectForKey:@"roadId"];
    if (roadId)
    {
        [_paraDic setObject:@(20) forKey:@"row"];
        [_paraDic setObject:@(_currentPage) forKey:@"page"];
//        NSString *url = @"http://112.124.114.47:8088/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetTpjData?roadId=f9a816c15f7aa4ca015f7cbf18aa004d&pressLayer=2&deviceCode=4953BCCD90659BB7356727C2FC58A8F5&startTime=2017-11-26 09:31:28&endTime=2018-02-05 14:51:24&page=1&row=10";
        NSString *urlString = @"http://112.124.114.47:8088/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetTpjData";
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:_paraDic success:^(id json)
         {
             NSArray *tempArr = [YS_YLJModel arrayOfModelsFromDictionaries:[json objectForKey:@"rows"] error:nil];
             if (tag == 0)
             {
                 if(datas)
                 {
                     [datas removeAllObjects];
                 }
                 datas = [NSMutableArray arrayWithArray:tempArr];
             }
             else
             {
                 if (datas)
                 {
                     [datas addObjectsFromArray:tempArr];
                 }
             }
             [weakself drawChartWithData:datas index:_currentIndex];
             [_tabview reloadData];
             [_tabview.mj_header endRefreshing];
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
    NSArray *danweis = @[@"℃",@"m/min"];
    NSMutableArray *x_name = [NSMutableArray array];
    NSMutableArray *wendus = [NSMutableArray array];
    NSMutableArray *sudus = [NSMutableArray array];

    for (YS_YLJModel *model in datas)
    {
        [wendus addObject:[NSNumber numberWithFloat:model.wendu]];
        [sudus addObject:[NSNumber numberWithFloat:model.sudu]];
        [x_name addObject:model.dinweishijian];
    }
    NSArray *allDatas = @[wendus,sudus];
    NSArray *titles = @[@"温度",@"速度"];
    NSString *name = titles[index];
    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"摊铺机运行数据")
    .categoriesSet(x_name)//设置图表横轴的内容
    .yAxisTitleSet(danweis[index])//设置图表 y 轴的单位
    .dataLabelEnabledSet(true)//是否直接显示图数据
    .seriesSet(
               @[AAObject(AASeriesElement)
                 .nameSet(name)
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YS_TPJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YS_TPJCell"];
    if (indexPath.row == 0)
    {
        cell.wenduLab.text = @"温度";
        cell.timeLab.text = @"时间";
        cell.suduLab.text = @"速度";
        return cell;
    }
    else
    {
        YS_YLJModel *model = datas[indexPath.row-1];
        cell.wenduLab.text = [NSString stringWithFormat:@"%.2f",model.wendu];
        cell.timeLab.text = [NSString stringWithFormat:@"%@",model.dinweishijian];
        cell.suduLab.text = [NSString stringWithFormat:@"%.2f",model.sudu];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 250.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, Screen_w, 240)];
    [self.view addSubview:_aaChartView];
    [self drawChartWithData:datas?:nil index:_currentIndex];
    return _aaChartView;
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
