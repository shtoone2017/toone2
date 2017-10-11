//
//  GCB_WPLController.m
//  toone
//
//  Created by 上海同望 on 2017/10/9.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_WPLController.h"
#import "GCB_WSC_Cell.h"
#import "GCB_JZL_Model.h"
#import "YBPopupMenu.h"
#import "GCB_JZL_DetailController.h"
#import "GCB_JZL_DetailController.h"
#import "NodeViewController.h"
#import "HNT_BHZ_SB_Controller.h"
#import "HNT_BHZ_SB_Controller.h"

#define ITLES @[@"新增", @"编辑"]
#define TITLES @[@"新增", @"编辑", @"删除",@"提交"]

@interface GCB_WPLController ()<UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
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
@implementation GCB_WPLController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_zt isEqualToString:@"0"]) {
        self.title = @"未配料";
    }else if ([_zt isEqualToString:@"1"]) {
        self.title = @"已配料";
    }else if ([_zt isEqualToString:@"-1"]) {
        self.title = @"未提交";
    }

    self.pageNo = @"1";
    self.maxPageItems = @"5";
    self.ztstate = @"0";
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
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_WSC_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_WSC_Cell"];
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
    GCB_WSC_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_WSC_Cell" forIndexPath:indexPath];
    GCB_JZL_Model * model = self.datas[indexPath.row];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GCB_JZL_Model * model;
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    model = self.datas[indexPath.row];
    _dearid = model.rwdId;
    _zhuant = model.zhuangtai;//区分未提交
    _rwdid = model.renwuno;
    if ([UserDefaultsSetting shareSetting].wzgcbReal) {
        CGPoint a = CGPointMake(Screen_w*0.5, rect.origin.y+120);
        if ([_zhuant isEqualToString:@"-1"]) {//未提交
            [YBPopupMenu showAtPoint:a titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
                popupMenu.dismissOnSelected = YES;
                popupMenu.isShowShadow = YES;
                popupMenu.delegate = self;
                popupMenu.offset = 10;
                popupMenu.type = YBPopupMenuTypeDark;
                popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            }];
        }else {
            [YBPopupMenu showAtPoint:a titles:ITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
                popupMenu.dismissOnSelected = YES;
                popupMenu.isShowShadow = YES;
                popupMenu.delegate = self;
                popupMenu.offset = 10;
                popupMenu.type = YBPopupMenuTypeDark;
                popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            }];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    if ([TITLES[index] isEqualToString:@"新增"]) {
        GCB_JZL_DetailController *vc = [[GCB_JZL_DetailController alloc] init];
        vc.detailId = _dearid;
        vc.jzlName = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([TITLES[index] isEqualToString:@"编辑"]) {
        GCB_JZL_DetailController *vc = [[GCB_JZL_DetailController alloc] init];
        vc.detailId = _dearid;
        vc.jzlName = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([TITLES[index] isEqualToString:@"删除"]) {
        if ([_zhuant isEqualToString:@"-1"]) {
            [self loadDeleting];
        }else {
            [SVProgressHUD showErrorWithStatus:@"任务单已提交，无法删除"];
        }
    }
    if ([TITLES[index] isEqualToString:@"提交"]) {
        if ([_zhuant isEqualToString:@"-1"]) {
            [self loadSubmit];
        }else {
            [SVProgressHUD showErrorWithStatus:@"任务单已提交，无法再次提交"];
        }
    }
}
#pragma mark - 未提交
-(void)loadSubmit {//提交
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString * urlString = [NSString stringWithFormat:AppJZL_Tj,_dearid,[UserDefaultsSetting shareSetting].userFullName];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"任务单提交成功";
            [hud hideAnimated:YES afterDelay:2.0];
            [self loadData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [UserDefaultsSetting shareSetting].GCBSeed = [NSString stringWithFormat:@"%d",arc4random()%1000];
                [self.navigationController popViewControllerAnimated:YES];
            });

        }if(![json[@"success"] boolValue]) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"任务单提交失败";
            [hud hideAnimated:YES afterDelay:2.0];
        }
    } failure:^(NSError *error) {
        [Tools tip:@"服务器异常"];
    }];
}
-(void)loadDeleting {//删除
    NSString * urlString = [NSString stringWithFormat:AppJZL_Dele,_dearid];
    [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            [self loadData];
            [SVProgressHUD showSuccessWithStatus:@"任务单删除成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [UserDefaultsSetting shareSetting].GCBSeed = [NSString stringWithFormat:@"%d",arc4random()%1000];
                [self.navigationController popViewControllerAnimated:YES];
            });
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
