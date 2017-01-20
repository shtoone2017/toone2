//
//  DayDetailsCell.m
//  toone
//
//  Created by shtoone on 17/1/3.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "DayDetailsCell.h"
#import "DayQueryModel.h"
#import "NetworkTool.h"

@interface DayDetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateTextF;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation DayDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)model:(DayQueryModel*)model withIndex:(long)index{
    self.iconView.hidden = NO;
    switch (index) {
        case 0:
            self.dateTextF.text =model.dailyrq;
            self.titleLabel.text = @"日期";
            self.iconView.hidden = YES;
            break;
        case 1:
            self.dateTextF.text =model.dailycl;
            self.titleLabel.text = @"采集产量(kg)";
            self.iconView.hidden = YES;
            break;
        case 2:
            self.dateTextF.text =model.dailyps;
            self.titleLabel.text = @"盘数";
            self.iconView.hidden = YES;
            break;
        case 3:
            self.dateTextF.text =model.dailyxzcl;
            self.titleLabel.text = @"修正产量(kg)";
            break;
        case 4:
            self.dateTextF.text =model.dailymd;
            self.titleLabel.text = @"标准密度(kg/m2)";
            break;
        case 5:
            self.dateTextF.text =model.dailybuwei;
            self.titleLabel.text = @"施工桩号";
            break;
        case 6:
            self.dateTextF.text =model.dailycd;
            self.titleLabel.text = @"长度(m)";
            break;
        case 7:
            self.dateTextF.text =model.dailykd;
            self.titleLabel.text = @"宽度(m)";
            break;
        case 8:
            self.dateTextF.text =model.dailyhd;
            self.titleLabel.text = @"厚度(m)";
            self.iconView.hidden = YES;
            break;
        case 9:
            self.dateTextF.text =model.dailysjhd;
            self.titleLabel.text = @"实际厚度";
            break;
        case 10:
            self.dateTextF.text =model.dailyxh;
            self.titleLabel.text = @"型号";
            break;
        case 11:
            self.dateTextF.text =model.dailybeizhu;
            self.titleLabel.text = @"备注";
            break;
        default:
            break;
    }
}

/*
//计算
- (IBAction)calculateClick:(id)sender {
    int yzzcl = (int)self.dailyxzclTextF.text;
    int ycl = (int) self.dailyclTextF.text;
    int cd = (int) self.dailycdTextF.text;
    int kd = (int) self.dailykdTextF.text;
    int md = (int) self.dailymdTextF.text;
    int sun = (yzzcl + ycl) / (cd * kd * md) *100;
    NSLog(@"sun = %d",sun);
    self.dailyhdTextF.text = [NSString stringWithFormat:@"%d",sun];
}
//提交
- (IBAction)submitClick:(id)sender {
    if (self.dailybuweiTextF.text.length == 0 || self.dailyxzclTextF.text.length == 0 || self.dailymdTextF.text.length == 0 || self.dailycdTextF.text.length == 0 || self.dailykdTextF.text.length == 0|| self.dailysjhdTextF.text.length == 0 || self.xhTextF.text.length == 0 || self.dailybeizhuTextF.text.length == 0) {
        [Tools tip:@"信息不完整，无法提交"];
    }else {
        NSString *urlString = FormatString(baseUrlStr, @"lqclDailyController.do?dayproducecountadd");
        NSDictionary * dic = @{@"dailybeizhu":self.dailybeizhuTextF.text,
                               @"dailybuwei":self.dailybuweiTextF.text,
                               @"dailycd":self.dailycdTextF.text,
                               @"dailycl":self.dailyclTextF.text,
                               @"dailyhd":self.dailyhdTextF.text,
                               @"dailyid":[UserDefaultsSetting shareSetting].dailyid,
                               @"dailykd":self.dailykdTextF.text,
                               @"dailymd":self.dailymdTextF.text,
                               @"dailyps":self.dailypsTextF.text,
                               @"dailyrq":self.dateTextF.text,
                               @"dailysbbh":[UserDefaultsSetting shareSetting].dailysbbh,
                               @"dailysjhd":self.dailysjhdTextF.text,
                               @"dailyxzcl":self.dailyxzclTextF.text,
                               @"dailyxh":self.xhTextF.text
                               };
        NSError  * err;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
        NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSDictionary * newDic = @{@"data":jsonStr};
        [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:newDic success:^(id json) {
            
            if ([json[@"success"] boolValue]){
                [Tools tip:@"提交成功,请刷新数据"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self.weakController.navigationController popViewControllerAnimated:YES];
                });
            }else{
                [Tools tip:@"抱歉，提交失败"];
            }
        } failure:^(NSError *error) {
            [Tools tip:@"网络故障，提交失败"];
        }];
        
    }
}

//清空
- (IBAction)emptyClick:(id)sender {
    self.dailybuweiTextF.text = nil;
    self.dailyxzclTextF.text = nil;
    self.dailymdTextF.text = nil;
    self.dailycdTextF.text = nil;
    self.dailykdTextF.text = nil;
    self.dailysjhdTextF.text = nil;
    self.xhTextF.text = nil;
    self.dailybeizhuTextF.text = nil;
}
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
