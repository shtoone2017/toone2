//
//  LQ_ZCL_Cl_Cell.m
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_ZCL_Cl_Cell.h"
#import "BarChartViewController.h"
#import "LQ_ZCL_CL_Model.h"

@interface LQ_ZCL_Cl_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *jiduLabel;//可变名称
@property (weak, nonatomic) IBOutlet UIView *productionView;//产量图
@property (weak, nonatomic) IBOutlet UIView *bkView;



@end
@implementation LQ_ZCL_Cl_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)muLabel:(int)date {
    switch (date) {
        case 1:
            self.jiduLabel.text = @"季度";
            break;
        case 2:
            self.jiduLabel.text = @"月份";
            break;
        case 3:
            self.jiduLabel.text = @"周";
            break;
        case 4:
            self.jiduLabel.text = @"天";
            break;
        default:
            self.jiduLabel.text = @"季度";
            break;
    }
}

-(void)setDatas1:(NSArray *)datas1 {
    _datas1 = datas1;
    BarChartViewController * chart;
    if (chart) {
        [chart.view removeFromSuperview];
        [chart removeFromParentViewController];
    }
    chart = [[BarChartViewController alloc] initWithArr:datas1];
    chart.view.frame = CGRectMake(0, 50, self.bounds.size.width, 330);
    [self.productionView addSubview:chart.view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
