//
//  SeniorExcessiveTableConller.m
//  toone
//
//  Created by shtoone on 16/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "SeniorExcessiveTableConller.h"
#import "EXPrimaryCell.h"
#import "NetworkTool.h"
#import "disposal_C_Model.h"
#import "EXPrimaryModel.h"
#import "DCZ_CJ_Ineer_Controller.h"

@interface SeniorExcessiveTableConller ()
@property(nonatomic, strong) NSMutableArray *dataAr;
@property (nonatomic, strong) disposal_C_Model *disModel;
@property (nonatomic, strong) EXPrimaryModel *dataModel;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *yPage;//页码
@end
@implementation SeniorExcessiveTableConller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    //    初始化加载
    NSString *pageNo = @"1";
    NSString *urlString = [self loadUI:pageNo andLeixing:@""];
    [self reloadData:urlString];
}
-(void)setUI {
    self.yPage = @"1";
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.rowHeight = 165;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.y = 100;
    self.tableView.height =  Screen_h-100;
    
    //添加刷新(初始化URL）
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        [weakSelf  reloadData:weakSelf.urlString];
    }];
    //    添加加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([weakSelf.yPage boolValue]) {
            weakSelf.yPage = FormatInt([weakSelf.yPage intValue]+1);
            NSString *lexing = [self getParamValueFromUrl:self.urlString paramName:@"chuzhileixing"];
            NSString *urlString = [self loadUI:weakSelf.yPage andLeixing:lexing];
            [weakSelf reloadData:urlString];
        }
    }];
}
-(NSString *)loadUI:(NSString *)panNo andLeixing:(NSString *)leixing{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:super.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:super.endTime];
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    [UserDefaultsSetting shareSetting].dengji = [NSNumber numberWithInt:3];
    NSString *chuzhileixing;
    if (leixing) {
        chuzhileixing = leixing;
    }else {
        chuzhileixing = @"";
    }
    NSString *pageNo = panNo;
    NSString *shebStr = @"";
    NSString *urlString = [NSString stringWithFormat:LQExcessive,[UserDefaultsSetting shareSetting].dengji,chuzhileixing,pageNo,shebStr,userGroupId,startTimeStamp,endTimeStamp];
    return urlString;
}

-(void)reloadData:(NSString *)urlString {
    self.urlString = urlString;
    NSString *page = [self getParamValueFromUrl:urlString paramName:@"pageNo"];
    __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        NSMutableArray * datas = [NSMutableArray array];
        if ([dict[@"success"] boolValue]) {
            weakSelf.disModel = [disposal_C_Model modelWithDict:dict[@"Fields"]];
            
            for (NSDictionary * dic in dict[@"data"]) {
                weakSelf.dataModel = [EXPrimaryModel modelWithDict:dic];
                [datas addObject:weakSelf.dataModel];
            }
        }
        weakSelf.yPage = page;
        if ([weakSelf.yPage intValue] == 1) {
            weakSelf.dataAr = datas;
        }else {
            [weakSelf.dataAr addObjectsFromArray:datas];
        }
        [self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (weakSelf.dataAr.count < [weakSelf.yPage intValue] *10) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
     ];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"EXPrimaryCell";
    UINib *nib = [UINib nibWithNibName:@"EXPrimaryCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    EXPrimaryCell *cell = (EXPrimaryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.EXPModel = self.dataAr[indexPath.row];
    cell.disModel = self.disModel;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DCZ_CJ_Ineer_Controller *dczVc = [[DCZ_CJ_Ineer_Controller alloc] init];
    dczVc.ChaoBiaoModel = self.dataAr[indexPath.row];
    [self.navigationController pushViewController:dczVc animated:YES];
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
-(NSMutableArray *)dataAr {
    if (!_dataAr) {
        _dataAr = [NSMutableArray array];
    }
    return _dataAr;
}

@end
