//
//  DayQueryTableViewController.m
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "DayQueryTableViewController.h"
#import "DayQueryModel.h"
#import "DayQueryTableViewCell.h"
#import "DayDetailsController.h"
#import "NetworkTool.h"

@interface DayQueryTableViewController ()
@property(nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) DayQueryModel *dataModel;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *yPage;//页码

@end
@implementation DayQueryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    NSString *pageNo = @"1";
    NSString *urlString = [self loadUI:pageNo];
    [self reloadData:urlString];
}

-(void)setUI {
    self.yPage = @"1";
    self.tableView.rowHeight = 180;
    self.tableView.frame = CGRectMake(0, 95, Screen_w, Screen_h - 100);
    
    //添加刷新(初始化URL）
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        [weakSelf  reloadData:weakSelf.urlString];
    }];
    //    添加加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([weakSelf.yPage boolValue]) {
            weakSelf.yPage = FormatInt([weakSelf.yPage intValue]+1);
            NSString *urlString = [self loadUI:weakSelf.yPage];
            [weakSelf reloadData:urlString];
        }
    }];
}
-(NSString *)loadUI:(NSString *)panNo {
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:super.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:super.endTime];
    NSString *shebStr = @"";
    NSString *urlString = [NSString stringWithFormat:DayQuery,userGroupId,shebStr,startTimeStamp,endTimeStamp,panNo];
    return urlString;
}

-(void)reloadData:(NSString *)urlString {
    __weak typeof(self)  weakSelf = self;
    NSString *page = [self getParamValueFromUrl:urlString paramName:@"pageNo"];
    weakSelf.urlString = urlString;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        NSMutableArray * datas = [NSMutableArray array];
        if ([dict[@"success"] boolValue]) {
            for (NSDictionary * dic in dict[@"data"]) {
                weakSelf.dataModel = [DayQueryModel modelWithDict:dic];
                [datas addObject:weakSelf.dataModel];
            }
            }
        weakSelf.yPage = page;
        if ([weakSelf.yPage intValue] == 1) {
            weakSelf.dataArr = datas;
        }else{
            [weakSelf.dataArr addObjectsFromArray:datas];
        }
        //2.
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        //3.
        if (weakSelf.dataArr.count < ([weakSelf.yPage intValue]* 30)) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }

    }
     ];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DayQueryTableViewCell";
    UINib *nib = [UINib nibWithNibName:@"DayQueryTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    DayQueryTableViewCell *cell = (DayQueryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    DayQueryModel *model = _dataArr[indexPath.row];
    //产量存值
    [UserDefaultsSetting shareSetting].dailyid = model.dailyid;
    [UserDefaultsSetting shareSetting].dailysbbh = model.dailysbbh;
    
    cell.dayQueryModel = model;
        
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DayDetailsController *detailVc = [[DayDetailsController alloc] init];
    detailVc.model = _dataArr[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(NSString *)getParamValueFromUrl:(NSString *)url paramName:(NSString *)paramName
{
    if (![paramName hasSuffix:@"="]) {
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    NSString *str = nil;
    NSRange   start = [url rangeOfString:paramName];
    if (start.location != NSNotFound) {
        unichar  c = '?';
        if (start.location != 0) {
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#') {
            NSRange     end = [[url substringFromIndex:start.location + start.length] rangeOfString:@"&"];
            NSUInteger  offset = start.location + start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return str;
}

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
