//
//  GCB_JCH_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCH_Cell.h"
#import "AAChartView.h"

@interface GCB_JCH_Cell ()
@property (weak, nonatomic) IBOutlet UIView *chartView;

@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartModel *aaChartModel;
@end
@implementation GCB_JCH_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setchart:(NSMutableArray *)ax add:(NSMutableArray *)ay {
    self.aaChartView1 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 360)];
    self.aaChartView1.contentHeight = 360;
    [self.chartView addSubview:self.aaChartView1];
    self.aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(ay)
    .yAxisTitleSet(@"")
    .seriesSet(ax);
    self.aaChartModel.dataLabelEnabled = YES;
    [self.aaChartView1 aa_drawChartWithChartModel:_aaChartModel];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
