//
//  NQ_BHZ_SCCX_Inne_Cell.m
//  toone
//
//  Created by shtoone on 16/12/27.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NQ_BHZ_SCCX_Inne_Cell.h"
#import "NQ_BHZ_SCCX_InneModel.h"
#import "NQ_BHZ_SCCX_Inne_ moreModel.h"
#import "ProductionDetailsM.h"
#import "ProductionDetailsG.h"


@interface NQ_BHZ_SCCX_Inne_Cell ()
//上段
@property (weak, nonatomic) IBOutlet UILabel *clshijiLabel;//出料时间(名称)
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UILabel *ysbLabel;//油石比
@property (weak, nonatomic) IBOutlet UILabel *ysb;
@property (weak, nonatomic) IBOutlet UILabel *llysbLabel;//理论油石比
@property (weak, nonatomic) IBOutlet UILabel *llysb;
@property (weak, nonatomic) IBOutlet UILabel *wcysbLabel;//误差
@property (weak, nonatomic) IBOutlet UILabel *wcl;
@property (weak, nonatomic) IBOutlet UILabel *lqwdLabel;//沥青温度
@property (weak, nonatomic) IBOutlet UILabel *lqwd;
@property (weak, nonatomic) IBOutlet UILabel *slwdLabel;//石料温度
@property (weak, nonatomic) IBOutlet UILabel *slwd;
@property (weak, nonatomic) IBOutlet UILabel *clwdLabel;//出料温度
@property (weak, nonatomic) IBOutlet UILabel *clwd;

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
//实际比
@property (weak, nonatomic) IBOutlet UILabel *bfl1Label;
@property (weak, nonatomic) IBOutlet UILabel *bfl2Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl1Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl2Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl3Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl4Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl5Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl6Label;
@property (weak, nonatomic) IBOutlet UILabel *bsl7Label;
@property (weak, nonatomic) IBOutlet UILabel *blqLabel;
@property (weak, nonatomic) IBOutlet UILabel *btjjLabel;
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


@end
@implementation NQ_BHZ_SCCX_Inne_Cell

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

//上段
-(void)setModel:(NQ_BHZ_SCCX_InneModel *)model {//字段名称
    _model = model;
    self.clshijiLabel.text = [NSString stringWithFormat:@"%@:\t",model.shijian];
    self.ysbLabel.text = [NSString stringWithFormat:@"%@:\t",model.sjysb];
    self.llysbLabel.text = [NSString stringWithFormat:@"%@:\t",model.llysb];
    self.lqwdLabel.text = [NSString stringWithFormat:@"%@:\t",model.lqwd];
    self.slwdLabel.text = [NSString stringWithFormat:@"%@:\t",model.glwd];
    self.clwdLabel.text = [NSString stringWithFormat:@"%@:\t",model.clwd];
}
-(void)setModelM:(ProductionDetailsM *)modelM {//数据显示
    _modelM = modelM;
    self.sjLabel.text = modelM.shijian;
    self.ysb.text = modelM.sjysb;//实际油石比
    self.llysb.text = modelM.llysb;//理论油石比
    self.wcl.text = [NSString stringWithFormat:@"%@%%",modelM.wsjysb];//误差率
    self.lqwd.text = [NSString stringWithFormat:@"%@℃",modelM.lqwd];//沥青温度
    self.slwd.text = [NSString stringWithFormat:@"%@℃",modelM.glwd];//石料温度
    self.clwd.text = [NSString stringWithFormat:@"%@℃",modelM.clwd];//出料温度
}


#pragma mark - 核算表
-(void)setMoreModel:(NQ_BHZ_SCCX_Inne__moreModel *)moreModel {//数据显示
    _moreModel = moreModel;
    //实际量
    self.sjfl1Label.text = moreModel.sjf1;
    self.sjfl2Label.text = moreModel.sjf2;
    self.sjsl1Label.text = moreModel.sjg1;
    self.sjsl2Label.text = moreModel.sjg2;
    self.sjsl3Label.text = moreModel.sjg3;
    self.sjsl4Label.text = moreModel.sjg4;
    self.sjsl5Label.text = moreModel.sjg5;
    self.sjsl6Label.text = moreModel.sjg6;
    self.sjsl7Label.text = moreModel.sjg7;
    self.sjlqLable.text = moreModel.sjlq;
    self.sjtjjLable.text = moreModel.sjtjj;
    
//    实际比
    self.bfl1Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjf1];
    self.bfl2Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjf2];
    self.bsl1Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjg1];
    self.bsl2Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjg2];
    self.bsl3Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjg3];
    self.bsl4Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjg4];
    self.bsl5Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjg5];
    self.bsl6Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjg6];
    self.bsl7Label.text = [NSString stringWithFormat:@"%@%%",moreModel.persjg7];
    self.blqLabel.text =  [NSString stringWithFormat:@"%@%%",moreModel.persjlq];
    self.btjjLabel.text = [NSString stringWithFormat:@"%@%%",moreModel.persjtjj];
    
//    配比
    self.pbfl1Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llf1];
    self.pbfl2Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llf2];
    self.pbsl1Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llg1];
    self.pbsl2Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llg2];
    self.pbsl3Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llg3];
    self.pbsl4Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llg4];
    self.pbsl5Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llg5];
    self.pbsl6Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llg6];
    self.pbsl7Label.text =[NSString stringWithFormat:@"%@%%",moreModel.llg7];
    self.pblqLabel.text =[NSString stringWithFormat:@"%@%%",moreModel.lllq];
    self.pbtjjLabel.text =[NSString stringWithFormat:@"%@%%",moreModel.lltjj];
    
//    误差率
    self.wcfl1Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjf1];
    self.wcfl2Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjf2];
    self.wcsl1Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjg1];
    self.wcsl2Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjg2];
    self.wcsl3Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjg3];
    self.wcsl4Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjg4];
    self.wcsl5Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjg5];
    self.wcsl6Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjg6];
    self.wcsl7Label.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjg7];
    self.wclqLabel.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjlq];
    self.wctjjLable.text =[NSString stringWithFormat:@"%@%%",moreModel.wsjtjj];
    
}
-(void)setModelG:(ProductionDetailsG *)modelG {//字段名称
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
