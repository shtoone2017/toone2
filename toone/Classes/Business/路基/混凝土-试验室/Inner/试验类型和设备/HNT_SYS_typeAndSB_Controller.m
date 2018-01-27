//
//  HNT_SYS_typeAndSB_Controller.m
//  toone
//
//  Created by 十国 on 16/12/2.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SYS_typeAndSB_Controller.h"
#import "SYS_testTypeModel.h"
#import "SYS_SB_Model.h"
@interface HNT_SYS_typeAndSB_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * datas;
@end

@implementation HNT_SYS_typeAndSB_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 40;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HNT_SYS_typeAndSB_Controller"];
}
/*
 HNT_SYS_YLJ_SY,
 HNT_SYS_YLJ_SB,
 HNT_SYS_WNJ_SY,
 HNT_SYS_WNJ_SB
 */
 /*
 data: {
 yljtp: [
 {
 id: 0,
 testType: "1",
 testName: "混凝土试件抗压强度试验",
 testId: "100014"
 }
 ],
 wnjtp: [
 {
 id: 0,
 testType: "2",
 testName: "钢筋试验",
 testId: "100047"
 }
 ],
 yljsb: [
 {
 departid: "",
 banhezhanminchen: "三公三分部1号压力机",
 gprsbianhao: "TWSYS00022-000023"
 },
 {
 departid: "",
 banhezhanminchen: "三公一分部1号压力机",
 gprsbianhao: "TWSYS00020-000020"
 },
 {
 departid: "",
 banhezhanminchen: "三公二分部1号压力机",
 gprsbianhao: "TWSYS00019-000019"
 },
 {
 departid: "",
 banhezhanminchen: "三公三分部2号压力机",
 gprsbianhao: "TWSYS00021-000021"
 }
 ],
 wnjsb: [
 {
 departid: "",
 banhezhanminchen: "三公三分部2号压力机",
 gprsbianhao: "TWSYS00021-000021"
 }
 ]
 },
 success: true
 }
 */
#pragma  mark - 试验室-试验类型和设备
-(NSMutableArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
        NSString * urlString = [NSString stringWithFormat:getSyTpAndMc_1,userGroupId];
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            if ([json isKindOfClass:[NSDictionary class]]) {
                if ([json[@"success"] boolValue]) {
                    if (self.typeAndSB == HNT_SYS_YLJ_SY) {
                        NSMutableArray * datas = [NSMutableArray array];
                        for (NSDictionary * dict in json[@"data"][@"yljtp"]) {
                            SYS_testTypeModel * model = [SYS_testTypeModel modelWithDict:dict];
                            [datas addObject:model];
                        }
                        self.datas = datas;
                    }
                    if (self.typeAndSB == HNT_SYS_WNJ_SY ) {
                        NSMutableArray * datas = [NSMutableArray array];
                        for (NSDictionary * dict in json[@"data"][@"wnjtp"]) {
                            SYS_testTypeModel * model = [SYS_testTypeModel modelWithDict:dict];
                            [datas addObject:model];
                        }
                        self.datas = datas;
                    }
                    if (self.typeAndSB == HNT_SYS_YLJ_SB) {
                        NSMutableArray * datas = [NSMutableArray array];
                        for (NSDictionary * dict in json[@"data"][@"yljsb"]) {
                            SYS_SB_Model * model = [SYS_SB_Model modelWithDict:dict];
                            [datas addObject:model];
                        }
                        self.datas = datas;
                    }
                    if (self.typeAndSB == HNT_SYS_WNJ_SB ) {
                        NSMutableArray * datas = [NSMutableArray array];
                        for (NSDictionary * dict in json[@"data"][@"wnjsb"]) {
                            SYS_SB_Model * model = [SYS_SB_Model modelWithDict:dict];
                            [datas addObject:model];
                        }
                        self.datas = datas;
                    }
                }
                [self.tableView reloadData];
                [Tools removeActivity];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    return _datas;
}
#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SYS_typeAndSB_Controller" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    switch (self.typeAndSB) {
        case HNT_SYS_WNJ_SY:
        case HNT_SYS_YLJ_SY:{
            SYS_testTypeModel * model = self.datas[indexPath.row];
            cell.textLabel.text = model.testName;
            break;
        }
        case HNT_SYS_WNJ_SB:
        case HNT_SYS_YLJ_SB:{
            SYS_SB_Model * model = self.datas[indexPath.row];
            cell.textLabel.text = model.banhezhanminchen;
            break;
        }
        default:
            break;
    }
   
 
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.typeAndSB) {
        case HNT_SYS_WNJ_SY:
        case HNT_SYS_YLJ_SY:{
            SYS_testTypeModel * model = self.datas[indexPath.row];
            if (_typeSBBlock) {
                _typeSBBlock(model.testName,model.testId);
            }
            break;
        }
        case HNT_SYS_WNJ_SB:
        case HNT_SYS_YLJ_SB:{
            SYS_SB_Model * model = self.datas[indexPath.row];
            if (_typeSBBlock) {
                _typeSBBlock(model.banhezhanminchen,model.gprsbianhao);
            }
            break;
        }
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
