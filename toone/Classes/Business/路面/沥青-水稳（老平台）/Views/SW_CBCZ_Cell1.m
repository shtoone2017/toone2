//
//  SW_CBCZ_Cell1.m
//  toone
//
//  Created by 上海同望 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "SW_CBCZ_Cell1.h"
#import "SW_CBCZ_Model.h"

@interface SW_CBCZ_Cell1()
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 拌合站名称
@property (weak, nonatomic) IBOutlet UILabel *buwei_Label           ;// 编号
@property (weak, nonatomic) IBOutlet UILabel * gujifangshu_Label            ;// 估计方数
@property (weak, nonatomic) IBOutlet UILabel *shijian_Label         ;// 时间
@property (weak, nonatomic) IBOutlet UILabel * guliao_Label           ;// 骨料1

@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;
@end
@implementation SW_CBCZ_Cell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.container1.transform=CGAffineTransformMakeRotation(M_PI_4);//旋转角度，90度
    self.container2.transform=CGAffineTransformMakeRotation(-M_PI_4);//旋转角度，90度
}

-(void)setModel:(SW_CBCZ_Model *)model {
    _model = model;
    _banhezhanminchen_Label.text = model.banhezhanminchen;
    _shijian_Label.text = model.shijian;
    _buwei_Label.text = [NSString stringWithFormat:@"%@",model.bhId];
    _gujifangshu_Label.text = [NSString stringWithFormat:@"%@",model.glchangliang];
    _guliao_Label.text = [NSString stringWithFormat:@"%@",model.sjgl1];
    
    if(EqualToString(model.chuli, @"0")){
        self.container1_label.backgroundColor = [UIColor bananaColor];
        self.container1_label.text = @"未处置";
    }else if(EqualToString(model.chuli, @"1")){
        self.container1_label.backgroundColor = [UIColor emeraldColor];
        self.container1_label.text = @"已处置";
    }else {
        self.container1.hidden = YES;
    }
    self.container2.hidden = NO;
    if (EqualToString(model.shenhe, @"1")) {
        self.container2_label.text = @"已审核";
        self.container2.backgroundColor = [UIColor emeraldColor];
    }else{
        self.container2_label.text = @"未审核";
        self.container2.backgroundColor = [UIColor brickRedColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
