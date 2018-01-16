//
//  LQ_CLHS_Cell.m
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_CLHS_Cell.h"
#import "LQ_CLHS_ModelG.h"
#import "LQ_CLHS_DataModel.h"
#import "AAChartView.h"

@interface LQ_CLHS_Cell ()
            //核算表
//材料名称
@property (weak, nonatomic) IBOutlet UILabel *fl1Label;
@property (weak, nonatomic) IBOutlet UILabel *fl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sl1Label;
@property (weak, nonatomic) IBOutlet UILabel *sl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sl3Label;
@property (weak, nonatomic) IBOutlet UILabel *sl4Label;
@property (weak, nonatomic) IBOutlet UILabel *sl5Label;
@property (weak, nonatomic) IBOutlet UILabel *sl6Label;
@property (weak, nonatomic) IBOutlet UILabel *sl7Label;
@property (weak, nonatomic) IBOutlet UILabel *lqLabel;
@property (weak, nonatomic) IBOutlet UILabel *tjjLable;
//实际量
@property (weak, nonatomic) IBOutlet UILabel *sjfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *sjfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *sjsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *sjlqLable;
@property (weak, nonatomic) IBOutlet UILabel *sjtjjLable;
//配比
@property (weak, nonatomic) IBOutlet UILabel *pbfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *pbfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *pbsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *pblqLabel;
@property (weak, nonatomic) IBOutlet UILabel *pbtjjLabel;
//误差率
@property (weak, nonatomic) IBOutlet UILabel *wcfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *wcfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *wcsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *wclqLabel;
@property (weak, nonatomic) IBOutlet UILabel *wctjjLable;
//背景View
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *View2;
@property (weak, nonatomic) IBOutlet UIView *View3;
@property (weak, nonatomic) IBOutlet UIView *View4;
@property (weak, nonatomic) IBOutlet UIView *View5;
@property (weak, nonatomic) IBOutlet UIView *View6;
@property (weak, nonatomic) IBOutlet UIView *View7;
@property (weak, nonatomic) IBOutlet UIView *View8;
@property (weak, nonatomic) IBOutlet UIView *View9;
@property (weak, nonatomic) IBOutlet UIView *View10;
@property (weak, nonatomic) IBOutlet UIView *View11;

@property (weak, nonatomic) IBOutlet UIView *chartContrainer1;
@property (weak, nonatomic) IBOutlet UIView *chartContrainer2;

@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartView  *aaChartView2;
@property (nonatomic, strong) AAChartModel *aaChartModel;
@end
@implementation LQ_CLHS_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.View1.backgroundColor = Color1;
    self.View3.backgroundColor = Color1;
    self.View5.backgroundColor = Color1;
    self.View7.backgroundColor = Color1;
    self.View9.backgroundColor = Color1;
    self.View11.backgroundColor = Color1;
    
    self.View2.backgroundColor = Color2;
    self.View4.backgroundColor = Color2;
    self.View6.backgroundColor = Color2;
    self.View8.backgroundColor = Color2;
    self.View10.backgroundColor = Color2;
}


//名称
-(void)setModelG:(LQ_CLHS_ModelG *)modelG {
    _modelG = modelG;
    self.fl1Label.text = modelG.sjf1;
    self.fl2Label.text = modelG.sjf2;
    self.sl1Label.text = modelG.sjg1;
    self.sl2Label.text = modelG.sjg2;
    self.sl3Label.text = modelG.sjg3;
    self.sl4Label.text = modelG.sjg4;
    self.sl5Label.text = modelG.sjg5;
    self.sl6Label.text = modelG.sjg6;
    self.sl7Label.text = modelG.sjg7;
    self.lqLabel.text = modelG.sjlq;
    self.tjjLable.text = modelG.sjtjj;
}
//数据
-(void)setDataModel:(LQ_CLHS_DataModel *)dataModel {
    _dataModel = dataModel;
    //实际量
    self.sjfl1Label.text = dataModel.sjf1;
    self.sjfl2Label.text = dataModel.sjf2;
    self.sjsl1Label.text = dataModel.sjg1;
    self.sjsl2Label.text = dataModel.sjg2;
    self.sjsl3Label.text = dataModel.sjg3;
    self.sjsl4Label.text = dataModel.sjg4;
    self.sjsl5Label.text = dataModel.sjg5;
    self.sjsl6Label.text = dataModel.sjg6;
    self.sjsl7Label.text = dataModel.sjg7;
    self.sjlqLable.text = dataModel.sjlq;
    self.sjtjjLable.text = dataModel.sjtjj;
    //    配比
    self.pbfl1Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llf1];
    self.pbfl2Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llf2];
    self.pbsl1Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llg1];
    self.pbsl2Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llg2];
    self.pbsl3Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llg3];
    self.pbsl4Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llg4];
    self.pbsl5Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llg5];
    self.pbsl6Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llg6];
    self.pbsl7Label.text =[NSString stringWithFormat:@"%@%%",dataModel.llg7];
    self.pblqLabel.text =[NSString stringWithFormat:@"%@%%",dataModel.lllq];
    self.pbtjjLabel.text =[NSString stringWithFormat:@"%@%%",dataModel.lltjj];
    //    误差率
    self.wcfl1Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjf1];
    self.wcfl2Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjf2];
    self.wcsl1Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjg1];
    self.wcsl2Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjg2];
    self.wcsl3Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjg3];
    self.wcsl4Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjg4];
    self.wcsl5Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjg5];
    self.wcsl6Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjg6];
    self.wcsl7Label.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjg7];
    self.wclqLabel.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjlq];
    self.wctjjLable.text =[NSString stringWithFormat:@"%@%%",dataModel.wsjtjj];
}

-(void)setDatas1:(NSArray *)datas1{
    self.aaChartView1 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 50, self.bounds.size.width, 360)];
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
    self.aaChartView2 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 50, self.bounds.size.width, 360)];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
