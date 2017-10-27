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
@property (nonatomic, copy) NSString *status;//状态

@end
@implementation Car_localController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本地查询";
    _status = @"";
    [self loadUI];
    [self addPanGestureRecognizer];
    [self loadData];
}

-(void)loadUI {
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


-(void)searchButtonClick:(UIButton*)sender{
    [super pan];
}

@end
