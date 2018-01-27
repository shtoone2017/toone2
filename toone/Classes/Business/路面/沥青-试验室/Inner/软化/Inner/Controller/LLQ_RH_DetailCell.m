//
//  HNT_CBCZ_Cell.m
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_RH_DetailCell.h"
#import "LLQ_RH_Model.h"
@interface LLQ_RH_DetailCell()
@property (weak, nonatomic) IBOutlet UILabel * chuliaoshijian_Label         ;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 样品编号
@property (weak, nonatomic) IBOutlet UILabel * gongchengmingcheng_Label     ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * jiaozuobuwei_Label           ;// 浇筑部位

@property (weak, nonatomic) IBOutlet UILabel *yangName;//样品名称
@property (weak, nonatomic) IBOutlet UILabel *ypmsLabel;//样品描述
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 平均值
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label          ;// 标准值

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;
@end
@implementation LLQ_RH_DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LLQ_RH_Model *)model{
    self.chuliaoshijian_Label.text = model.is_testtime;
    self.banhezhanminchen_Label.text = model.header5;
    self.gongchengmingcheng_Label.text = model.header3;
    self.jiaozuobuwei_Label.text = model.SHeader2;
    self.sigongdidian_Label.text = model.avgvalue1;
    self.qiangdudengji_Label.text = model.biaoZhun1;
    self.yangName.text = model.SHeader3;
    self.ypmsLabel.text = model.SHeader4;
    self.container1_label.text = model.ruanhuadian1;
    self.container2_label.text = model.ruanhuadian2;
}
@end
