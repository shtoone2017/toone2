//
//  HNT_SCCX_DetailController.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SCCX_DetailController.h"
#import "HNT_SCCX_Detail_DataCell.h"
#import "HNT_SCCX_Detail_HeadMsgCell.h"
#import "HNT_SCCX_Detail_HeadMsg.h"
#import "HNT_SCCX_Detail_Data.h"


@interface HNT_SCCX_DetailController ()
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) HNT_SCCX_Detail_HeadMsg * headMsg;
@end

@implementation HNT_SCCX_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUi];
}
-(void)loadUi{
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HNT_SCCX_Detail_HeadMsgCell" bundle:nil] forCellReuseIdentifier:@"HNT_SCCX_Detail_HeadMsgCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HNT_SCCX_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"HNT_SCCX_Detail_DataCell"];
}
-(NSMutableArray *)datas{
    if (!_datas) {
        NSString * urlString = [NSString stringWithFormat:AppHntXiangxiDetail_1,self.bianhao];
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        HNT_SCCX_Detail_Data * data = [HNT_SCCX_Detail_Data modelWithDict:dict];
                        [datas addObject:data];
                    }
                }
                if ([json[@"headMsg"] isKindOfClass:[NSDictionary class]]) {
                    HNT_SCCX_Detail_HeadMsg * headMsg = [HNT_SCCX_Detail_HeadMsg modelWithDict:json[@"headMsg"]];
                    weakSelf.headMsg = headMsg;
                }
            }
            //
            weakSelf.datas = datas;
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {
        }];
    }
    return _datas;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 630;
    }else{
        
        return 20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HNT_SCCX_Detail_HeadMsgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_HeadMsgCell"];
        cell.headMsg = self.headMsg;
        return cell;
    }else{
        
        HNT_SCCX_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_DataCell"];
        HNT_SCCX_Detail_Data * data = self.datas[indexPath.row-1];
        cell.data = data;
        cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
        return cell;
    }
    return nil;
}



@end
