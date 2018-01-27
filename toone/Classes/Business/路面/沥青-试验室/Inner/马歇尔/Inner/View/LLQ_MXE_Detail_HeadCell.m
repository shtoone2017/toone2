//
//  HNT_CBCZ_Cell.m
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_MXE_Detail_HeadCell.h"
#import "LLQ_MXE_Detail_Head.h"
@interface LLQ_MXE_Detail_HeadCell()
@property (weak, nonatomic) IBOutlet UILabel * chuliaoshijian_Label         ;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 样品编号
@property (weak, nonatomic) IBOutlet UILabel * gongchengmingcheng_Label     ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * jiaozuobuwei_Label           ;// 浇筑部位
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 样品名称

@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;
@end
@implementation LLQ_MXE_Detail_HeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.container2.hidden = YES;
    self.container1.hidden = YES;
    self.container1.transform=CGAffineTransformMakeRotation(M_PI_4);//旋转角度，90度
//    self.container2.transform=CGAffineTransformMakeRotation(-M_PI_4);//旋转角度，90度
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(LLQ_MXE_Detail_Head *)model{
    self.chuliaoshijian_Label.text = model.is_testtime;
    self.banhezhanminchen_Label.text = model.header5;
    self.gongchengmingcheng_Label.text = model.header3;
    self.jiaozuobuwei_Label.text = model.SHeader2;
    self.sigongdidian_Label.text = model.SHeader3;
}
@end
