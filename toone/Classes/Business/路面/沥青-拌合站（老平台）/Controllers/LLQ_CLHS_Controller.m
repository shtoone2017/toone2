//
//  HNT_CLHS_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_CLHS_Controller.h"
#import "LLQ_CLHS_Model.h"
#import "LLQ_CLHS_ChatCell.h"
//#import "LLQ_CLHS_Cell.h"
#import "LLQ_CLHS_Cell1.h"
#import "LQ_SB_Controller.h"
#import "BarModel.h"
#import "AAChartView.h"
#import "LLQ_CLHS_DetailController.h"
#import "LQ_Peifang_Controller.h"
#import "NodeViewController.h"

@interface LLQ_CLHS_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * datas;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * datas1;
@property (nonatomic,strong) NSMutableArray * datas2;

//***************
@property (nonatomic,copy) NSString * shebeibianhao;//设备编号
@property (nonatomic,copy) NSString * sbName;//设备
@property (nonatomic, copy) NSString *departId;
@property (nonatomic, copy) NSString *hhllx;//混合料类型
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString * maxPageItems;//一页最多显示条数
@end

@implementation LLQ_CLHS_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shebeibianhao = @"";
    _departId = self.conditonDict[@"departType"];
    _hhllx = @"";
    _pageNo = @"1";
    _maxPageItems = @"30";
    
    [self loadUi];
    [self loadData];
}
-(void)loadUi{
    self.view.backgroundColor = [UIColor snowColor];
    self.sjLabel.textColor = [UIColor blackColor];
    self.sjLabel.numberOfLines = 2;
    self.sjLabel.text = [NSString stringWithFormat:@"%@开始~%@结束",super.startTime,super.endTime];
    self.tableView.allowsSelection = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        [weakSelf loadData];
    }];
//    [self.tableView registerNib:[UINib nibWithNibName:@"LLQ_CLHS_ChatCell" bundle:nil] forCellReuseIdentifier:@"LLQ_CLHS_ChatCell"];
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:[UINib nibWithNibName:@"LLQ_CLHS_Cell1" bundle:nil] forCellReuseIdentifier:@"LLQ_CLHS_Cell1"];
//    [self.tableView registerClass:[LLQ_CLHS_Cell1 class] forCellReuseIdentifier:@"LLQ_CLHS_Cell1"];
}

#pragma mark - 网络请求
-(void)loadData{
    //添加指示器
//    [Tools showActivityToView:self.view];
    
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:lqmaterial,_departId,startTimeStamp,endTimeStamp,_shebeibianhao,_hhllx,_pageNo,_maxPageItems];

    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    LLQ_CLHS_Model * model = [LLQ_CLHS_Model modelWithDict:dict];
                    model.detaId = dict[@"id"];
                    [datas addObject:model];
                }
            }
        }
        if ([weakSelf.pageNo intValue] == 1) {
            weakSelf.datas = datas;
        }else{
            [weakSelf.datas addObjectsFromArray:datas];
        }
        //2.
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        //3.
        if (weakSelf.datas.count < ([weakSelf.pageNo intValue]* [weakSelf.maxPageItems intValue])) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
//        NSMutableArray * bars1 = [NSMutableArray array];
//        NSMutableArray * bars2 = [NSMutableArray array];
//        for (LLQ_CLHS_Model * model in datas) {
//            AASeriesElement *mode1 = [[AASeriesElement alloc] init];
//            mode1.nameSet(model.name);
//            double value1 =  [(NSString*)model.mbpeibi doubleValue];
//            NSNumber *num1 = [NSNumber numberWithDouble:value1];
//            mode1.dataSet(@[num1]);
//            [bars1 addObject:mode1];
//
//            AASeriesElement *mode = [[AASeriesElement alloc] init];
//            mode.nameSet(model.name);
//            double value =  [(NSString*)model.yongliang doubleValue];
//            NSNumber *num = [NSNumber numberWithDouble:value];
//            mode.dataSet(@[num]);
//            [bars2 addObject:mode];
//
//        }
//        weakSelf.datas1 = bars1;
//        weakSelf.datas2 = bars2;
//        //1.
//        weakSelf.datas = datas;
//        [weakSelf.tableView reloadData];
        
        //移除指示器
