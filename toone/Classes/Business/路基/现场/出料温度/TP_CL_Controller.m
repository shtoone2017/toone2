//
//  TP_CL_Controller.m
//  toone
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_CL_Controller.h"
#import "TP_CL_DataModel.h"
#import "TP_CL_ChartModel.h"
#import "TP_CL_Cell.h"
#import "TP_CLSB_Controller.h"
@interface TP_CL_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *firstBackView;
@property (nonatomic,strong) NSMutableArray * charts;
@property (nonatomic,strong) NSMutableArray * titles;
@property (nonatomic,strong) NSMutableArray * datas;
@property (weak, nonatomic) IBOutlet UIView *chartBackView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  SGLineDIY *line;

@property (weak, nonatomic) IBOutlet UILabel *section_Label;
@property (nonatomic,copy) NSString * pageNo;
@property (nonatomic,copy) NSString * shebeibianhao;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
- (IBAction)searchButtonClick:(UIButton *)sender;
@end

@implementation TP_CL_Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadUI];
    [self loadData];
}
-(void)loadUI{
    self.pageNo = @"1";
    self.shebeibianhao = @"";
    self.sjLabel.text = [NSString stringWithFormat:@"%@~%@",super.startTime,super.endTime];
    
    self.firstBackView.backgroundColor = [UIColor snowColor];
    self.tableView.rowHeight = 20;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"TP_CL_Cell" bundle:nil] forCellReuseIdentifier:@"TP_CL_Cell"];
    
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        weakSelf.section_Label.text = @"采集数据--第1页--";
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        weakSelf.section_Label.text = [NSString stringWithFormat:@"采集数据--第%@页--",weakSelf.pageNo];
        [weakSelf loadData];
    }];
}
-(void)loadData{
    NSString *  userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *  shebeibianhao = self.shebeibianhao;
    NSString *  startTime = [TimeTools timeStampWithTimeString:self.startTime];
    NSString *  endTime =  [TimeTools timeStampWithTimeString:self.endTime];
    NSString *  pageNo = self.pageNo;
    NSString *  maxPageItems =@"15";
    
    NSString * urlString = [NSString stringWithFormat:appXcChuliaokouwenduList,userGroupId,shebeibianhao,startTime,endTime,pageNo,maxPageItems];
    NSLog(@"urlString~~%@",urlString);
    if (self.charts) {
        self.charts = nil;
        [self.line removeFromSuperview];
        self.line = nil;
    }
    if (self.datas) {
        self.datas = nil;
        [self.tableView reloadData];
    }
    
    __weak __typeof(self) weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            //1.折线图
            NSMutableArray * charts = [NSMutableArray array];
            NSMutableArray * titles = [NSMutableArray array];
            if ([json[@"chart"] isKindOfClass:[NSArray class]]) {
  
                for (NSDictionary * dict in json[@"chart"]) {
                    NSMutableArray * points = [NSMutableArray array];
                    TP_CL_ChartModel * model = [TP_CL_ChartModel modelWithDict:dict];
                    [points addObject:model.wendu];
                    [points addObject:model.dlsylq];
                    [points addObject:model.gxlq];
                    [charts addObject:points];
                    
                    [titles addObject:model.shijian];
                }
            }
            weakSelf.charts = charts;
            weakSelf.titles = titles;
            NSArray * colors = @[[UIColor blueColor],[UIColor redColor],[UIColor greenColor]];
            if (weakSelf.titles.count > 0) {
                SGLineDIY * line = [[SGLineDIY alloc] initWithFrame:CGRectMake(0, 0, Screen_w, 160) data:self.charts title:weakSelf.titles color:colors];
                line.backgroundColor = [UIColor whiteColor];
                [weakSelf.chartBackView addSubview:line];
                weakSelf.line = line;
            }
            
            
            //2.列表
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]){
                    TP_CL_DataModel * model = [TP_CL_DataModel modelWithDict:dict];
                    [datas addObject:model];
                }
            }
            weakSelf.datas = datas;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if (weakSelf.datas.count < 15) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }else{
            [Tools tip:@"success~~0"];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TP_CL_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"TP_CL_Cell"];
    if (indexPath.row == 0) {
        cell.lb1.text = @"tmpno";
        cell.lb2.text = @"设备名称";
        cell.lb3.text = @"采集时间";
        cell.lb4.text = @"温度(℃)";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.color = [UIColor blackColor];
    }
    if (indexPath.row > 0) {
        TP_CL_DataModel * model = self.datas[indexPath.row-1];
        cell.lb1.text = model.tempRowNumber;
        cell.lb2.text = model.banhezhanminchen;
        cell.lb3.text = model.tmpshijian;
        cell.lb4.text = model.tmpdata;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.color = [UIColor lightGrayColor];
    }
    return cell;
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
    Exp5View * e = [[Exp5View alloc] init];
    e.frame = CGRectMake(0, 64+35, Screen_w, 195);
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
            weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@~%@",weakSelf.startTime,weakSelf.endTime];
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {
           __weak UIButton * btn = (UIButton*)obj1;
            
            TP_CLSB_Controller * vc = [[TP_CLSB_Controller alloc] init];
            vc.callBack = ^(NSString* shebeibianhao,NSString * name){
                weakSelf.shebeibianhao = shebeibianhao;
                [btn setTitle:name forState:UIControlStateNormal];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:e];
}

@end
