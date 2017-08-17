//
//  GCB_JCH_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCH_Cell.h"
#import "BarChartViewController.h"

@interface GCB_JCH_Cell ()
@property (weak, nonatomic) IBOutlet UIView *chartView;


@end
@implementation GCB_JCH_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDatas:(NSArray *)datas {
    _datas = datas;
    BarChartViewController * chart;
    if (chart) {
        [chart.view removeFromSuperview];
        [chart removeFromParentViewController];
    }
    chart = [[BarChartViewController alloc] initWithArr:datas];
    chart.view.frame = CGRectMake(0, 0, self.bounds.size.width, 365);
    [self.chartView addSubview:chart.view];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
