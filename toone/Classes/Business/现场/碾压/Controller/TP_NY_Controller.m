//
//  TP_NY_Controller.m
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_NY_Controller.h"
#import "MyTPSegmentedControl.h"
#import "LQ_BHZ_SB_Controller.h"
#import "NetworkTool.h"
#import "TP_NY_ChartModel.h"
#import "TP_NYSDList_Model.h"
#import "SGChart.h"
#import "TP_NYSDList_Cell.h"
#import "TP_NYSDList_Cell1.h"
#import "TP_NY_SB_Controller.h"
#import "LLQ_SB_Controller.h"

@interface TP_NY_Controller ()<UITableViewDataSource,UITableViewDelegate>
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
@property (nonatomic, copy) NSString *biaoshiid;

@property (nonatomic, copy) NSString *baseUrlString;
@property (nonatomic, assign) int wdIndex;//标记温度Label
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;


@end
@implementation TP_NY_Controller

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (kDevice_Is_iPhoneX) {
        self.top.constant = 88;
    }else {
        self.top.constant = 64;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.wdIndex = 2;
    self.pageNo = @"1";
    self.maxPageItems = @"15";
    self.shebeibianhao = @"";
    self.biaoshiid = @"";
    _baseUrlString=TP_ZYWD;
    
    [self loadUI];
    [self loadListTableView];
    [self reloadData];
}


-(void)loadListTableView {
    self.firstBackView.backgroundColor = [UIColor snowColor];
    self.ListTableView.tableFooterView = [[UIView alloc] init];
    self.ListTableView.separatorColor = [UIColor clearColor];
    
    __weak __typeof(self) weakSelf = self;
    self.ListTableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        weakSelf.listLabel.text = [NSString stringWithFormat:@"温度查询列表--第%@页--",weakSelf.pageNo];
        [weakSelf reloadData];
    }];
    self.ListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        weakSelf.listLabel.text = [NSString stringWithFormat:@"温度查询列表--第%@页--",weakSelf.pageNo];
        [weakSelf reloadData];
    }];
    [self.ListTableView registerNib:[UINib nibWithNibName:@"TP_NYSDList_Cell" bundle:nil] forCellReuseIdentifier:@"TP_NYSDList_Cell"];
    [self.ListTableView registerNib:[UINib nibWithNibName:@"TP_NYSDList_Cell1" bundle:nil] forCellReuseIdentifier:@"TP_NYSDList_Cell1"];
}

