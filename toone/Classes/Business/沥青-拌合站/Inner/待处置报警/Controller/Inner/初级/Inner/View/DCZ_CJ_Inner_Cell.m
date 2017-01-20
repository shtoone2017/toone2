//
//  DCZ_CJ_Inner_Cell.m
//  toone
//
//  Created by shtoone on 17/1/5.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "DCZ_CJ_Inner_Cell.h"

@interface DCZ_CJ_Inner_Cell ( )
#pragma mark - 数据头
@property (weak, nonatomic) IBOutlet UILabel *clshijiLabel;//出料时间(名称)
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UILabel *ysbLabel;//油石比
@property (weak, nonatomic) IBOutlet UILabel *ysb;
@property (weak, nonatomic) IBOutlet UILabel *llysbLabel;//理论油石比
@property (weak, nonatomic) IBOutlet UILabel *llysb;
@property (weak, nonatomic) IBOutlet UILabel *wcysbLabel;//误差
@property (weak, nonatomic) IBOutlet UILabel *wcl;
@property (weak, nonatomic) IBOutlet UILabel *lqwdLabel;//沥青温度
@property (weak, nonatomic) IBOutlet UILabel *lqwd;
@property (weak, nonatomic) IBOutlet UILabel *slwdLabel;//石料温度
@property (weak, nonatomic) IBOutlet UILabel *slwd;
@property (weak, nonatomic) IBOutlet UILabel *clwdLabel;//出料温度
@property (weak, nonatomic) IBOutlet UILabel *clwd;

#pragma mark - 核算表
//材料名称
@property (weak, nonatomic) IBOutlet UILabel *fl1Label;
@property (weak, nonatomic) IBOutlet UILabel *fl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sl1Label;
@property (weak, nonatomic) IBOutlet UILabel *sl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sl3Label;
@property (weak, nonatomic) IBOutlet UILabel *sl4Label;
@property (weak, nonatomic) IBOutlet UILabel *sl5Label;
@property (weak, nonatomic) IBOutlet UILabel *sl6Label;
@property (weak, nonatomic) IBOutlet UILabel *sl7Label;
@property (weak, nonatomic) IBOutlet UILabel *lqLabel;
@property (weak, nonatomic) IBOutlet UILabel *tjjLable;
//实际量
@property (weak, nonatomic) IBOutlet UILabel *sjfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *sjfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *sjlqLable;
@property (weak, nonatomic) IBOutlet UILabel *sjtjjLable;
//实际比
@property (weak, nonatomic) IBOutlet UILabel *bfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *bfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *blqLabel;
@property (weak, nonatomic) IBOutlet UILabel *btjjLabel;
//配比
@property (weak, nonatomic) IBOutlet UILabel *pbfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *pbfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *pblqLabel;
@property (weak, nonatomic) IBOutlet UILabel *pbtjjLabel;
//误差率
@property (weak, nonatomic) IBOutlet UILabel *wcfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *wcfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *wclqLabel;
@property (weak, nonatomic) IBOutlet UILabel *wctjjLable;
//背景View
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *View2;
@property (weak, nonatomic) IBOutlet UIView *View3;
@property (weak, nonatomic) IBOutlet UIView *View4;
@property (weak, nonatomic) IBOutlet UIView *View5;
@property (weak, nonatomic) IBOutlet UIView *View6;
@property (weak, nonatomic) IBOutlet UIView *View7;
@property (weak, nonatomic) IBOutlet UIView *View8;
@property (weak, nonatomic) IBOutlet UIView *View9;
@property (weak, nonatomic) IBOutlet UIView *View10;
@property (weak, nonatomic) IBOutlet UIView *View11;
#pragma mark - 超标处置


#pragma mark - 监理审批
@property (weak, nonatomic) IBOutlet UIView *jianLiView;


@end
@implementation DCZ_CJ_Inner_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.View1.backgroundColor = Color1;
    self.View3.backgroundColor = Color1;
    self.View5.backgroundColor = Color1;
    self.View7.backgroundColor = Color1;
    self.View9.backgroundColor = Color1;
    self.View11.backgroundColor = Color1;
    
    self.View2.backgroundColor = Color2;
    self.View4.backgroundColor = Color2;
    self.View6.backgroundColor = Color2;
    self.View8.backgroundColor = Color2;
    self.View10.backgroundColor = Color2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
