//
//  HNT_CBCZ_DetailController.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_MXE_DetailController.h"
#import "LLQ_MXE_Detail_Head.h"
#import "LLQ_MXE_Detail_Chart.h"
#import "LLQ_MXE_Detail_Data.h"

#import "LLQ_MXE_Detail_HeadCell.h"
#import "LLQ_MXE_Detail_ChartCell.h"
#import "LLQ_MXE_Detail_DataCell.h"
#import "SGLineDIY.h"
#import "WSLineChartView.h"
#import "ChartPointModel.h"
@interface LLQ_MXE_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) NSMutableArray * charts;


@property (nonatomic,strong) NSMutableArray * heads;
@property (nonatomic,strong) NSMutableArray * chartsArr;
@property (nonatomic,strong) NSMutableArray * chartsArr1;
@property (nonatomic,strong) NSMutableArray * chartsArr2;
@property (nonatomic,strong) NSMutableArray * chartsArr3;
@property (nonatomic,strong) NSMutableArray * chartsArr4;
@property (nonatomic,strong) NSMutableArray * chartsArr5;
@property (nonatomic,strong) NSMutableArray * chartsArr6;


@property (strong, nonatomic)  UITableView *tb;
@property (nonatomic,strong) LLQ_MXE_Detail_Head * headModel;
@property (nonatomic,strong) LLQ_MXE_Detail_Data * dataModel;


@property (nonatomic,strong) NSMutableArray * xMutableArr;
@property (nonatomic,strong) NSMutableArray * yMutableArr;
@property (nonatomic,assign) NSInteger currentLineNum;

@end

@implementation LLQ_MXE_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

-(void)dealloc{
    FuncLog;
}
-(void)loadUi{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
//    self.tb.frame = self.view.bounds;
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb.separatorColor = [UIColor clearColor];
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_MXE_Detail_HeadCell" bundle:nil] forCellReuseIdentifier:@"LLQ_MXE_Detail_HeadCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_MXE_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"LLQ_MXE_Detail_DataCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_MXE_Detail_ChartCell" bundle:nil] forCellReuseIdentifier:@"LLQ_MXE_Detail_ChartCell"];
}



- (NSMutableArray *)xMutableArr
{
    if (!_xMutableArr) {
        _xMutableArr = [NSMutableArray array];
    }
    return _xMutableArr;
}

- (NSMutableArray *)yMutableArr
{
    if (!_yMutableArr) {
        _yMutableArr = [NSMutableArray array];
    }
    return _yMutableArr;
}

-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
//    NSString * urlString = [NSString stringWithFormat:MXE_Datail,self.f_GUID];
//    NSDictionary * dict = @{@"bianhao":self.bianhao,
//                            @"shebeibianhao":self.shebeibianhao
//                            };
    __weak typeof(self)  weakSelf = self;
    NSString * urlString = @"http://192.168.11.113:8080/gdnhmssNew/app/maxieerXX?F_GUID=6DF27CB1142948CD86309D87657142A2";
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {

        if ([json[@"success"] boolValue]) {
            NSMutableArray * datas = [NSMutableArray array];
//            NSMutableArray * charts = [NSMutableArray array];
            
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    LLQ_MXE_Detail_Data * data = [LLQ_MXE_Detail_Data modelWithDict:dict];
                    weakSelf.dataModel = data;
                    
//                    [datas addObject:data];
                }
            }
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in json[@"data"]) {
                    LLQ_MXE_Detail_Head *headModel = [LLQ_MXE_Detail_Head modelWithDict:dic];
                    weakSelf.headModel = headModel;
                }
            }
            
            
            
            NSMutableArray *pointsArr = [NSMutableArray array];
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    LLQ_MXE_Detail_Chart * chart = [LLQ_MXE_Detail_Chart modelWithDict:dict];
//                    [chartDatas addObject:chart];
                    NSArray *yArrs = [chart.f_YSKYLZ componentsSeparatedByString:@"&"];
                    NSArray *xArrs = [chart.f_YSKYXB componentsSeparatedByString:@"&"];
                    for (int i = 0; i<xArrs.count; i++)
                    {
                        NSArray *yArr = [yArrs[i] componentsSeparatedByString:@";"];
                        [self.yMutableArr addObject:yArr];
                
                        NSArray *xArr = [xArrs[i] componentsSeparatedByString:@";"];
                        [self.xMutableArr addObject:xArr];
                        
//                        switch (i) {
//                            case 30:
//                                weakSelf.chartsArr1 = pointsArr;
//                                [pointsArr removeAllObjects];
//                                break;
//                            case 60:
//                                weakSelf.chartsArr2 = pointsArr;
//                                [pointsArr removeAllObjects];
//                                break;
//                            case 90:
//                                weakSelf.chartsArr3 = pointsArr;
//                                [pointsArr removeAllObjects];
//                                break;
//                            case 120:
//                                weakSelf.chartsArr4 = pointsArr;
//                                [pointsArr removeAllObjects];
//                                break;
//                            case 150:
//                                weakSelf.chartsArr5 = pointsArr;
//                                [pointsArr removeAllObjects];
//                                break;
//                            case 180:
//                                weakSelf.chartsArr6 = pointsArr;
//                                [pointsArr removeAllObjects];
//                                break;
//                                
//                            default:
//                                break;
//                        }
                        
//                        for (int a = 0; a<xArr.count; ++a)
//                        {
//                            ChartPointModel *model = [[ChartPointModel alloc] init];
//                            model.y = [yArr[a] floatValue];
//                            model.x = [xArr[a] floatValue];
//                            [pointsArr addObject:model];
//                            
//                        }
                    }
                    
                    

                }
            }
            
            //
