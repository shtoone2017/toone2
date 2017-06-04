//
//  TP_NY_Controller.m
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_MXE_DetailsController.h"
//#import "MyTPSegmentedControl.h"
#import "LQ_BHZ_SB_Controller.h"
#import "NetworkTool.h"
#import "TP_NY_ChartModel.h"
#import "TP_NYSDList_Model.h"
#import "SGChart.h"
#import "LLQ_MXE_Cell.h"
#import "LLQ_MXE_Model.h"
//#import "TP_NYSDList_Cell.h"
//#import "TP_NYSDList_Cell1.h"
//#import "TP_NY_SB_Controller.h"

@interface LLQ_MXE_DetailsController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstBackView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (nonatomic, strong) TP_NY_ChartModel *chartModel;
@property (nonatomic, strong) TP_NYSDList_Model *listModel;
@property (nonatomic, strong) NSMutableArray *chaoX;
@property (nonatomic, strong) NSMutableArray *chaoBiaoDatas;//图表数据
@property (nonatomic, strong) NSMutableArray *sdArray;//速度表格
@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *ListTableView;
@property (weak, nonatomic) IBOutlet UILabel *chartLabel;//图表表头
@property (weak, nonatomic) IBOutlet UILabel *listLabel;//表格表头
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString * maxPageItems;//一页最多显示条数
@property (nonatomic,copy) NSString * shebeibianhao;//设备编号
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *baseUrlString;
@property (nonatomic, assign) int wdIndex;//标记温度Label
@end
@implementation LLQ_MXE_DetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wdIndex = 2;
    self.pageNo = @"1";
    self.maxPageItems = @"15";
    self.shebeibianhao = @"";

    _baseUrlString=TP_NYSD_List;
    
    [self loadUI];
//    [self loadListTableView];
    [self reloadData];
}


-(void)loadListTableView {
    self.firstBackView.backgroundColor = [UIColor snowColor];
    self.ListTableView.tableFooterView = [[UIView alloc] init];
    self.ListTableView.separatorColor = [UIColor clearColor];
    
    __weak __typeof(self) weakSelf = self;
    self.ListTableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        weakSelf.listLabel.text = [NSString stringWithFormat:@"速度查询列表--第%@页--",weakSelf.pageNo];
        [weakSelf reloadData];
    }];
    self.ListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        weakSelf.listLabel.text = [NSString stringWithFormat:@"速度查询列表--第%@页--",weakSelf.pageNo];
        [weakSelf reloadData];
    }];
    [self.ListTableView registerNib:[UINib nibWithNibName:@"TP_NYSDList_Cell" bundle:nil] forCellReuseIdentifier:@"TP_NYSDList_Cell"];
    [self.ListTableView registerNib:[UINib nibWithNibName:@"TP_NYSDList_Cell1" bundle:nil] forCellReuseIdentifier:@"TP_NYSDList_Cell1"];
}

-(void)loadUI{
//    self.listLabel.text = [NSString stringWithFormat:@"速度查询列表--第%@页--",self.pageNo];
//    self.chartLabel.text = @"速度走势图(km/h)";
    
//    self.sjLabel.textColor = [UIColor blackColor];
//    self.sjLabel.numberOfLines = 2;
//    self.sjLabel.text = [NSString stringWithFormat:@"%@开始~%@结束",self.startTime,self.endTime];
//    self.navigationItem.title = @"终压温度";
    __weak typeof(self)  weakSelf = self;
                self.wdIndex = 2;
                self.pageNo = @"1";
//                self.listLabel.text = [NSString stringWithFormat:@"温度查询列表--第%@页--",weakSelf.pageNo];
//                self.chartLabel.text = @"温度走势图(℃)";
//                NSString *userGroupId = [UserDefaultsSetting shareSetting].departId;
//                NSString *startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
//                NSString *endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
//                NSString *urlString = [NSString stringWithFormat:TP_NYWD_List,userGroupId,weakSelf.shebeibianhao,startTimeStamp,endTimeStamp,weakSelf.pageNo,self.maxPageItems];
//                weakSelf.urlString = urlString;
                _baseUrlString=TP_NYWD_List;
                [self reloadData];
}
#pragma mark - 网络请求
-(void)reloadData {
    
    NSString *userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString *endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString *urlString = [NSString stringWithFormat:    _baseUrlString,userGroupId,self.shebeibianhao,startTimeStamp,endTimeStamp,self.pageNo,self.maxPageItems];
    
//    NSLog(@"urlString~~%@",urlString );
    
    __weak typeof(self) weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([result[@"success"] boolValue]) {
            if ([result[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dic in result[@"data"]) {//表格
                    weakSelf.listModel = [TP_NYSDList_Model modelWithDict:dic];
                    [arr addObject:weakSelf.listModel];
                }
            }

            self.sdArray = arr;
            
            NSMutableArray *datas = [NSMutableArray array];
            NSMutableArray *nyX = [NSMutableArray array];
        if ([result[@"chart"] isKindOfClass:[NSArray class]]) {//表格
            for (NSDictionary *dict in result[@"chart"]) {//图表
                weakSelf.chartModel = [TP_NY_ChartModel modelWithDict:dict];
                if (weakSelf.chartModel.sudu) {
                    [datas addObject:weakSelf.chartModel.sudu];
                }if (weakSelf.chartModel.wendu) {
                    [datas addObject:weakSelf.chartModel.wendu];
                }
                [nyX addObject:weakSelf.chartModel.shijian];
            }
        }

            weakSelf.chaoX = nyX;
            weakSelf.chaoBiaoDatas = datas;
            SGLineDIY *lineChart = [[SGLineDIY alloc]  initWithFrame:CGRectMake(0, 0, Screen_w, 180) data:weakSelf.chaoBiaoDatas title:weakSelf.chaoX color:[UIColor redColor]];
            lineChart.backgroundColor = [UIColor whiteColor];
            [self.chartView addSubview:lineChart];
            //1.
//            if ([weakSelf.pageNo intValue] == 1) {
                weakSelf.sdArray = arr;
                weakSelf.chaoX = nyX;
                weakSelf.chaoBiaoDatas = datas;
//            }else{
//                [weakSelf.sdArray addObjectsFromArray:arr];
//                [weakSelf.chaoX addObjectsFromArray:nyX];
//                [weakSelf.chaoBiaoDatas addObjectsFromArray:datas];
//            }
//            //2.
            [weakSelf.ListTableView reloadData];
            [weakSelf.ListTableView.mj_header endRefreshing];
            [weakSelf.ListTableView.mj_footer endRefreshing];
//            //3.
            if (weakSelf.sdArray.count < [weakSelf.maxPageItems intValue]) {
                [weakSelf.ListTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.ListTableView reloadData];
        }else{
            [Tools tip:@"success~~0"];
        }
    }];
}
#pragma mark -delegateSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//        return 20;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLQ_MXE_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_MXE_Cell" forIndexPath:indexPath];
//    LLQ_MXE_Model * model = self.datas[indexPath.row];
//    cell.model = model;
    return cell;
}


@end
