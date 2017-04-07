
//
//  HNT_CLHS_ChatCell.m
//  toone
//
//  Created by 十国 on 2016/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_CLHS_ChatCell.h"
#import "BarChartViewController.h"
@interface LLQ_CLHS_ChatCell()
@property (weak, nonatomic) IBOutlet UIView *chartContrainer1;
@property (weak, nonatomic) IBOutlet UIView *chartContrainer2;
@property (weak, nonatomic) IBOutlet UILabel *sbLabel;


@end
@implementation LLQ_CLHS_ChatCell

-(void)setHsTitle:(NSString *)hsTitle{
    _hsTitle = hsTitle;
    self.sbLabel.text = hsTitle;
}
-(void)setDatas1:(NSArray *)datas1{
    BarChartViewController * chart;
    if (chart) {
        [chart.view removeFromSuperview];
        [chart removeFromParentViewController];
    }
    chart = [[BarChartViewController alloc] initWithArr:datas1];
    chart.view.frame = CGRectMake(0, 0, self.bounds.size.width, 360);
    [self.chartContrainer1 addSubview:chart.view];
}

-(void)setDatas2:(NSArray *)datas2{
    BarChartViewController * chart;
    if (chart) {
        [chart.view removeFromSuperview];
        [chart removeFromParentViewController];
    }
    chart = [[BarChartViewController alloc] initWithArr:datas2];
    chart.view.frame = CGRectMake(0, 0, self.bounds.size.width, 360);
    [self.chartContrainer2 addSubview:chart.view];
}
@end
