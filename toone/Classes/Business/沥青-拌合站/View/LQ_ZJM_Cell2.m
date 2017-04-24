
//
//  LQ_ZJM_Cell2.m
//  toone
//
//  Created by sg on 2017/4/24.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_ZJM_Cell2.h"
@interface LQ_ZJM_Cell2()
@property (weak, nonatomic) IBOutlet  UILabel * dailycl_Label;// 每日产量
@property (weak, nonatomic) IBOutlet  UILabel * ljchangliang_Label;// 总产量
@property (weak, nonatomic) IBOutlet  UILabel * dailyps_Label;// 每日盘数
@property (weak, nonatomic) IBOutlet  UILabel * panshu_Label;// 总盘数
@property (weak, nonatomic) IBOutlet  UILabel * czps_Label;// 处置盘数
@property (weak, nonatomic) IBOutlet  UILabel * zcbps_Label;// 总超标盘数
@property (weak, nonatomic) IBOutlet  UILabel * cblv_Label;// 超标处置率
@property (weak, nonatomic) IBOutlet  UILabel * dczps_Label;// 待处置盘数


@end
@implementation LQ_ZJM_Cell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(LQ_SGModel *)model{
    _model = model;
    self.dailycl_Label.text = model.dailycl;
    self.ljchangliang_Label.text = model.ljchangliang;
    self.dailyps_Label.text = model.dailyps;
    self.panshu_Label.text =  model.panshu;
    self.czps_Label.text = Format(model.czps);
    self.zcbps_Label.text = Format(model.zcbps);
    self.cblv_Label.text = Format(model.cblv);
    self.dczps_Label.text = Format(model.dczps);
}
@end
