//
//  Car_YSD_DetailCell.m
//  toone
//
//  Created by 上海同望 on 2017/10/17.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_YSD_DetailCell.h"
#import "Car_YSD_Model.h"

@interface Car_YSD_DetailCell ()
@property (weak, nonatomic) IBOutlet UILabel * fcTime_Label         ;// 发车时间
@property (weak, nonatomic) IBOutlet UILabel * facdBh_Label       ;// 发车单编号
@property (weak, nonatomic) IBOutlet UILabel * bhzBh_Label     ;// 拌合站编号
@property (weak, nonatomic) IBOutlet UILabel * gongName_Label           ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 施工部位
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label          ;// 强度等级
@property (weak, nonatomic) IBOutlet UILabel *tldLabel;
@property (weak, nonatomic) IBOutlet UILabel *qsTimeLabel;//签收时间
@property (weak, nonatomic) IBOutlet UILabel *bcflLabel;//本车
@property (weak, nonatomic) IBOutlet UILabel *sjflLabel;//实际
@property (weak, nonatomic) IBOutlet UILabel *cphLabel;//车牌号
@property (weak, nonatomic) IBOutlet UILabel *qsrLabel;//签收人
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;//司机
@property (weak, nonatomic) IBOutlet UILabel *sgbwLabel;//施工部位
@property (weak, nonatomic) IBOutlet UILabel * user_Label            ;// 发车人

@end
@implementation Car_YSD_DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(Car_YSD_Model *)model {
    _model = model;
    _fcTime_Label.text = model.FCSJ;
    _facdBh_Label.text = model.FCDBH;
    _bhzBh_Label.text = model.BHZBH;
    _gongName_Label.text = [model.GCMC stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _sigongdidian_Label.text = [model.SGBW stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _qiangdudengji_Label.text = model.QDDJ;
    _user_Label.text = [model.FCR stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _tldLabel.text = model.TLD;
    _qsTimeLabel.text = model.QSSJ;
    _bcflLabel.text = model.BCFL;
    _sjflLabel.text = model.SJFL;
    _cphLabel.text = model.CH;
    _qsrLabel.text = [model.QSR stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _sjLabel.text = [model.SJ stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _sgbwLabel.text = [model.SGBW stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
