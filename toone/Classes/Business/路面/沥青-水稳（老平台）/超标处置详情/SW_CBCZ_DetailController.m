//
//  HNT_CBCZ_DetailController.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "SW_CBCZ_DetailController.h"
#import "SW_CBCZ_Detail_swHead.h"
#import "SW_CDCZ_Detail_swData.h"
#import "SW_CBCZ_Detail_swjg.h"

#import "SW_CBCZ_Detail_HeadCell.h"
#import "SW_CBCZ_Detail_DataCell.h"
#import "SW_CBCZ_Detail_ChuLi_Cell.h"
#import "SW_CBCZ_Detail_ShenPi_Cell.h"
#import "SW_CBCZ_Detail_ZiXun_Cell.h"


#import "SW_CBCZ_Detail_ChuLi_Controller.h"
#import "SW_CBCZ_Detail_ShenPi_Controller.h"
#import "SW_CBCZ_Detail_ZiXun_Controller.h"

#import "BigChartViewController.h"
@interface SW_CBCZ_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * datas;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,strong) SW_CBCZ_Detail_swHead * headModel;
@property (nonatomic,strong) SW_CBCZ_Detail_swjg   * swjgModel;
@end

@implementation SW_CBCZ_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUi];
    [self loadData];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"big" style:UIBarButtonItemStylePlain target:self action:@selector(big)];
    
}
-(void)big{
    BigChartViewController * big = [[BigChartViewController alloc] init];
    big.view.frame = CGRectMake(0, 0, Screen_w, Screen_h);
    [[UIApplication sharedApplication].keyWindow addSubview:big.view];
}
-(void)dealloc{
    FuncLog;
}
-(void)loadUi{
    self.tb.separatorColor = [UIColor clearColor];
     self.tb.tableFooterView = [[UIView alloc] init];
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"SW_CBCZ_Detail_HeadCell" bundle:nil] forCellReuseIdentifier:@"SW_CBCZ_Detail_HeadCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"SW_CBCZ_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"SW_CBCZ_Detail_DataCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"SW_CBCZ_Detail_ChuLi_Cell" bundle:nil] forCellReuseIdentifier:@"SW_CBCZ_Detail_ChuLi_Cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"SW_CBCZ_Detail_ShenPi_Cell" bundle:nil] forCellReuseIdentifier:@"SW_CBCZ_Detail_ShenPi_Cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"SW_CBCZ_Detail_ZiXun_Cell" bundle:nil] forCellReuseIdentifier:@"SW_CBCZ_Detail_ZiXun_Cell"];
}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
    NSString * urlString = [NSString stringWithFormat:chaoBiaoXQ,_shebeibianhao,_bianhao];
