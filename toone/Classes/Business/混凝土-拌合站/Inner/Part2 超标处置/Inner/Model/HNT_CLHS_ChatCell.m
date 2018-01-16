
//
//  HNT_CLHS_ChatCell.m
//  toone
//
//  Created by 十国 on 2016/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_CLHS_ChatCell.h"
#import "AAChartView.h"
@interface HNT_CLHS_ChatCell()
@property (weak, nonatomic) IBOutlet UIView *chartContrainer1;
@property (weak, nonatomic) IBOutlet UIView *chartContrainer2;

@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartView  *aaChartView2;
@property (nonatomic, strong) AAChartModel *aaChartModel;
@end
@implementation HNT_CLHS_ChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDatas1:(NSArray *)datas1{
    self.aaChartView1 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 360)];
    self.aaChartView1.contentHeight = 360;
    [self.chartContrainer1 addSubview:self.aaChartView1];
    self.aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(@[@""])
    .yAxisTitleSet(@"")
    .seriesSet(datas1);
    self.aaChartModel.dataLabelEnabled = YES;
    [self.aaChartView1 aa_drawChartWithChartModel:_aaChartModel];
}

-(void)setDatas2:(NSArray *)datas2{
    self.aaChartView2 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 360)];
    self.aaChartView2.contentHeight = 360;
    [self.chartContrainer2 addSubview:self.aaChartView2];
    self.aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//图表的类型
    .titleSet(@"")//图表标题
    .subtitleSet(@"")//图表副标题
    .categoriesSet(@[@""])//设置图表横轴的内容
    .yAxisTitleSet(@"")//设置图表 y 轴的单位
    .seriesSet(datas2);
    self.aaChartModel.dataLabelEnabled = YES;
    [self.aaChartView2 aa_drawChartWithChartModel:_aaChartModel];
}
@end
