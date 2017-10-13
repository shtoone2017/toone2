//
//  GCB_RWD_DetailController.m
//  toone
//
//  Created by 上海同望 on 2017/8/20.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_RWD_DetailController.h"
#import "GCB_RWD_Detail_ZYCell.h"
#import "GCB_RWD_Detail_XGCell.h"
#import "GCB_RWD_Detail_ZXCell.h"
#import "GCB_RWD_Detail_DataCell.h"
#import "GCB_RWD_DetailModel.h"
#import "GCB_RWD_HeadModel.h"

@interface GCB_RWD_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic,strong) NSMutableArray * zyData;
@property (nonatomic,strong) NSMutableArray * xgData;
@property (nonatomic,strong) NSMutableArray * zxData;
@property (nonatomic,strong) GCB_RWD_HeadModel * headModel;
@end
@implementation GCB_RWD_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务单明细";
    [self loadUI];
    [self loadData];
}

-(void)loadUI{
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
//    self.tb.separatorColor = [UIColor clearColor];
    
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_RWD_Detail_ZYCell" bundle:nil] forCellReuseIdentifier:@"GCB_RWD_Detail_ZYCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_RWD_Detail_XGCell" bundle:nil] forCellReuseIdentifier:@"GCB_RWD_Detail_XGCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_RWD_Detail_ZXCell" bundle:nil] forCellReuseIdentifier:@"GCB_RWD_Detail_ZXCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_RWD_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"GCB_RWD_Detail_DataCell"];
}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    NSString * urlString = [NSString stringWithFormat:AppJZL_Detail,_detailId,_biaoshi];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        
        if ([json[@"success"] boolValue]) {
            NSMutableArray * zxDatas = [NSMutableArray array];
            NSMutableArray * xgDatas = [NSMutableArray array];
            NSMutableArray * zyDatas = [NSMutableArray array];
            
            if ([json[@"ZYJLData"] isKindOfClass:[NSArray class]]) {//转移
                for (NSDictionary * dict in json[@"ZYJLData"]) {
                    GCB_RWD_DetailModel * zyModel = [GCB_RWD_DetailModel modelWithDict:dict];
                    [zyDatas addObject:zyModel];
                }
            }
            if ([json[@"XGJLData"] isKindOfClass:[NSArray class]]) {//修改
                for (NSDictionary * dict in json[@"XGJLData"]) {
                    GCB_RWD_DetailModel * xgModel = [GCB_RWD_DetailModel modelWithDict:dict];
                    xgModel.xgtype = dict[@"type"];
                    [xgDatas addObject:xgModel];
                }
            }
            if ([json[@"ZXQKData"] isKindOfClass:[NSDictionary class]]) {//执行
                GCB_RWD_DetailModel * zxModel = [GCB_RWD_DetailModel modelWithDict:json[@"ZXQKData"]];
                [zxDatas addObject:zxModel];
            }
            if ([json[@"JCXXData"] isKindOfClass:[NSDictionary class]]) {//基础信息
                GCB_RWD_HeadModel * head = [GCB_RWD_HeadModel modelWithDict:json[@"JCXXData"]];
                weakSelf.headModel = head;
            }
            
            weakSelf.zxData = zxDatas;
            weakSelf.xgData = xgDatas;
            weakSelf.zyData = zyDatas;
            [weakSelf.tb reloadData];
            [Tools removeActivity];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.zxData.count+1;
    }
    if (section == 3) {//转移
        if (self.xgData.count == 0) {
            return 1;
        }else {
            return self.xgData.count+1;
        }
    }
    if (section == 2) {
//        if (self.zyData.count == 0) {
//            return 1;
//        }else {
            return self.zyData.count;
//        }
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基础信息";
        case 1:return @"执行情况";
        case 3:return @"修改记录";
        case 2:return @"转移记录";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 195.0f;
    }
    if (indexPath.section == 1) {
        return 20;
    }
    if (indexPath.section == 3) {
        return 20;
    }
    if (indexPath.section == 2) {
        return 140.0f;
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GCB_RWD_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_RWD_Detail_DataCell"];
        cell.model = self.headModel;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        GCB_RWD_Detail_ZXCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_RWD_Detail_ZXCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row > 0) {
            GCB_RWD_DetailModel * data = indexPath.row ==0 ? nil :self.zxData[indexPath.row-1];
            cell.color = [UIColor blackColor];
            cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
            cell.model= data;
        }
        return cell;
    }
    if (indexPath.section == 3) {
        GCB_RWD_Detail_XGCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_RWD_Detail_XGCell"];
        if (indexPath.row > 0) {
            GCB_RWD_DetailModel * data = indexPath.row ==0 ? nil :self.xgData[indexPath.row-1];
            cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
            cell.color = [UIColor blackColor];
            cell.model= data;
        }
        return cell;
    }
    if (indexPath.section == 2) {//修改
        GCB_RWD_Detail_ZYCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_RWD_Detail_ZYCell"];
//        for (NSInteger i=0; i<=_zyData.count; i++) {
//            GCB_RWD_DetailModel * data = indexPath.row ==0 ? nil :self.zyData[indexPath.row];
            GCB_RWD_DetailModel *data = _zyData[indexPath.row];
            cell.model= data;
//        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return nil;
}



@end
