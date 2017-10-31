 //
//  Car_localController.m
//  toone
//
//  Created by 上海同望 on 2017/10/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_localController.h"
#import "HNT_BHZ_SB_Controller.h"
#import "Car_YSD_Cell.h"
#import "Car_localDetailController.h"

@interface Car_localController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tb;
@property (nonatomic,strong) NSArray *datas;
//@property (nonatomic, copy) NSString *status;//状态

@end
@implementation Car_localController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本地查询";
//    _status = @"";
    [self loadUI];
    [self addPanGestureRecognizer];
    [self loadData];
}

-(void)loadUI {
//    UIButton * btn = [UIButton img_20WithName:@"white_SX"];
//    btn.tag  = 2;
//    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
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
        [weakSelf loadData];
    }];
    self.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tb.rowHeight = 140;
    [self.tb registerNib:[UINib nibWithNibName:@"Car_YSD_Cell" bundle:nil] forCellReuseIdentifier:@"Car_YSD_Cell"];

}

-(void)loadData{
    NSArray *arr = [[Singleton shareSingleton] queryData];
    self.datas = arr;
    [self.tb reloadData];
    [self.tb.mj_header endRefreshing];
    [self.tb.mj_footer endRefreshing];
    [self.tb.mj_footer endRefreshingWithNoMoreData];
}

//-(void)loadQuerData:(NSString *)str {
//    NSArray *arr = [[Singleton shareSingleton] queryDataWithKeyStr:@"outsideStatus" valueStr:str];
//    self.datas = arr;
//    [self.tb reloadData];
//    [self.tb.mj_header endRefreshing];
//    [self.tb.mj_footer endRefreshing];
//    [self.tb.mj_footer endRefreshingWithNoMoreData];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Car_YSD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Car_YSD_Cell" forIndexPath:indexPath];
    Car_ScanModel *model = self.datas[indexPath.row];
    cell.localModel = model;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Car_localDetailController *vc = [[Car_localDetailController alloc] init];
    vc.Headmodel = self.datas[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Car_ScanModel *model = self.datas[indexPath.row];
    [[Singleton shareSingleton] deleteData:model];
    NSArray *arr = [[Singleton shareSingleton] queryData];
    self.datas = arr;
    [self.tb reloadData];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
            [e loadHidden];
            e.frame = CGRectMake(0, 64, Screen_w, 120);
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
//                    [weakSelf loadData];
                    FuncLog;
                }
                if (type == ExpButtonTypeChoiceSBButton) {
                    UIButton * btn = (UIButton*)obj1;
//                    __weak typeof(self) weakSelf = self;
                    HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                    vc.type = SBListTypeLocal;
                    vc.callBlock = ^(NSString *banhezhanminchen, NSString *departid) {
                        [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
//                        [weakSelf loadQuerData:banhezhanminchen];
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

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [[UserDefaultsSetting_SW shareSetting] addObserver:self forKeyPath:@"carLoad" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self loadData];
}
-(void)dealloc{
    [[UserDefaultsSetting_SW shareSetting] removeObserver:self forKeyPath:@"carLoad"];
    FuncLog;
}

@end
