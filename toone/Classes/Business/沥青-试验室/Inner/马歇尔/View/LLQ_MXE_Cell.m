//
//  HNT_CBCZ_Cell.m
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_MXE_Cell.h"
#import "LLQ_MXE_Model.h"
@interface LLQ_MXE_Cell()
@property (weak, nonatomic) IBOutlet UILabel * chuliaoshijian_Label         ;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 样品编号
@property (weak, nonatomic) IBOutlet UILabel * gongchengmingcheng_Label     ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * jiaozuobuwei_Label           ;// 浇筑部位
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 流值
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label          ;// 稳定值
@property (weak, nonatomic) IBOutlet UILabel * gujifangshu_Label            ;// 估计方数

@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;
@end
@implementation LLQ_MXE_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.container2.hidden = YES;
    self.container1.transform=CGAffineTransformMakeRotation(M_PI_4);//旋转角度，90度
//    self.container2.transform=CGAffineTransformMakeRotation(-M_PI_4);//旋转角度，90度
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(LLQ_MXE_Model *)model{
    self.chuliaoshijian_Label.text = model.is_testtime;
    self.banhezhanminchen_Label.text = model.header5;
    self.gongchengmingcheng_Label.text = model.header3;
    self.jiaozuobuwei_Label.text = model.SHeader2;
    self.sigongdidian_Label.text = model.avgvalue1;
    self.qiangdudengji_Label.text = model.avgvalue2;
//    self.gujifangshu_Label.text = model.gujifangshu;
    
    self.container1_label.textColor = [UIColor whiteColor];
    self.container2_label.textColor = [UIColor whiteColor];
    self.container1.hidden = NO;
    if(EqualToString(model.isQualified, @"合格")){
        self.container1_label.backgroundColor = [UIColor bananaColor];
        self.container1_label.text = @"合格";
    }else if(EqualToString(model.isQualified, @"不合格")){
        self.container1_label.backgroundColor = [UIColor emeraldColor];
        self.container1_label.text = @"不合格";
    }else {
        self.container1.hidden = YES;
    }
    
    
    
//    if (EqualToString(model.shenhe, @"1")) {
//        self.container2_label.text = @"已审核";
//        self.container2.backgroundColor = [UIColor emeraldColor];
//    }else{
//        self.container2_label.text = @"未审核";
//        self.container2.backgroundColor = [UIColor brickRedColor];
//    }
    
//    if(EqualToString(model.PDJG, @"不合格")){
//        self.container1_label.backgroundColor = [UIColor salmonColor];
//    }else if(EqualToString(model.PDJG, @"合格")){
//        self.container1_label.backgroundColor = [UIColor grassColor];
//    }else if(EqualToString(model.PDJG, @"有效")){
//        self.container1_label.backgroundColor = [UIColor pastelGreenColor];
//    }else if(EqualToString(model.PDJG, @"无效")){
//        self.container1_label.backgroundColor = [UIColor brickRedColor];
//    }
//    
//    
//    
//    if (EqualToString(model.chuzhi, @"0")) {
//        self.container2_label.text = @"未处置";
//        self.container2.backgroundColor = [UIColor bananaColor];
//    }else if (EqualToString(model.chuzhi, @"1")){
//        self.container2_label.text = @"已处置";
//        self.container2.backgroundColor = [UIColor emeraldColor];
//    }
}
@end