//            weakSelf.chartsArr = pointsArr;
            
            weakSelf.datas = datas;
            weakSelf.charts = weakSelf.chartsArr1;
//            weakSelf.chartDatas = chartDatas;
//            weakSelf.titles = titles;
//            weakSelf.charts = charts;

            [weakSelf.tb reloadData];
            [Tools removeActivity];
        }

        //#pragma mark - 因布局设计有卡顿现象，优化方法如下
        //            weakSelf.tb.contentOffset = CGPointMake(0, 220);
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        //                weakSelf.tb.contentOffset = CGPointMake(0, 0);
        //            });
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        
        //            });
        
        
        [self loadUi];
        
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    }
//    if (section == 1) {
//        return self.datas.count+1;
//    }
//    if (section == 2) {
//        return 1;
//    }
//    if (section == 3) {
//        
//        return self.chartDatas.count+1;
//    }
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"流值(mm)   ----   稳定值(KN)";
        case 2:return @"荷载--流值关系图";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125.0f;
    }
    if (indexPath.section == 1) {
        return 140;
    }
    if (indexPath.section == 2) {
        return 180.0f;
    }
//    if (indexPath.section == 3) {
//        return 20;
//    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LLQ_MXE_Detail_HeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_MXE_Detail_HeadCell"];
        cell.model = self.headModel;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        __weak typeof(self)  weakSelf = self;
        LLQ_MXE_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_MXE_Detail_DataCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//        if (indexPath.row > 0) {
//            LLQ_MXE_Detail_Data * data = indexPath.row ==0 ? nil :self.datas[indexPath.row-1];
            //cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
//            cell.color = [UIColor blackColor];
            cell.model= self.dataModel;
            cell.block = ^(NSInteger btnTag)
            {
                switch (btnTag) {
                    case 1:
                    {
                        [weakSelf.charts removeAllObjects];
                        weakSelf.charts = weakSelf.chartsArr1;
                    }
                        break;
                    case 2:
                    {
                        [weakSelf.charts removeAllObjects];
                        weakSelf.charts = weakSelf.chartsArr2;
                    }
                        break;
                    case 3:
                    {
                        [weakSelf.charts removeAllObjects];
                        weakSelf.charts = weakSelf.chartsArr3;
                    }
                        break;
                    case 4:
                    {
                        [weakSelf.charts removeAllObjects];
                        weakSelf.charts = weakSelf.chartsArr4;
                    }
                        break;
                    case 5:
                    {
                        [weakSelf.charts removeAllObjects];
                        weakSelf.charts = weakSelf.chartsArr5;
                    }
                        break;
                    case 6:
                    {
                        [weakSelf.charts removeAllObjects];
                        weakSelf.charts = weakSelf.chartsArr6;
                    }
                        break;
                        
                    default:
                        break;
                }
                _currentLineNum = btnTag;
                NSIndexSet *indexS = [NSIndexSet indexSetWithIndex:2];
                [tableView reloadSections:indexS withRowAnimation:UITableViewRowAnimationAutomatic];
            };
//            }
        return cell;
    }
    if (indexPath.section == 2)
    {
        LLQ_MXE_Detail_ChartCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_MXE_Detail_ChartCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
         WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 0, Screen_w, 180) xTitleArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] xValueArray:self.xMutableArr[0] yValueArray:self.yMutableArr[0] yMax:300 yMin:0];
        wsLine.backgroundColor = [UIColor whiteColor];
        [cell.chartParentView addSubview:wsLine];
        return cell;

    }
//    if (indexPath.section == 3) {
//        SW_LSSJ_Detail_Chart2Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_LSSJ_Detail_Chart2Cell"];
//        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//        if (indexPath.row > 0) {
//            SW_LSSJ_Detail_Chart * model = indexPath.row ==0 ? nil :self.chartDatas[indexPath.row-1];
//            cell.model= model;
//        }
//        return cell;
//
//    }
    
    return nil;
}

@end