//    NSDictionary * dict = @{@"bianhao":self.bianhao,
//                            @"shebeibianhao":self.shebeibianhao
//                            };
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"swData"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"swData"]) {
                    SW_CDCZ_Detail_swData * data = [SW_CDCZ_Detail_swData modelWithDict:dict];
                    [datas addObject:data];
                }
            }
            if ([json[@"swHead"] isKindOfClass:[NSDictionary class]]) {
                SW_CBCZ_Detail_swHead * headModel = [SW_CBCZ_Detail_swHead modelWithDict:json[@"swHead"]];
                weakSelf.headModel = headModel;
            }
            if ([json[@"swjg"] isKindOfClass:[NSDictionary class]]) {
                SW_CBCZ_Detail_swjg * swjgModel = [SW_CBCZ_Detail_swjg modelWithDict:json[@"swjg"]];
                weakSelf.swjgModel = swjgModel;
            }
            //
            weakSelf.datas = datas;
            [weakSelf.tb reloadData];
            [Tools removeActivity];
        }

        
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
    return 5;
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
        case 4:return @"咨询信息";
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
    if (indexPath.section == 4) {
        if (EqualToString(self.zxdwshenhe, @"1")) {
            return 105;
        }else{
            return 40;
        }
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SW_CBCZ_Detail_HeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_CBCZ_Detail_HeadCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.model = self.headModel;
        return cell;
    }
    if (indexPath.section == 1) {
        SW_CBCZ_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_CBCZ_Detail_DataCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row > 0) {
            SW_CDCZ_Detail_swData * data = indexPath.row ==0 ? nil :self.datas[indexPath.row-1];
            //cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
            cell.color = [UIColor blackColor];
            cell.model= data;
        }
        return cell;
    }
    if (indexPath.section == 2) {
        if (EqualToString(self.chuli, @"1")) {
            SW_CBCZ_Detail_ChuLi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_CBCZ_Detail_ChuLi_Cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.model = self.swjgModel;
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//            if (EqualToString([UserDefaultsSetting shareSetting].chuzhi, @"1")) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(0, 0, Screen_w, 40);
                [btn setTitle:@"点击这里开始处置..." forState:UIControlStateNormal];
                [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [cell.contentView addSubview:btn];
                [btn addTarget:self action:@selector(goto_chuzhi) forControlEvents:UIControlEventTouchUpInside];
//            }else{
//                UILabel * label = [[UILabel alloc] init];
//                label.frame = CGRectMake(0, 0, Screen_w, 40);
//                label.text = @"您没有处置权限";
//                label.textAlignment = NSTextAlignmentCenter;
//                label.font = [UIFont systemFontOfSize:12.0f];
//                label.textColor = [UIColor blueColor];
//                [cell.contentView addSubview:label];
//            }
            return cell;
        }
    }
    if (indexPath.section == 3) {
        if (EqualToString(self.shenpi, @"1")) {
            SW_CBCZ_Detail_ShenPi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_CBCZ_Detail_ShenPi_Cell"];
            cell.model = self.swjgModel;
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            if (EqualToString([UserDefaultsSetting shareSetting].shenehe, @"1")) {
                
                if (!EqualToString(self.chuli, @"1")) {
                    UILabel * label = [[UILabel alloc] init];
                    label.frame = CGRectMake(0, 0, Screen_w, 40);
                    label.text = @"请先处置后再审批..";
                    label.textAlignment = NSTextAlignmentCenter;
                    label.font = [UIFont systemFontOfSize:12.0f];
                    label.textColor = [UIColor blueColor];
                    [cell.contentView addSubview:label];
                }else{
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                    btn.frame = CGRectMake(0, 0, Screen_w, 40);
                    [btn setTitle:@"点击这里开始审核.." forState:UIControlStateNormal];
                    [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                    [cell.contentView addSubview:btn];
                    [btn addTarget:self action:@selector(goto_shenpi) forControlEvents:UIControlEventTouchUpInside];
                }
            }else{
                UILabel * label = [[UILabel alloc] init];
                label.frame = CGRectMake(0, 0, Screen_w, 40);
                label.text = @"没有审批权限..";
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:12.0f];
                label.textColor = [UIColor blueColor];
                [cell.contentView addSubview:label];
            }
            return cell;
        }
    }
    if (indexPath.section == 4) {
        if (EqualToString(self.zxdwshenhe, @"1")) {
            SW_CBCZ_Detail_ZiXun_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_CBCZ_Detail_ZiXun_Cell"];
            cell.model = self.swjgModel;
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            if (EqualToString([UserDefaultsSetting shareSetting].zxdwshenhe, @"1")) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(0, 0, Screen_w, 40);
                [btn setTitle:@"点击这里开始咨询.." forState:UIControlStateNormal];
                [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [cell.contentView addSubview:btn];
                [btn addTarget:self action:@selector(goto_zixun) forControlEvents:UIControlEventTouchUpInside];
            }else{
                UILabel * label = [[UILabel alloc] init];
                label.frame = CGRectMake(0, 0, Screen_w, 40);
                label.text = @"没有咨询信息..";
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
    SW_CBCZ_Detail_ChuLi_Controller * vc = [[SW_CBCZ_Detail_ChuLi_Controller alloc] init];
    vc.jieguobianhao = self.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goto_shenpi{
    SW_CBCZ_Detail_ShenPi_Controller * vc = [[SW_CBCZ_Detail_ShenPi_Controller alloc] init];
    vc.jieguobianhao = self.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goto_zixun{
    SW_CBCZ_Detail_ZiXun_Controller * vc = [[SW_CBCZ_Detail_ZiXun_Controller alloc] init];
    vc.jieguobianhao = self.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
