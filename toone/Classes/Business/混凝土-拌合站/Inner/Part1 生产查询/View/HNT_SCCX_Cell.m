//
//  HNT_SCCX_Cell.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SCCX_Cell.h"
#import "HNT_SCCX_Model.h"

@interface HNT_SCCX_Cell()
@property (weak, nonatomic) IBOutlet UILabel * chuliaoshijian_Label;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label;// 拌合站名称
@property (weak, nonatomic) IBOutlet UILabel * gongchengmingcheng_Label;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * jiaozuobuwei_Label;// 浇筑部位
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label;// 施工地点
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label;// 强度等级
@property (weak, nonatomic) IBOutlet UILabel * gujifangshu_Label;// 估计方数
@end

@implementation HNT_SCCX_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setModel:(HNT_SCCX_Model *)model{
    self.chuliaoshijian_Label.text = model.shijian;
    self.banhezhanminchen_Label.text = model.banhezhanmingchen;
    self.gongchengmingcheng_Label.text = model.gcmc;
    self.jiaozuobuwei_Label.text = model.jzbw;
    self.sigongdidian_Label.text = model.sigongdidian;
    self.qiangdudengji_Label.text = model.qiangdudengji;
    self.gujifangshu_Label.text = model.gujifangshu;
}
@end