//        [Tools removeActivity];
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 865;
//    }
//
//    return 20;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLQ_CLHS_Cell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CLHS_Cell1" forIndexPath:indexPath];
    LLQ_CLHS_Model * model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
//    if (indexPath.row == 0) {
//        LLQ_CLHS_ChatCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CLHS_ChatCell"];
//        cell.datas1 = self.datas1;
//        cell.datas2 = self.datas2;
//        [cell.unitButton addTarget:self action:@selector(choiceUnit:) forControlEvents:UIControlEventTouchUpInside];
//        return cell;
//    }else{
//        LLQ_CLHS_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CLHS_Cell"];
//        LLQ_CLHS_Model * data = self.datas[indexPath.row-1];
//        cell.data = data;
//        //cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
//        return cell;
//    }
//    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLQ_CLHS_Model * model = self.datas[indexPath.row];

    LLQ_CLHS_DetailController *controller = [[LLQ_CLHS_DetailController alloc] init];
    controller.detaId = model.detaId;
    controller.title = @"详情";
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




-(void)choiceUnit:(UIButton*)sender{
    if (EqualToString(sender.currentTitle, @"千克/kg")) {
        [sender setTitle:@"吨/t" forState:UIControlStateNormal];
        
        
        for (LLQ_CLHS_Model * data in self.datas) {
            data.yongliang = FormatFloat3([data.yongliang floatValue] / 1000);
            data.mbpeibi = FormatFloat3([data.mbpeibi floatValue] / 1000);
            data.wucha = FormatFloat3([data.wucha floatValue] / 1000);
        }
        [self.tableView reloadData];
    }else{
        [sender setTitle:@"千克/kg" forState:UIControlStateNormal];
        
        
        for (LLQ_CLHS_Model * data in self.datas) {
            data.yongliang = FormatFloat([data.yongliang floatValue] * 1000);
            data.mbpeibi = FormatFloat([data.mbpeibi floatValue] * 1000);
            data.wucha = FormatFloat([data.wucha floatValue] * 1000);
        }
        [self.tableView reloadData];
    }
}
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
    Exp52View * e = [[Exp52View alloc] init];
    e.sbLabel = @"沥青混合料型号";
    e.earthLabel = @"选择设备";
    
    e.frame = CGRectMake(0, 64+36, Screen_w, 275);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        //        NSLog(@"ExpButtonType~~~ %d",type);
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
            //重新切换titleButton ， 搜索页码应该回归第一页码
            weakSelf.pageNo = @"1";
            weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@开始~%@结束",weakSelf.startTime,weakSelf.endTime];
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {//混合
            UIButton * btn = (UIButton*)obj1;
            LQ_Peifang_Controller *sbVc = [[LQ_Peifang_Controller alloc] init];
            sbVc.title = @"选择混合料信号";
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.callBlock = ^(NSString *name) {
                [btn setTitle:name forState:UIControlStateNormal];
                _hhllx = name;
            };
            
        }
        if (type == ExpButtonTypeUsePosition) {//组织
            UIButton * btn = (UIButton*)obj1;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                [btn setTitle:name forState:UIControlStateNormal];
                weakSelf.departId = identifier;
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (type == ExpButtonTypeEarthwork) {//设备
            UIButton * btn = (UIButton*)obj1;
            LQ_SB_Controller *controller = [[LQ_SB_Controller alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            controller.title = @"选择设备";
            controller.conditonDict = @{@"userGroupId":_departId,
                                        @"bhjtype":@"2",
                                        };
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                self.shebeibianhao = gprsbianhao;
            };
            
        }
    };
    [self.view addSubview:e];
    
}
-(void)dealloc{
    FuncLog;
}

@end
