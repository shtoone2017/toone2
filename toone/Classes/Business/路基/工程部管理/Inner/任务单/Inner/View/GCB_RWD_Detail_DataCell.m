//
//  GCB_RWD_Detail_DataCell.m
//  toone
//
//  Created by 上海同望 on 2017/8/20.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_RWD_Detail_DataCell.h"
#import "GCB_RWD_HeadModel.h"

@interface GCB_RWD_Detail_DataCell ()
@property (weak, nonatomic) IBOutlet UILabel *jgLabel;
@property (weak, nonatomic) IBOutlet UILabel *kptimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *jzbwLabel;//浇筑部位
@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *jhLbel;//计划方量
@property (weak, nonatomic) IBOutlet UILabel *rwbhLabel;//任务编号
@property (weak, nonatomic) IBOutlet UILabel *sjqdLabel;//设计强度
@property (weak, nonatomic) IBOutlet UILabel *jzfsLabel;//浇筑方式


@end
@implementation GCB_RWD_Detail_DataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(GCB_RWD_HeadModel *)model {
    _model = model;
    _jgLabel.text = model.departName;
    _kptimeLabel.text = model.kaipanriqi;
    _jzbwLabel.text = model.jzbw;
    _gcmcLabel.text = model.gcmc;
    _jhLbel.text = model.jihuafangliang;
    _rwbhLabel.text = model.renwuno;
    _sjqdLabel.text = model.shuinibiaohao;
    _jzfsLabel.text = model.jiaozhufangshi;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
