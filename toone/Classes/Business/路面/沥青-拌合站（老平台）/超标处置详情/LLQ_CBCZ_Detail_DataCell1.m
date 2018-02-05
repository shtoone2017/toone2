//
//  LLQ_CBCZ_Detail_DataCell1.m
//  toone
//
//  Created by 上海同望 on 2018/2/5.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "LLQ_CBCZ_Detail_DataCell1.h"
#import "LLQ_CDCZ_Detail_lqData.h"

@interface LLQ_CBCZ_Detail_DataCell1()
//油石比
@property (weak, nonatomic) IBOutlet UILabel *ysb1;//实际
@property (weak, nonatomic) IBOutlet UILabel *ysb2;//理论
@property (weak, nonatomic) IBOutlet UILabel *ysb3;//误差
@property (weak, nonatomic) IBOutlet UILabel *ysb4;//用量
@property (weak, nonatomic) IBOutlet UIImageView *ysbImg;
//石料
@property (weak, nonatomic) IBOutlet UILabel *slsj1;//实际
@property (weak, nonatomic) IBOutlet UILabel *slll1;//理论
@property (weak, nonatomic) IBOutlet UILabel *slwc1;//误差
@property (weak, nonatomic) IBOutlet UILabel *slyl1;//用量
@property (weak, nonatomic) IBOutlet UIImageView *slImg1;
@property (weak, nonatomic) IBOutlet UILabel *slsj2;//实际
@property (weak, nonatomic) IBOutlet UILabel *slll2;//理论
@property (weak, nonatomic) IBOutlet UILabel *slwc2;//误差
@property (weak, nonatomic) IBOutlet UILabel *slyl2;//用量
@property (weak, nonatomic) IBOutlet UIImageView *slImg2;
@property (weak, nonatomic) IBOutlet UILabel *slsj3;//实际
@property (weak, nonatomic) IBOutlet UILabel *slll3;//理论
@property (weak, nonatomic) IBOutlet UILabel *slwc3;//误差
@property (weak, nonatomic) IBOutlet UILabel *slyl3;//用量
@property (weak, nonatomic) IBOutlet UIImageView *slImg3;
@property (weak, nonatomic) IBOutlet UILabel *slsj4;//实际
@property (weak, nonatomic) IBOutlet UILabel *slll4;//理论
@property (weak, nonatomic) IBOutlet UILabel *slwc4;//误差
@property (weak, nonatomic) IBOutlet UILabel *slyl4;//用量
@property (weak, nonatomic) IBOutlet UIImageView *slImg4;
@property (weak, nonatomic) IBOutlet UILabel *slsj5;//实际
@property (weak, nonatomic) IBOutlet UILabel *slll5;//理论
@property (weak, nonatomic) IBOutlet UILabel *slwc5;//误差
@property (weak, nonatomic) IBOutlet UILabel *slyl5;//用量
@property (weak, nonatomic) IBOutlet UIImageView *slImg5;
@property (weak, nonatomic) IBOutlet UILabel *slsj6;//实际
@property (weak, nonatomic) IBOutlet UILabel *slll6;//理论
@property (weak, nonatomic) IBOutlet UILabel *slwc6;//误差
@property (weak, nonatomic) IBOutlet UILabel *slyl6;//用量
@property (weak, nonatomic) IBOutlet UIImageView *slImg6;
@property (weak, nonatomic) IBOutlet UILabel *slsj7;//实际
@property (weak, nonatomic) IBOutlet UILabel *slll7;//理论
@property (weak, nonatomic) IBOutlet UILabel *slwc7;//误差
@property (weak, nonatomic) IBOutlet UILabel *slyl7;//用量
@property (weak, nonatomic) IBOutlet UIImageView *slImg7;
//粉料
@property (weak, nonatomic) IBOutlet UILabel *flsj1;//实际
@property (weak, nonatomic) IBOutlet UILabel *flll1;//理论
@property (weak, nonatomic) IBOutlet UILabel *flwc1;//误差
@property (weak, nonatomic) IBOutlet UILabel *flyl1;//用量
@property (weak, nonatomic) IBOutlet UIImageView *flImg1;
@property (weak, nonatomic) IBOutlet UILabel *flsj2;//实际
@property (weak, nonatomic) IBOutlet UILabel *flll2;//理论
@property (weak, nonatomic) IBOutlet UILabel *flwc2;//误差
@property (weak, nonatomic) IBOutlet UILabel *flyl2;//用量
@property (weak, nonatomic) IBOutlet UIImageView *flImg2;


//沥青
@property (weak, nonatomic) IBOutlet UILabel *lq1;//实际
@property (weak, nonatomic) IBOutlet UILabel *lq2;//理论
@property (weak, nonatomic) IBOutlet UILabel *lq3;//误差
@property (weak, nonatomic) IBOutlet UILabel *lq4;//用量
@property (weak, nonatomic) IBOutlet UIImageView *lqImg;
//添加剂
@property (weak, nonatomic) IBOutlet UILabel *tjj1;//实际
@property (weak, nonatomic) IBOutlet UILabel *tjj2;//理论
@property (weak, nonatomic) IBOutlet UILabel *tjj3;//误差
@property (weak, nonatomic) IBOutlet UILabel *tjj4;//用量
@property (weak, nonatomic) IBOutlet UIImageView *tjjImg;

@end
@implementation LLQ_CBCZ_Detail_DataCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(LLQ_CDCZ_Detail_lqData *)model {
    _model = model;
    _ysb1.text = model.sjysbper;
    _ysb2.text = model.llysb;
    _ysb3.text = model.sjysbwc;
    _ysb4.text = model.sjysb;
    
    _lq1.text = model.sjlqper;
    _lq2.text = model.lllq;
    _lq3.text = model.sjlqwc;
    _lq4.text = model.sjlq;
    
    _tjj1.text = model.sjtjjper;
    _tjj2.text = model.lltjj;
    _tjj3.text = model.sjtjjwc;
    _tjj4.text = model.sjtjj;
    
    _flsj1.text = model.sjf1per;
    _flll1.text = model.llf1;
    _flwc1.text = model.sjf1wc;
    _flyl1.text = model.sjf1;
    _flsj2.text = model.sjf2per;
    _flll2.text = model.llf2;
    _flwc2.text = model.sjf2wc;
    _flyl2.text = model.sjf2;
    
    _slsj1.text = model.sjg1per;
    _slll1.text = model.llg1;
    _slwc1.text = model.sjg1wc;
    _slyl1.text = model.sjg1;
    _slsj2.text = model.sjg2per;
    _slll2.text = model.llg2;
    _slwc2.text = model.sjg2wc;
    _slyl2.text = model.sjg2;
    _slsj3.text = model.sjg3per;
    _slll3.text = model.llg3;
    _slwc3.text = model.sjg3wc;
    _slyl3.text = model.sjg3;
    _slsj4.text = model.sjg4per;
    _slll4.text = model.llg4;
    _slwc4.text = model.sjg4wc;
    _slyl4.text = model.sjg4;
    _slsj5.text = model.sjg5per;
    _slll5.text = model.llg5;
    _slwc5.text = model.sjg5wc;
    _slyl5.text = model.sjg5;
    _slsj6.text = model.sjg6per;
    _slll6.text = model.llg6;
    _slwc6.text = model.sjg6wc;
    _slyl6.text = model.sjg6;
    _slsj7.text = model.sjg7per;
    _slll7.text = model.llg7;
    _slwc7.text = model.sjg7wc;
    _slyl7.text = model.sjg7;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
