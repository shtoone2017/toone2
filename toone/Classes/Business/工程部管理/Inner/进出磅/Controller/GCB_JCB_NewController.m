//
//  GCB_JCB_NewController.m
//  
//
//  Created by 上海同望 on 2017/10/9.
//
//

#import "GCB_JCB_NewController.h"
#import "GCB_JC_Model.h"
#import "GCB_JCB_Cell.h"
#import "GCB_JCB_DetailController.h"
#import "HNT_BHZ_SB_Controller.h"
#import "NodeViewController.h"
#import "HNT_BHZ_SB_Controller.h"

@interface GCB_JCB_NewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,copy) NSString *pageNo                                ;//当前页数
@property (nonatomic,copy) NSString *maxPageItems                          ;//一页最多显示条数
@property (nonatomic,copy) NSString *departId                         ;
@property (nonatomic,copy)NSString *cailiaomingcheng;//材料名称id
@property (nonatomic,copy)NSString *tongjitype;//统计类型（0,1,2）季度、月、周
@property (nonatomic,copy)NSString *gprsbianhao;//过磅设备
@property (nonatomic,copy)NSString *states;//出厂类别(全部不写 废料0 调拨1)

@end
@implementation GCB_JCB_NewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_zt isEqualToString:@"1"]) {
        self.title = @"原材料进场过磅台帐";
    }else if ([_zt isEqualToString:@"2"]) {
        self.title = @"原材料出场过磅台帐";
    }
    
    self.pageNo = @"1";
    self.maxPageItems = @"5";
    self.cailiaomingcheng = @"";
    self.departId = @"";
    self.tongjitype = @"0";
    self.gprsbianhao = @"";
    self.states = @"";
    
    [self loadUI];
    [self loadData];
}
-(void)loadUI {
    UIButton * btn = [[UIButton alloc] init];
    btn.backgroundColor = BLUECOLOR;
    [btn setTitle:@"" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.view.backgroundColor = [UIColor snowColor];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_w, Screen_h) style:UITableViewStylePlain];
    _tb.delegate =self;
    _tb.dataSource = self;
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tb];
    
    UIButton * rightBut = [UIButton img_20WithName:@"black_SX"];
    [rightBut addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    
    __weak __typeof(self) weakSelf = self;
    self.tb.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];
    weakSelf.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        [weakSelf loadData];
    }];
    _tb.rowHeight = 180;
    [_tb registerNib:[UINib nibWithNibName:@"GCB_JCB_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_JCB_Cell"];
}
#pragma mark - 网络请求
-(void)loadData {
    if ([_zt isEqualToString:@"1"]) {//进场
        NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
        NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
        NSString * urlString = [NSString stringWithFormat:AppJCB,_departId,_cailiaomingcheng,_gprsbianhao,_tongjitype,startTimeStamp,endTimeStamp,self.pageNo,self.maxPageItems];
        
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        GCB_JC_Model * model = [GCB_JC_Model modelWithDict:dict];
                        
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
    }else if ([_zt isEqualToString:@"2"]) {//出场
        NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
        NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
        __weak typeof(self)  weakSelf = self;
        NSString * urlString = [NSString stringWithFormat:AppCCB,_departId,_cailiaomingcheng,_gprsbianhao,_tongjitype,startTimeStamp,endTimeStamp,_states,self.pageNo,self.maxPageItems];
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        GCB_JC_Model * model = [GCB_JC_Model modelWithDict:dict];
                        model.ccid = dict[@"id"];
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
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCB_JCB_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_JCB_Cell" forIndexPath:indexPath];
    GCB_JC_Model * model = self.datas[indexPath.row];
    cell.jcModel = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GCB_JC_Model *model;
    GCB_JCB_DetailController *vc = [[GCB_JCB_DetailController alloc] init];
    if ([_zt isEqualToString:@"1"]) {
        model = self.datas[indexPath.row];
        vc.type = GCBTypeJC;
    }
    if ([_zt isEqualToString:@"2"]) {
        model = self.datas[indexPath.row];
        vc.type = GCBTypeCC;
        vc.ccid = model.ccid;
        vc.guobangleibie = model.guobangleibie;
    }
    vc.cailiaoNo = model.cailiaoNo;
    vc.jinchuliaodanNo = model.jinchuliaodanNo;
    vc.gongyingshangdanweibianma = model.gongyingshangdanweibianma;
    vc.pici = model.pici;
    vc.shebeibianhao = model.shebeibianhao;
    vc.jcmax = model.jcmax;
    vc.jcmin = model.jcmin;
    vc.ccmax = model.ccmax;
    vc.ccmin = model.ccmin;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)searchButtonClick:(UIButton *)sender {
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
    Exp71View * e = [[Exp71View alloc] init];
    e.useLabel = @"组织机构";
    e.sbLabel = @"磅房设备";
    e.earthLabel = @"材料名称";
    if ([_zt isEqualToString:@"1"]) {
        e.frame = CGRectMake(0, 64, Screen_w, 270);
        [e hiddenView];
    }else if ([_zt isEqualToString:@"2"]) {
        e.frame = CGRectMake(0, 64, Screen_w, 305);
    }
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
            
            [self loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {
            UIButton * btn = (UIButton*)obj1;
            HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
            controller.type = SBListTypeBF;
            controller.title = @"选择设备";
            controller.departId = self.departId;
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.gprsbianhao = gprsbianhao;
                [self loadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (type == ExpButtonTypeUsePosition) {//组织机构
            UIButton * btn = (UIButton*)obj1;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                weakSelf.departId = identifier;
                [btn setTitle:name forState:UIControlStateNormal];
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (type == ExpButtonTypeEarthwork) {//材料
            UIButton * btn = (UIButton*)obj1;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeCL;
            vc.CLBlock = ^(NSString *name, NSString *identifier) {
                weakSelf.departId = identifier;
                [btn setTitle:name forState:UIControlStateNormal];
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (type == ExpButtonTypeTjlxBut) {//统计类型
            UIButton * btn = (UIButton*)obj1;
            HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
            controller.type = SBListTypeTon;
            //            controller.departId = self.departId;
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.tongjitype = gprsbianhao;
                [self loadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
        if ([_zt isEqualToString:@"2"]) {
            if (type == ExpButtonTypeCclxBut) {//出场类型
                UIButton * btn = (UIButton*)obj1;
                HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
                controller.type = SBListTypeStat;
                //            controller.departId = self.departId;
                controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                    [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                    weakSelf.states = gprsbianhao;
                    [self loadData];
                };
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
        
    };
    [self.view addSubview:e];
}



@end
