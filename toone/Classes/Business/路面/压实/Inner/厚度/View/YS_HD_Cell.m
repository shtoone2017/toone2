//
//  YS_HD_Cell.m
//  toone
//
//  Created by 上海同望 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_HD_Cell.h"
#include "AAChartView.h"

@interface YS_HD_Cell ()
@property (weak, nonatomic) IBOutlet UIView *chartView;

@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartModel *aaChartModel;

@end
@implementation YS_HD_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setchart:(NSMutableArray *)name add:(NSMutableArray *)ay {
    self.aaChartView1 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 360)];
    self.aaChartView1.contentHeight = 360;
    [self.chartView addSubview:self.aaChartView1];
    self.aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeAreaspline)
    .titleSet(@"")//图表标题
    .subtitleSet(@"")
    .categoriesSet(name)//设置图表横轴的内容
    .yAxisTitleSet(@"")
    .seriesSet(ay);
//    .seriesSet(@[
//                 AAObject(AASeriesElement)
//                 .nameSet(@"")
//                 .dataSet(ay[i]),
//                 ]);
    self.aaChartModel.dataLabelEnabled = YES;
    [self.aaChartView1 aa_drawChartWithChartModel:_aaChartModel];
}
@end
