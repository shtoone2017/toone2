//
//  HNT_CBCZ_DetailController.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_LSSJ_DetailController.h"
#import "LLQ_LSSJ_Detail_Head.h"
#import "LLQ_LSSJ_Detail_Data.h"
#import "LLQ_LSSJ_Detail_Chart.h"

#import "LLQ_LSSJ_Detail_DataCell.h"
#import "LLQ_LSSJ_Detail_HeadCell.h"
#import "LLQ_LSSJ_Detail_ChartCell.h"
#import "SGLineDIY.h"
@interface LLQ_LSSJ_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) NSMutableArray * chartDatas;
@property (nonatomic,strong) NSMutableArray * charts;
@property (nonatomic,strong) NSMutableArray * titles;
@property (nonatomic,strong) NSMutableArray * colors;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,strong) LLQ_LSSJ_Detail_Head * headModel;
@end

@implementation LLQ_LSSJ_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUi];
    [self loadData];
}

-(void)dealloc{
    FuncLog;
}
-(void)loadUi{
     self.tb.tableFooterView = [[UIView alloc] init];
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_LSSJ_Detail_HeadCell" bundle:nil] forCellReuseIdentifier:@"LLQ_LSSJ_Detail_HeadCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_LSSJ_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"LLQ_LSSJ_Detail_DataCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_LSSJ_Detail_ChartCell" bundle:nil] forCellReuseIdentifier:@"LLQ_LSSJ_Detail_ChartCell"];

}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
    NSString * urlString = liqingxixx;
    NSDictionary * dict = @{@"bianhao":self.bianhao,
                            @"shebeibianhao":self.shebeibianhao
                            };
    __weak typeof(self)  weakSelf = self;
    
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:dict success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        NSMutableArray * chartDatas = [NSMutableArray array];
        NSMutableArray * charts = [NSMutableArray array];
        NSMutableArray * titles = [NSMutableArray array];
        NSMutableArray * colors = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"lqData"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"lqData"]) {
                    LLQ_LSSJ_Detail_Data * data = [LLQ_LSSJ_Detail_Data modelWithDict:dict];
                    [datas addObject:data];
                }
            }
            if ([json[@"lqHead"] isKindOfClass:[NSDictionary class]]) {
                LLQ_LSSJ_Detail_Head * headModel = [LLQ_LSSJ_Detail_Head modelWithDict:json[@"lqHead"]];
                weakSelf.headModel = headModel;
            }
            
            if ([json[@"lqChartDataList"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"lqChartDataList"]) {
//                    LLQ_LSSJ_Detail_Chart * chart = [LLQ_LSSJ_Detail_Chart modelWithDict:dict];
//                    [chartDatas addObject:chart];
                    
                    
                    NSMutableArray * point = [NSMutableArray array];
                    [point addObject:dict[@"maxPassper"]];//允许波动上限
                    [point addObject:dict[@"minPassper"]];//允许波动下限
                    [point addObject:dict[@"passper"]];//实际级配
                    [point addObject:dict[@"standPassper"]];//标准级配
                    
                    [titles addObject:dict[@"name"]];
                    [charts addObject:point];
                    

                }
            }
        }
        [colors addObject:[UIColor redColor]];
        [colors addObject:[UIColor magentaColor]];
        [colors addObject:[UIColor greenColor]];
        [colors addObject:[UIColor blueColor]];
        //
        weakSelf.datas = datas;
        weakSelf.chartDatas = chartDatas;
        weakSelf.titles = titles;
        weakSelf.charts = charts;
        weakSelf.colors = colors;
        [weakSelf.tb reloadData];
        
        //#pragma mark - 因布局设计有卡顿现象，优化方法如下
        //            weakSelf.tb.contentOffset = CGPointMake(0, 220);
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        //                weakSelf.tb.contentOffset = CGPointMake(0, 0);
        //            });
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [Tools removeActivity];
        //            });
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.datas.count+1;
    }
    if (section == 2) {
        return 1;
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"采集数据";
        case 2:return @"基层合成级配曲线图";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140.0f;
    }
    if (indexPath.section == 1) {
        return 20;
    }
    if (indexPath.section == 2) {
        return 200.0f;
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LLQ_LSSJ_Detail_HeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_LSSJ_Detail_HeadCell"];
        cell.model = self.headModel;
        return cell;
    }
    if (indexPath.section == 1) {
        LLQ_LSSJ_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_LSSJ_Detail_DataCell"];
        if (indexPath.row > 0) {
            LLQ_LSSJ_Detail_Data * data = indexPath.row ==0 ? nil :self.datas[indexPath.row-1];
            cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
            cell.model= data;
        }
        return cell;
    }
    if (indexPath.section == 2) {
        LLQ_LSSJ_Detail_ChartCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_LSSJ_Detail_ChartCell"];
        
        if (self.titles.count > 0) {
            SGLineDIY * line = [[SGLineDIY alloc] initWithFrame:CGRectMake(0, 0, Screen_w, 180) data:self.charts title:self.titles color:self.colors];
            line.backgroundColor = [UIColor whiteColor];
            [cell.chartParentView addSubview:line];
        }
       
        return cell;

    }
    return nil;
}

@end
