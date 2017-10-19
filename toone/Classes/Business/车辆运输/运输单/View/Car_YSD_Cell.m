//
//  Car_YSD_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/10/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_YSD_Cell.h"
#import "Car_YSD_Model.h"

@interface Car_YSD_Cell ()
@property (weak, nonatomic) IBOutlet UILabel * fcTime_Label         ;// 发车时间
@property (weak, nonatomic) IBOutlet UILabel * facdBh_Label       ;// 发车单编号
@property (weak, nonatomic) IBOutlet UILabel * bhzBh_Label     ;// 拌合站编号
@property (weak, nonatomic) IBOutlet UILabel * gongName_Label           ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 施工部位
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label          ;// 强度等级
@property (weak, nonatomic) IBOutlet UILabel * user_Label            ;// 发车人

@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;


@end
@implementation Car_YSD_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.container1.transform=CGAffineTransformMakeRotation(M_PI_4);//旋转角度，90度
    _container2.hidden = YES;
    self.container1_label.textColor = [UIColor whiteColor];
    self.container2_label.textColor = [UIColor whiteColor];
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
    if ([model.STATUS isEqualToString:@"21"]) {
        _container1_label.text = @"拒收已处置";
        _container1_label.backgroundColor = [UIColor orangeColor];
    }else if ([model.STATUS isEqualToString:@"20"]) {
        _container1_label.text = @"拒收未处置";
        _container1_label.backgroundColor = [UIColor redColor];
    }else if ([model.STATUS isEqualToString:@"0"]) {
        _container1_label.text = @"待签收";
        _container1_label.backgroundColor = [UIColor yellowGreenColor];
    }else if ([model.STATUS isEqualToString:@"1"]) {
        _container1_label.text = @"正常签收";
        _container1_label.backgroundColor = [UIColor greenColor];
    }
//    else if ([model.STATUS isEqualToString:@"3"]) {
//        _container1_label.text = @"签收异常";
//    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
