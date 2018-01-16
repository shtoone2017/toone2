//
//  LQ_ZCL_Cl_Cell.m
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_ZCL_Cl_Cell.h"
#import "AAChartView.h"
#import "LQ_ZCL_CL_Model.h"

@interface LQ_ZCL_Cl_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *jiduLabel;//可变名称
@property (weak, nonatomic) IBOutlet UIView *productionView;//产量图
@property (weak, nonatomic) IBOutlet UIView *bkView;

@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartView  *aaChartView2;
@property (nonatomic, strong) AAChartModel *aaChartModel;

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
    self.aaChartView1 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 360)];
    self.aaChartView1.contentHeight = 360;
    [self.productionView addSubview:self.aaChartView1];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
