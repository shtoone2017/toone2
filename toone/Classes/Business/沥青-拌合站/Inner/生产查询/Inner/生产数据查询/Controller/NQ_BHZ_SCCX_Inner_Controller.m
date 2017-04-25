//
//  ProduQueryTableViewController.m
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NQ_BHZ_SCCX_Inner_Controller.h"
#import "ProduQueryModel.h"
#import "NQ_BHZ_SCCX_Inner_Cell.h"
#import "NQ_BHZ_SCCX_Innel_Controller.h"
#import "NQ_BHZ_SCCX_Controller.h"
#import "NetworkTool.h"

@interface NQ_BHZ_SCCX_Inner_Controller ()
@property(nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NQ_BHZ_SCCX_Controller *Vc;
@property (nonatomic, strong) ProduQueryModel *dataModel;

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *yPage;//页码
@end
@implementation NQ_BHZ_SCCX_Inner_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

    NSString *pageNo = @"1";
    NSString *urlString = [self loadUI:pageNo];
    [self reloadData:urlString];
}

-(void)setUI {
    self.yPage = @"1";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = 85;
    self.tableView.frame = CGRectMake(0, 100, Screen_w, Screen_h - 105);
    
    //添加刷新(初始化URL）
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        NSString *pageNo = @"1";
        NSString *urlString = [self loadUI:pageNo];
        [weakSelf reloadData:urlString];
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
        NSString *urlString = [NSString stringWithFormat:ProduQuery,userGroupId,shebStr,startTimeStamp,endTimeStamp,panNo];
    return urlString;
}
/*
 
 */
-(void)reloadData:(NSString *)urlString {
    __weak typeof(self)  weakSelf = self;
    NSString *page = [self getParamValueFromUrl:urlString paramName:@"pageNo"];
    weakSelf.urlString = urlString;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        
        NSDictionary *dict = (NSDictionary *)result;
        NSMutableArray * datas = [NSMutableArray array];
        if ([dict[@"success"] boolValue]) {
            for (NSDictionary * dic in dict[@"data"]) {
                weakSelf.dataModel = [ProduQueryModel modelWithDict:dic];
                weakSelf.dataModel.ID = dic[@"id"];
                [datas addObject:weakSelf.dataModel];
            }
        }
        
        weakSelf.yPage = page;
        if ([weakSelf.yPage intValue] == 1) {
            weakSelf.datas = datas;
        }else{
            [weakSelf.datas addObjectsFromArray:datas];
        }
        //2.
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        //3.
        if (weakSelf.datas.count < ([weakSelf.yPage intValue]* 15)) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
     ];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NQ_BHZ_SCCX_Inner_Cell";
    UINib *nib = [UINib nibWithNibName:@"NQ_BHZ_SCCX_Inner_Cell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
     NQ_BHZ_SCCX_Inner_Cell *cell = (NQ_BHZ_SCCX_Inner_Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ProduQueryModel *model = self.datas[indexPath.row];
    cell.ProduQueryModel = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[NQ_BHZ_SCCX_Innel_Controller alloc] init] animated:YES];
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
-(NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
