//
//  EXPrimaryCell.m
//  toone
//
//  Created by shtoone on 16/12/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "EXPrimaryCell.h"
#import "EXPrimaryModel.h"
#import "disposal_C_Model.h"

@interface EXPrimaryCell ()
//字段名称
@property (weak, nonatomic) IBOutlet UILabel *sjf1Label;
@property (weak, nonatomic) IBOutlet UILabel *sjf2Label;
@property (weak, nonatomic) IBOutlet UILabel *sjg1Label;
@property (weak, nonatomic) IBOutlet UILabel *sjg2Label;
@property (weak, nonatomic) IBOutlet UILabel *sjg3Label;
@property (weak, nonatomic) IBOutlet UILabel *sjg4Label;
@property (weak, nonatomic) IBOutlet UILabel *sjg5Label;
@property (weak, nonatomic) IBOutlet UILabel *sjg6Label;
@property (weak, nonatomic) IBOutlet UILabel *sjg7Label;
@property (weak, nonatomic) IBOutlet UILabel *sjlqLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjtjjLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjysbLabel;
//数据显示
@property (weak, nonatomic) IBOutlet UILabel *wsjf1Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjf2Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjg1Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjg2Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjg3Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjg4Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjg5Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjg6Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjg7Label;
@property (weak, nonatomic) IBOutlet UILabel *wsjlqLabel;
@property (weak, nonatomic) IBOutlet UILabel *wsjtjjLabel;
@property (weak, nonatomic) IBOutlet UILabel *wsjysbLabel;

@property (weak, nonatomic) IBOutlet UILabel *shijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *bianhaoLabel;
//设备编号
@property (weak, nonatomic) IBOutlet UILabel *shebeibianhaoLabel;

@property (weak, nonatomic) IBOutlet UIView *conView;

//处置类型
@property (weak, nonatomic) IBOutlet UIView *chuzView;
@property (weak, nonatomic) IBOutlet UILabel *chuzLabel;

@end
@implementation EXPrimaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.chuzView.transform=CGAffineTransformMakeRotation(M_PI_4);
}

-(void)setDisModel:(disposal_C_Model *)disModel {
    _disModel = disModel;
    self.sjf1Label.text = [NSString stringWithFormat:@"%@:",disModel.sjf1];
    self.sjf2Label.text = [NSString stringWithFormat:@"%@:",disModel.sjf2];
    self.sjg1Label.text = [NSString stringWithFormat:@"%@:",disModel.sjg1];
    self.sjg2Label.text = [NSString stringWithFormat:@"%@:",disModel.sjg2];
    self.sjg3Label.text = [NSString stringWithFormat:@"%@:",disModel.sjg3];
    self.sjg4Label.text = [NSString stringWithFormat:@"%@:",disModel.sjg4];
    self.sjg5Label.text = [NSString stringWithFormat:@"%@:",disModel.sjg5];
    self.sjg6Label.text = [NSString stringWithFormat:@"%@:",disModel.sjg6];
    self.sjg7Label.text = [NSString stringWithFormat:@"%@:",disModel.sjg7];
    
    self.sjlqLabel.text = [NSString stringWithFormat:@"%@:",disModel.sjlq];
    self.sjtjjLabel.text = [NSString stringWithFormat:@"%@:",disModel.sjtjj];
    self.sjysbLabel.text = [NSString stringWithFormat:@"%@:",disModel.sjysb];
}

-(void)setEXPModel:(EXPrimaryModel *)EXPModel {
    _EXPModel = EXPModel;
//    数据显示
    self.wsjf1Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjf1];
    self.wsjf2Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjf2];
    self.wsjg1Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjg1];
    self.wsjg2Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjg2];
    self.wsjg3Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjg3];
    self.wsjg4Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjg4];
    self.wsjg5Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjg5];
    self.wsjg6Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjg6];
    self.wsjg7Label.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjg7];
    
    self.wsjlqLabel.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjlq];
    self.wsjtjjLabel.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjtjj];
    self.wsjysbLabel.text = [NSString stringWithFormat:@"%@%%",EXPModel.wsjysb];
    
    self.shijianLabel.text = EXPModel.shijian;
    self.bianhaoLabel.text = [NSString stringWithFormat:@"%@", EXPModel.bianhao];
    //存储设备编号
    if ([EXPModel.shebeibianhao boolValue]) {
        [UserDefaultsSetting shareSetting].CBshebeibianhao  = EXPModel.shebeibianhao;
    }else {
        [UserDefaultsSetting shareSetting].CBshebeibianhao = @"G345lq0101";
    }
    
    self.chuzView.hidden = NO;
    self.chuzLabel.textColor = [UIColor whiteColor];
    if(EqualToString(EXPModel.chuli, @"0")){
        self.chuzLabel.backgroundColor = [UIColor salmonColor];
        self.chuzLabel.text = @"未处置";
    }else if(EqualToString(EXPModel.chuli, @"1")){
        self.chuzLabel.backgroundColor = [UIColor grassColor];
        self.chuzLabel.text = @"已处置";
    }else {
        self.chuzLabel.backgroundColor = [UIColor grassColor];
        self.chuzLabel.text = @"已处置";
        self.chuzView.hidden = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
