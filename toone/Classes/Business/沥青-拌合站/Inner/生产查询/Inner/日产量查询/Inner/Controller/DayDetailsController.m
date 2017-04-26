//
//  DayDetailsController.m
//  toone
//
//  Created by shtoone on 17/1/3.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "DayDetailsController.h"
#import "DayDetailsCell.h"
#import "DayQueryModel.h"
#import "Masonry.h"

@interface DayDetailsController ()
//@property (nonatomic, strong) MyInputController *inputVc;
@property (assign,  nonatomic) bool isPop;

@end
@implementation DayDetailsController

-(void)viewWillAppear:(BOOL)animated {
    if (_isPop) {
        [self.tableView reloadData];
    }else{
        //执行PUSH进来时的方法
    }
    _isPop=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.weakController = self;
    _isPop=NO;
    [self setUI];
}
-(void)setUI {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.title = @"日产量详情";
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = 40;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DayDetailsCell";
    UINib *nib = [UINib nibWithNibName:@"DayDetailsCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    DayDetailsCell *cell = (DayDetailsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    [cell model:self.model withIndex:indexPath.row];
    return cell;
}

#pragma mark - 点击cell修改数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 8) {
    }else {
//        self.inputVc = [[MyInputController alloc]  init];
//        self.inputVc.index = indexPath.row;
//        self.inputVc.model = self.model;
//        [self.navigationController pushViewController:_inputVc animated:YES];
    }
}
#define butW Screen_w/3-50
#define butY 25
#define butH 30
#define butX Screen_w/4-50
#pragma mark - 添加按钮
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_w, 50)];
//    footView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableFooterView = footView;
    //计算
//    UIButton *calculateBut  = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, butW, butH)];
    UIButton *calculateBut = [[UIButton alloc] init];
    calculateBut.backgroundColor = [UIColor orangeColor];
    calculateBut.layer.cornerRadius = 2.0f;
    calculateBut.layer.masksToBounds = YES;
    [calculateBut setTitle:@"计算" forState:UIControlStateNormal];
    [calculateBut addTarget:self action:@selector(calculateClick:) forControlEvents:UIControlEventTouchUpInside];
    calculateBut.titleLabel.textColor = [UIColor whiteColor];
    calculateBut.titleLabel.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:calculateBut];
    //提交
//    UIButton *submitBut  = [[UIButton alloc]initWithFrame:CGRectMake((butX)*5, butY, butW, butH)];
    UIButton *submitBut = [[UIButton alloc] init];
    submitBut.backgroundColor = [UIColor grassColor];
    submitBut.layer.cornerRadius = 2.0f;
    submitBut.layer.masksToBounds = YES;
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [submitBut addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBut.titleLabel.textColor = [UIColor whiteColor];
    submitBut.titleLabel.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:submitBut];
    
    UIButton *but = [[UIButton alloc] init];
    but.hidden = YES;
    but.backgroundColor = [UIColor purpleColor];
    [footView addSubview:but];
    
    [calculateBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(80);
        //中心 Y
        make.centerY.equalTo(footView);
        make.height.equalTo(calculateBut.mas_width);
        make.height.equalTo(self.view.mas_height).multipliedBy(10/20.0f);
    }];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        //中心 Y
        make.centerX.equalTo(footView);
        make.centerY.equalTo(footView);
        make.height.equalTo(but.mas_width);
        make.height.equalTo(self.view.mas_height).multipliedBy(10/20.0f);
    }];
    [submitBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footView).offset(-80);
        make.centerY.equalTo(footView);
        make.height.equalTo(submitBut.mas_width);
        make.height.equalTo(self.view.mas_height).multipliedBy(10/20.0f);
    }];
    
    //清空
//    UIButton *emptyBut  = [[UIButton alloc]initWithFrame:CGRectMake(butX+butW+butW+80, butY, butW, butH)];
//    emptyBut.backgroundColor = [UIColor lightGrayColor];
//    emptyBut.layer.cornerRadius = 2.0f;
//    emptyBut.layer.masksToBounds = YES;
//    [emptyBut setTitle:@"清空" forState:UIControlStateNormal];
//    [emptyBut addTarget:self action:@selector(emptyClick:) forControlEvents:UIControlEventTouchUpInside];
//    emptyBut.titleLabel.textColor = [UIColor whiteColor];
//    emptyBut.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [footView addSubview:emptyBut];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

#pragma mark - 计算
-(void)calculateClick:(id)sender {
//    float yzzcl;
//    float ycl;
//    float cd;
//    float kd;
//    float md;
//    float sun;
//     yzzcl =  [self.model.dailyxzcl  floatValue];
//     ycl =  [self.model.dailycl floatValue];
//     cd =  [self.model.dailycd floatValue];
//     kd =  [self.model.dailykd floatValue];
//     md = [self.model.dailymd floatValue];
//    if (cd == 0 || kd == 0 || md == 0) {
//        sun = 0;
//    }else {
//        sun = (yzzcl + ycl) / (cd * kd * md) *100;
//    }
//    self.model.dailyhd = [NSString stringWithFormat:@"%.2f",sun];
//    [self.tableView reloadData];
}

#pragma mark - 提交
- (void)submitClick:(id)sender {
//    if (self.model.dailybuwei || self.model.dailyxzcl || self.model.dailymd || self.model.dailycd || self.model.dailykd || self.model.dailysjhd || self.model.dailyxh || self.model.dailybeizhu) {
//        NSString *urlString = FormatString(baseUrl, @"lqclDailyController.do?dayproducecountadd");
//        NSDictionary * dic = @{@"dailybeizhu":self.model.dailybeizhu,
//                               @"dailybuwei":self.model.dailybuwei,
//                               @"dailycd":self.model.dailycd,
//                               @"dailycl":self.model.dailycl,
//                               @"dailyhd":self.model.dailyhd,
//                               @"dailyid":[UserDefaultsSetting shareSetting].dailyid,
//                               @"dailykd":self.model.dailykd,
//                               @"dailymd":self.model.dailymd,
//                               @"dailyps":self.model.dailyps,
//                               @"dailyrq":self.model.dailyrq,
//                               @"dailysbbh":[UserDefaultsSetting shareSetting].dailysbbh,
//                               @"dailysjhd":self.model.dailysjhd,
//                               @"dailyxzcl":self.model.dailyxzcl,
//                               @"dailyxh":self.model.dailyxh
//                               };
//        NSError  * err;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
//        NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSDictionary * newDic = @{@"data":jsonStr};
//        [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:newDic success:^(id json) {
//            if ([json[@"success"] boolValue]){
//                [Tools tip:@"提交成功,请刷新数据"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                    [self.weakController.navigationController popViewControllerAnimated:YES];
//                });
//            }else{
//                [Tools tip:@"抱歉，提交失败"];
//            }
//        } failure:^(NSError *error) {
//            [Tools tip:@"网络故障，提交失败"];
//        }];
//    }else {
//         [Tools tip:@"信息不完整，无法提交"];
//    }
}
/*
//清空
- (void)emptyClick:(id)sender {
    self.model.dailybuwei = nil;
    self.model.dailyxzcl = nil;
    self.model.dailymd = nil;
    self.model.dailycd = nil;
    self.model.dailykd = nil;
    self.model.dailysjhd = nil;
    self.model.dailyxh = nil;
    self.model.dailybeizhu = nil;
    [self.tableView reloadData];
}
*/
@end
