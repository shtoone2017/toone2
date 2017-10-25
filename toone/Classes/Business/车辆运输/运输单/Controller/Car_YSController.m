//
//  Car_YSController.m
//  toone
//
//  Created by 上海同望 on 2017/10/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_YSController.h"
#import "Car_YSD_Cell.h"
#import "Car_YSD_Model.h"
#import "HNT_BHZ_SB_Controller.h"
#import "Car_YSD_DetailController.h"

@interface Car_YSController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString *maxPageItems;//一页最多显示条数
@property (nonatomic, copy) NSString *status;//状态

@end
@implementation Car_YSController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发车单查询";
    self.pageNo = @"1";
    self.maxPageItems = @"100";
    _status = @"";
    [self addPanGestureRecognizer];
    [self loadUI];
    [self loadData];
}

-(void)loadUI {
    UIButton * btn = [UIButton img_20WithName:@"white_SX"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_w, Screen_h-50) style:UITableViewStylePlain];
    _tb.delegate =self;
    _tb.dataSource = self;
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tb];

    __weak __typeof(self) weakSelf = self;
    self.tb.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];
    self.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        [weakSelf loadData];
    }];
    self.tb.rowHeight = 140;
    [self.tb registerNib:[UINib nibWithNibName:@"Car_YSD_Cell" bundle:nil] forCellReuseIdentifier:@"Car_YSD_Cell"];
}

#pragma mark - 网络请求
-(void)loadData{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString *token = [UserDefaultsSetting_SW shareSetting].Token;
    NSString *jgdm = [UserDefaultsSetting_SW shareSetting].Jgdm;
    NSString * urlString = [NSString stringWithFormat:CarList,token,_pageNo,_maxPageItems,jgdm,_status,startTimeStamp,endTimeStamp];
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"code"] integerValue] == 1) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    Car_YSD_Model * model = [Car_YSD_Model modelWithDict:dict];
                    [datas addObject:model];
                }
            }
        }
        if ([weakSelf.pageNo intValue] == 1) {
            weakSelf.datas = datas;
        }else{
            [weakSelf.datas addObjectsFromArray:datas];
        }
        [weakSelf.tb reloadData];
        [weakSelf.tb.mj_header endRefreshing];
        [weakSelf.tb.mj_footer endRefreshing];
        if (weakSelf.datas.count < ([weakSelf.pageNo intValue]* [weakSelf.maxPageItems intValue])) {
            [weakSelf.tb.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Car_YSD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Car_YSD_Cell" forIndexPath:indexPath];
    Car_YSD_Model * model = self.datas[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Car_YSD_DetailController *vc = [[Car_YSD_DetailController alloc] init];
    Car_YSD_Model * model = self.datas[indexPath.row];
    vc.fcdbh = model.FCDBH;
    vc.bhzbh = model.BHZBH;
    vc.type = model.STATUS.integerValue;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchButtonClick:(UIButton*)sender{
    switch (sender.tag) {
        case 2:{
            sender.enabled = NO;
            //1.
            UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
            backView.frame = CGRectMake(0, 64+35, Screen_w, Screen_h - 49 -64-35);
            backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            backView.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                backView.hidden = NO;
            });
            [self.view addSubview:backView];
            
            //2.
            Exp5View * e = [[Exp5View alloc] init];
            e.stutas = @"选择状态";
            e.frame = CGRectMake(0, 64, Screen_w, 195);
            __weak __typeof(self)  weakSelf = self;
            e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
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
                    [weakSelf loadData];
                    FuncLog;
                }
                if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
                    UIButton * btn = (UIButton*)obj1;
                    [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
                }
                
                if (type == ExpButtonTypeChoiceSBButton) {
                    UIButton * btn = (UIButton*)obj1;
                    __weak typeof(self) weakSelf = self;
                    HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                    vc.type = SBListTypeStatu;
                    vc.callBlock = ^(NSString *banhezhanminchen, NSString *departid) {
                        [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                        weakSelf.status = departid;
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            [self.view addSubview:e];
            break;
        }
        case 3:{
            [super pan];
            break;
        }
        default:
            FuncLog;
            break;
    }
}


@end
