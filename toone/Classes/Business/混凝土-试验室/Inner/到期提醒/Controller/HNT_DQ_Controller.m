//
//  HNT_DQ_Controller.m
//  toone
//
//  Created by 上海同望 on 2018/1/10.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "HNT_DQ_Controller.h"
#import "HNT_DQ_DetailModel.h"
#import "HNT_DQ_DetailCell.h"

@interface HNT_DQ_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tb;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,copy) NSString *pageNo;//当前页数
@property (nonatomic,copy) NSString *maxPageItems;//一页最多显示条数
@property (nonatomic, copy) NSString *departType;
@property (nonatomic, copy) NSString *biaoshiid;
@property (nonatomic, copy) NSString *jiaozhubuwei;//浇筑部位
@property (nonatomic, copy) NSString *lingqi;
@property (nonatomic, copy) NSString *sjqd;//强度

@end
@implementation HNT_DQ_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"龄期到期";
    _departType = @"";
    _biaoshiid = @"";
    _jiaozhubuwei = @"";
    _lingqi = @"";
    _sjqd = @"";
    self.pageNo = @"1";
    self.maxPageItems = @"10";

    [self loadUI];
    [self loadData];
}

-(void)loadUI {
    UIButton * btn = [[UIButton alloc] init];
    btn.backgroundColor = BLUECOLOR;
    [btn setTitle:@"" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.view.backgroundColor = [UIColor snowColor];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_w, Screen_h-50) style:UITableViewStylePlain];
    _tb.delegate =self;
    _tb.dataSource = self;
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tb];
    
    UIButton * rightBut = [UIButton img_20WithName:@"white_SX"];
    [rightBut addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    
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
    [self.tb registerNib:[UINib nibWithNibName:@"HNT_DQ_DetailCell" bundle:nil] forCellReuseIdentifier:@"HNT_DQ_DetailCell"];
}


-(void)loadData{
    NSString *currentTime = [TimeTools timeStampWithTimeString:self.endTime];
//    NSString *currentTime = @"1516420800";
    NSString *endTime = [TimeTools timeStampWithTimeString:[TimeTools time_1_dayAgo:1]];
//    NSString *endTime = @"1516507200";
    
    _departType = [UserDefaultsSetting shareSetting].userType;
    _biaoshiid = [UserDefaultsSetting shareSetting].biaoshi;

    NSString * urlString = [NSString stringWithFormat:Hnt_Dqlist,_departType,_biaoshiid,currentTime,endTime,self.pageNo,self.maxPageItems,_lingqi,_jiaozhubuwei,_sjqd];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    HNT_DQ_DetailModel * model = [HNT_DQ_DetailModel modelWithDict:dict];;
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
    HNT_DQ_DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_DQ_DetailCell" forIndexPath:indexPath];
    HNT_DQ_DetailModel * model = self.datas[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

-(void)searchButtonClick:(UIButton *)sender {
    /*
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
    Exp51View * e = [[Exp51View alloc] init];
    e.frame = CGRectMake(0, 64, Screen_w, 285);
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
            //            weakSelf.pageNo = @"1";
            //            weakSelf.cllx = @"0";
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        if (type == ExpButtonTypeRwdText) {
            //            UITextField *text  = (UITextField*)obj1;
            //            _renwuno = text.text;
            _renwuno = obj1;
            [self loadData];
        }
        if (type == ExpButtonTypeUsePosition) {//组织
            UIButton * btn = (UIButton*)obj1;
            __weak typeof(self) weakSelf = self;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                weakSelf.departId = identifier;
                [btn setTitle:name forState:UIControlStateNormal];
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (type == ExpButtonTypeEarthwork) {//设计
            UIButton * btn = (UIButton*)obj1;
            HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
            controller.type = SBListTypeSJQD;
            //            controller.departId = self.departId;
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.sjqd = gprsbianhao;
                [self loadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
    };
    [self.view addSubview:e];
     */
}
@end
