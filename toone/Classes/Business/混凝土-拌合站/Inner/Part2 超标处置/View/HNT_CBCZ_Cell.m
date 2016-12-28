//
//  HNT_CBCZ_Cell.m
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Cell.h"
#import "HNT_CBCZ_Model.h"
@interface HNT_CBCZ_Cell()
@property (weak, nonatomic) IBOutlet UILabel * chuliaoshijian_Label         ;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 拌合站名称
@property (weak, nonatomic) IBOutlet UILabel * gongchengmingcheng_Label     ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * jiaozuobuwei_Label           ;// 浇筑部位
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 施工地点
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label          ;// 强度等级
@property (weak, nonatomic) IBOutlet UILabel * gujifangshu_Label            ;// 估计方数

@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;
@end
@implementation HNT_CBCZ_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.container1.transform=CGAffineTransformMakeRotation(M_PI_4);//旋转角度，90度
    self.container2.transform=CGAffineTransformMakeRotation(-M_PI_4);//旋转角度，90度
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(HNT_CBCZ_Model *)model{
    self.chuliaoshijian_Label.text = model.chuliaoshijian;
    self.banhezhanminchen_Label.text = model.banhezhanminchen;
    self.gongchengmingcheng_Label.text = model.gongchengmingcheng;
    self.jiaozuobuwei_Label.text = model.jiaozuobuwei;
    self.sigongdidian_Label.text = model.sigongdidian;
    self.qiangdudengji_Label.text = model.qiangdudengji;
    self.gujifangshu_Label.text = model.gujifangshu;
    
    self.container1_label.textColor = [UIColor whiteColor];
    self.container2_label.textColor = [UIColor whiteColor];
    self.container1.hidden = NO;
    if(EqualToString(model.chuli, @"0")){
        self.container1_label.backgroundColor = [UIColor salmonColor];
        self.container1_label.text = @"未处置";
    }else if(EqualToString(model.chuli, @"1")){
        self.container1_label.backgroundColor = [UIColor grassColor];
        self.container1_label.text = @"已处置";
    }else {
        self.container1.hidden = YES;
    }
    
    
    self.container2.hidden = NO;
    if (EqualToString(model.shenhe, @"2")) {
        self.container2_label.text = @"已审核";
        self.container2.backgroundColor = [UIColor bananaColor];
    }else if (EqualToString(model.shenhe, @"3")){
        self.container2_label.text = @"未审核";
        self.container2.backgroundColor = [UIColor emeraldColor];
    }else{
        self.container2.hidden = YES;
    }
}
@end
