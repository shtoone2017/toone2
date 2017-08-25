//
//  GCB_JCH_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCH_Cell.h"
#import "BarChartViewController.h"
#import "DVBarChartView.h"

@interface GCB_JCH_Cell ()
@property (weak, nonatomic) IBOutlet UIView *chartView;


@end
@implementation GCB_JCH_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setchart:(NSMutableArray *)ax add:(NSMutableArray *)ay {
    DVBarChartView *chartView = [[DVBarChartView alloc] initWithFrame:CGRectMake(0,0,Screen_w,350)];
    chartView.yAxisViewWidth = 52;
    NSArray *sortArray = [[NSArray alloc] initWithObjects:@"6",@"5",@"13",@"20",@"28",@"1",nil];
    CGFloat maxValue = [[sortArray valueForKeyPath:@"@max.intValue"] integerValue];
    NSLog(@"%zd",maxValue);
    
    chartView.yAxisMaxValue = maxValue;
    chartView.numberOfYAxisElements = 5;
    chartView.xAxisTitleArray = ay;
    chartView.xValues = ax;
    //    chartView.barUserInteractionEnabled = NO;
    [chartView draw];
    [self.chartView addSubview:chartView];
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
