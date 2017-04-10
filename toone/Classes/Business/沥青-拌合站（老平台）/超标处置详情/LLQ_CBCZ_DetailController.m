//
//  HNT_CBCZ_DetailController.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_CBCZ_DetailController.h"
#import "LLQ_CBCZ_Detail_lqHead.h"
#import "LLQ_CDCZ_Detail_lqData.h"
#import "LLQ_CBCZ_Detail_lqjg.h"

#import "LLQ_CBCZ_Detail_HeadCell.h"
#import "LLQ_CBCZ_Detail_DataCell.h"
#import "LLQ_CBCZ_Detail_ChuLi_Cell.h"
#import "LLQ_CBCZ_Detail_ShenPi_Cell.h"

#import "LLQ_CBCZ_Detail_ChuLi_Controller.h"
#import "LLQ_CBCZ_Detail_ShenPi_Controller.h"
@interface LLQ_CBCZ_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * datas;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,strong) LLQ_CBCZ_Detail_lqHead * headModel;
@property (nonatomic,strong) LLQ_CBCZ_Detail_lqjg   * swjgModel;
@end

@implementation LLQ_CBCZ_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUi];
    [self loadData];
}

-(void)dealloc{
    FuncLog;
}
-(void)loadUi{
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb.separatorColor = [UIColor clearColor];
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_CBCZ_Detail_HeadCell" bundle:nil] forCellReuseIdentifier:@"LLQ_CBCZ_Detail_HeadCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_CBCZ_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"LLQ_CBCZ_Detail_DataCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_CBCZ_Detail_ChuLi_Cell" bundle:nil] forCellReuseIdentifier:@"LLQ_CBCZ_Detail_ChuLi_Cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_CBCZ_Detail_ShenPi_Cell" bundle:nil] forCellReuseIdentifier:@"LLQ_CBCZ_Detail_ShenPi_Cell"];
}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
    NSString * urlString = lqchaoBiaoXQ;
    NSDictionary * dict = @{@"bianhao":self.bianhao,
                            @"shebeibianhao":self.shebeibianhao
                            };
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:dict success:^(id json) {
        
        if ([json[@"success"] boolValue]) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"lqData"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"lqData"]) {
                    LLQ_CDCZ_Detail_lqData * data = [LLQ_CDCZ_Detail_lqData modelWithDict:dict];
                    [datas addObject:data];
                }
            }
            if ([json[@"lqHead"] isKindOfClass:[NSDictionary class]]) {
                LLQ_CBCZ_Detail_lqHead * headModel = [LLQ_CBCZ_Detail_lqHead modelWithDict:json[@"lqHead"]];
                weakSelf.headModel = headModel;
            }
            if ([json[@"lqjg"] isKindOfClass:[NSDictionary class]]) {
                LLQ_CBCZ_Detail_lqjg * swjgModel = [LLQ_CBCZ_Detail_lqjg modelWithDict:json[@"lqjg"]];
                weakSelf.swjgModel = swjgModel;
            }
            
            weakSelf.datas = datas;
            [weakSelf.tb reloadData];
            [Tools removeActivity];
        }
        //

        
        //#pragma mark - 因布局设计有卡顿现象，优化方法如下
        //            weakSelf.tb.contentOffset = CGPointMake(0, 220);
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        //                weakSelf.tb.contentOffset = CGPointMake(0, 0);
        //            });
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        
        //            });
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.datas.count+1;
    }
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"采集数据";
        case 2:return @"处置信息";
        case 3:return @"审核信息";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140.0f;
    }
    if (indexPath.section == 1) {
        return 20;
    }
    if (indexPath.section == 2) {
        if (EqualToString(self.chuli, @"1")) {
            return 405;
        }else{
            return 40;
        }
    }
    if (indexPath.section == 3) {
        if (EqualToString(self.shenpi, @"1")) {
            return 105;
        }else{
            return 40;
        }
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LLQ_CBCZ_Detail_HeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Detail_HeadCell"];
        cell.model = self.headModel;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        LLQ_CBCZ_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Detail_DataCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row > 0) {
            LLQ_CDCZ_Detail_lqData * data = indexPath.row ==0 ? nil :self.datas[indexPath.row-1];
            //cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
            cell.color = [UIColor blackColor];
            cell.model= data;
        }
        return cell;
    }
    if (indexPath.section == 2) {
        if (EqualToString(self.chuli, @"1")) {
            LLQ_CBCZ_Detail_ChuLi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Detail_ChuLi_Cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.model = self.swjgModel;
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            if (EqualToString([UserDefaultsSetting_SW shareSetting].chuzhi, @"1")) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(0, 0, Screen_w, 40);
                [btn setTitle:@"点击这里开始处置..." forState:UIControlStateNormal];
                [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [cell.contentView addSubview:btn];
                [btn addTarget:self action:@selector(goto_chuzhi) forControlEvents:UIControlEventTouchUpInside];
            }else{
                UILabel * label = [[UILabel alloc] init];
                label.frame = CGRectMake(0, 0, Screen_w, 40);
                label.text = @"您没有处置权限";
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:12.0f];
                label.textColor = [UIColor blueColor];
                [cell.contentView addSubview:label];
            }
            return cell;
        }
    }
    if (indexPath.section == 3) {
        if (EqualToString(self.shenpi, @"1")) {
            LLQ_CBCZ_Detail_ShenPi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Detail_ShenPi_Cell"];
            cell.model = self.swjgModel;
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            if (EqualToString([UserDefaultsSetting_SW shareSetting].shenehe, @"1")) {
                if (!EqualToString(self.chuli, @"1")) {
                    UILabel * label = [[UILabel alloc] init];
                    label.frame = CGRectMake(0, 0, Screen_w, 40);
                    label.text = @"请先处置后再审批...";
                    label.textAlignment = NSTextAlignmentCenter;
                    label.font = [UIFont systemFontOfSize:12.0f];
                    label.textColor = [UIColor blueColor];
                    [cell.contentView addSubview:label];
                }else{
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                    btn.frame = CGRectMake(0, 0, Screen_w, 40);
                    [btn setTitle:@"点击这里开始审核..." forState:UIControlStateNormal];
                    [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                    [cell.contentView addSubview:btn];
                    [btn addTarget:self action:@selector(goto_shenpi) forControlEvents:UIControlEventTouchUpInside];
                }

            }else{
                UILabel * label = [[UILabel alloc] init];
                label.frame = CGRectMake(0, 0, Screen_w, 40);
                label.text = @"您没有审批权限";
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:12.0f];
                label.textColor = [UIColor blueColor];
                [cell.contentView addSubview:label];
            }
            return cell;
        }
    }
    
    return nil;
}
-(void)goto_chuzhi{
    LLQ_CBCZ_Detail_ChuLi_Controller * vc = [[LLQ_CBCZ_Detail_ChuLi_Controller alloc] init];
    vc.jieguobianhao = self.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goto_shenpi{
    LLQ_CBCZ_Detail_ShenPi_Controller * vc = [[LLQ_CBCZ_Detail_ShenPi_Controller alloc] init];
    vc.jieguobianhao = self.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
