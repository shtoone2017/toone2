//
//  GCB_WC_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/10/9.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_WC_Controller.h"
#import "GCB_YSC_Cell.h"
#import "GCB_JZL_Model.h"
#import "GCB_JZL_DetailController.h"
#import "GCB_JZL_DetailController.h"
#import "NodeViewController.h"
#import "HNT_BHZ_SB_Controller.h"
#import "HNT_BHZ_SB_Controller.h"

@interface GCB_WC_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString *maxPageItems;//一页最多显示条数
@property (nonatomic,copy) NSString *departId;
@property (nonatomic,copy)NSString *sjqd;//设计强度
@property (nonatomic,copy)NSString *renwuno;//任务单号
@property (nonatomic,copy)NSString *ztstate;//未生产：0 生产中及已完工 : 1

@property (nonatomic,copy)NSString *rwdid;//当前cell任务单编号
@property (nonatomic,copy)NSString *dearid;//编辑跳转ID
@property (nonatomic,copy)NSString *zhuant;//当前cell状态

@end
@implementation GCB_WC_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_zt isEqualToString:@"2"]) {
        self.title = @"生产中";
    }else if ([_zt isEqualToString:@"3"]) {
        self.title = @"已完成";
    }
    
    self.pageNo = @"1";
    self.maxPageItems = @"5";
    self.ztstate = @"1";
    self.sjqd = @"";
    self.departId = @"";
    self.renwuno = @"";
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
    self.tb.rowHeight = 240;
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_YSC_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_YSC_Cell"];
}

#pragma mark - 网络请求
-(void)loadData{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:AppJZL,_departId,_ztstate,startTimeStamp,endTimeStamp,_sjqd,_renwuno,self.pageNo,self.maxPageItems,_zt];
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_JZL_Model * model = [GCB_JZL_Model modelWithDict:dict];;
                    model.rwdId = dict[@"id"];
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
    GCB_YSC_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_YSC_Cell" forIndexPath:indexPath];
    GCB_JZL_Model * model = self.datas[indexPath.row];
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor oldLaceColor];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GCB_JZL_Model * model;
    model = self.datas[indexPath.row];
    _dearid = model.rwdId;
    if ([UserDefaultsSetting shareSetting].wzgcbReal) {
        if ([model.zhuangtai isEqualToString:@"2"]) {//生产中
            [self rwdAlert];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 生产中
-(void)rwdAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AlertViewTest"
                                                    message:@"message"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    alert.title = @"提示";
    alert.message = @"是否立即结束任务单";
    //显示AlertView
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self scDeleting];
    }
}
-(void)scDeleting {
    NSString * urlString = [NSString stringWithFormat:AppJSRWD,_dearid,[UserDefaultsSetting shareSetting].userFullName];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            [SVProgressHUD showSuccessWithStatus:@"任务单结束成功"];
            [self loadData];
        }if(![json[@"success"] boolValue]) {
            [SVProgressHUD showErrorWithStatus:@"任务单结束失败"];
        }
    } failure:^(NSError *error) {
        [Tools tip:@"服务器异常"];
    }];
}

-(void)searchButtonClick:(UIButton *)sender {
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
}
@end