-(void)loadUI{
    self.listLabel.text = [NSString stringWithFormat:@"速度查询列表--第%@页--",self.pageNo];
    self.chartLabel.text = @"速度走势图(km/h)";
    
    self.sjLabel.textColor = [UIColor blackColor];
    self.sjLabel.numberOfLines = 2;
    self.sjLabel.text = [NSString stringWithFormat:@"%@开始~%@结束",self.startTime,self.endTime];
    
//    MyTPSegmentedControl * seg = [[NSBundle mainBundle] loadNibNamed:@"MyTPSegmentedControl" owner:nil options:nil][0];
//    seg.frame = CGRectMake(0, 0, 220, 24);
//    self.navigationItem.titleView = seg;
    self.navigationItem.title = @"终压温度";
    __weak typeof(self)  weakSelf = self;
//    seg.segBlock = ^(int tag){
//        switch (tag) {
//            case 1:{//速度
//                self.wdIndex = 1;
//                self.pageNo = @"1";
//                self.listLabel.text = [NSString stringWithFormat:@"速度查询列表--第%@页--",weakSelf.pageNo];
//                self.chartLabel.text = @"速度走势图(km/h)";
////                NSString *userGroupId = [UserDefaultsSetting shareSetting].departId;
////                NSString *startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
////                NSString *endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
////                NSString *urlString = [NSString stringWithFormat:TP_NYSD_List,userGroupId,weakSelf.shebeibianhao,startTimeStamp,endTimeStamp,weakSelf.pageNo,self.maxPageItems];
////                weakSelf.urlString = urlString;
//                    _baseUrlString=TP_NYSD_List;
//                [self reloadData];
//                break;
//            }
//            case 2:{//温度
                self.wdIndex = 2;
                self.pageNo = @"1";
                self.listLabel.text = [NSString stringWithFormat:@"温度查询列表--第%@页--",weakSelf.pageNo];
                self.chartLabel.text = @"温度走势图(℃)";
//                NSString *userGroupId = [UserDefaultsSetting shareSetting].departId;
//                NSString *startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
//                NSString *endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
//                NSString *urlString = [NSString stringWithFormat:TP_NYWD_List,userGroupId,weakSelf.shebeibianhao,startTimeStamp,endTimeStamp,weakSelf.pageNo,self.maxPageItems];
//                weakSelf.urlString = urlString;
                _baseUrlString=TP_ZYWD;
                [self reloadData];
//                break;
//            }
//        }
//    };
//    [seg switchToNY];
}
#pragma mark - 网络请求
-(void)reloadData {
    NSString *departType = [UserDefaultsSetting_SW shareSetting].userType;
    NSString *biaoshi = [UserDefaultsSetting_SW shareSetting].biaoshi;
    self.biaoshiid = biaoshi;
    NSString *startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString *endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
//    NSString *urlString = [NSString stringWithFormat:    _baseUrlString,userGroupId,self.shebeibianhao,startTimeStamp,endTimeStamp,self.pageNo,self.maxPageItems];
    NSString *urlString =  [NSString stringWithFormat:_baseUrlString,self.shebeibianhao,startTimeStamp,endTimeStamp,self.maxPageItems,self.pageNo,departType,biaoshi];

    
    __weak typeof(self) weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *datas = [NSMutableArray array];
        NSMutableArray *nyX = [NSMutableArray array];
        if ([result[@"success"] boolValue]) {
            if ([result[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dic in result[@"data"]) {//表格
                    weakSelf.listModel = [TP_NYSDList_Model modelWithDict:dic];
                    [arr addObject:weakSelf.listModel];
                    
                    weakSelf.chartModel = [TP_NY_ChartModel modelWithDict:dic];
                    if (weakSelf.chartModel.tmpdata) {
                        [datas addObject:weakSelf.chartModel.tmpdata];
                    }
                    [nyX addObject:weakSelf.chartModel.tmpshijian];
                }
            }

            self.sdArray = arr;

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
    return self.sdArray.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TP_NYSDList_Cell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"TP_NYSDList_Cell1"];
        if (self.wdIndex == 2) {
            [cell setLabel:@"温度"];
        }
//        if (self.wdIndex == 1) {
//            [cell setLabel:@"速度"];
//        }
        return cell;
    }else {
        TP_NYSDList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"TP_NYSDList_Cell"];
        for (int i =0; i<9; i++) {
            TP_NYSDList_Model * model = self.sdArray[indexPath.row-1];
            cell.listModel = model;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark - 搜索查询
- (IBAction)searchButtonClick:(UIButton *)sender {
    sender.enabled = NO;
    //1.
    UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(0, 64+36, Screen_w, Screen_h  -64-36);
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    backView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        backView.hidden = NO;
    });
    [self.view addSubview:backView];
    
    //2.
    Exp5View * e = [[Exp5View alloc] init];
    e.frame = CGRectMake(0, 64+35, Screen_w, 195);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {
            sender.enabled = YES;
            [backView removeFromSuperview];
            weakSelf.sdArray = nil;
            weakSelf.chaoBiaoDatas = nil;
            weakSelf.chaoX = nil;
//            [self.chartView removeFromSuperview];
            [weakSelf.ListTableView reloadData];
            
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            //重新切换titleButton ， 搜索页码应该回归第一页码
            weakSelf.pageNo = @"1";
            [weakSelf reloadData];
//            NSString *urlString = [self loadUI];
//            [weakSelf.tableCont reloadData:urlString];
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {//选择设备
            UIButton * btn = (UIButton*)obj1;
            LLQ_SB_Controller * controller = [[LLQ_SB_Controller alloc] init];
            controller.conditonDict = @{@"departType":[UserDefaultsSetting_SW shareSetting].userType,
                                        @"biaoshiid":self.biaoshiid,
                                        @"machineType":@"4",
                                        };
            [self.navigationController pushViewController:controller animated:YES];
            
            __weak __typeof(self)  weakSelf = self;
            //            controller.title = @"选择设备";
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.shebeibianhao = gprsbianhao;
            };

        }
    };
    [self.view addSubview:e];
}
@end
