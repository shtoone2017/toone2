//
//  LLQ_CLHS_Cell1.m
//  toone
//
//  Created by 上海同望 on 2018/2/5.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "LLQ_CLHS_Cell1.h"
#import "LLQ_CLHS_Model.h"

@interface LLQ_CLHS_Cell1()
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 拌合站名称
@property (weak, nonatomic) IBOutlet UILabel *buwei_Label           ;//搅拌时间
@property (weak, nonatomic) IBOutlet UILabel * gujifangshu_Label            ;//油石比
@property (weak, nonatomic) IBOutlet UILabel *shijian_Label         ;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * guliao_Label           ;// 骨料1

@end

@implementation LLQ_CLHS_Cell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(LLQ_CLHS_Model *)model {
    _model = model;
    _banhezhanminchen_Label.text = model.banhezhanminchen;
    _buwei_Label.text = model.jbsj;
    _gujifangshu_Label.text = model.sjysb;
    _shijian_Label.text = model.shijian;
    _guliao_Label.text = model.sjg1;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
