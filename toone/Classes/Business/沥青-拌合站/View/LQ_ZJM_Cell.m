//
//  LQ_ZJM_Cell.m
//  toone
//
//  Created by shtoone on 16/12/30.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LQ_ZJM_Cell.h"
#import "LQ_CellModel.h"
#import "LQ_Model.h"

@interface LQ_ZJM_Cell ()
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UILabel *deptName;

@property (weak, nonatomic) IBOutlet UILabel *bhzCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bhjCountLabel;

//名称
@property (weak, nonatomic) IBOutlet UILabel *changliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *panshuLabel;

//标段
@property (weak, nonatomic) IBOutlet UILabel *banhezhanminchenCLabel;
@property (weak, nonatomic) IBOutlet UILabel *banhezhanminchenZLabel;
@property (weak, nonatomic) IBOutlet UILabel *banhezhanminchenGLabel;
@property (weak, nonatomic) IBOutlet UILabel *banhezhanminchenLabel;

//等级
@property (weak, nonatomic) IBOutlet UILabel *dengCLabel;
@property (weak, nonatomic) IBOutlet UILabel *dengZLabel;
@property (weak, nonatomic) IBOutlet UILabel *dengGLabel;
@property (weak, nonatomic) IBOutlet UILabel *dengLabel;

//超标盘数
@property (weak, nonatomic) IBOutlet UILabel *cbpsCLabel;
@property (weak, nonatomic) IBOutlet UILabel *cbpsZLabel;
@property (weak, nonatomic) IBOutlet UILabel *cbpsGLabel;
@property (weak, nonatomic) IBOutlet UILabel *cbpsLabel;

//超标率
@property (weak, nonatomic) IBOutlet UILabel *cblvCLabel;
@property (weak, nonatomic) IBOutlet UILabel *cblvZLabel;
@property (weak, nonatomic) IBOutlet UILabel *cblvGLabel;
@property (weak, nonatomic) IBOutlet UILabel *cblvLabel;

//处置率
@property (weak, nonatomic) IBOutlet UILabel *reallvCLabel;
@property (weak, nonatomic) IBOutlet UILabel *reallvZLabel;
@property (weak, nonatomic) IBOutlet UILabel *reallvGLabel;
@property (weak, nonatomic) IBOutlet UILabel *reallvLabel;

@end
@implementation LQ_ZJM_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bkView.backgroundColor = [UIColor whiteColor];
    
    self.bhzCountLabel.layer.masksToBounds = YES;
    self.bhjCountLabel.layer.masksToBounds = YES;
    self.bhzCountLabel.layer.cornerRadius = 10;
    self.bhjCountLabel.layer.cornerRadius = 10;
    self.bhzCountLabel.backgroundColor = [UIColor whiteColor];
    self.bhjCountLabel.backgroundColor = [UIColor whiteColor];
}

-(void)setCellModel:(LQ_CellModel *)cellModel {
    _cellModel = cellModel;

    self.deptName.text = cellModel.totalModel.deptName;
    
    
    self.changliangLabel.text = cellModel.chujiModel.changliang;
    self.panshuLabel.text = cellModel.chujiModel.panshu;
    self.bhzCountLabel.text = cellModel.chujiModel.bhzCount;
    self.bhjCountLabel.text = cellModel.chujiModel.bhjCount;
    
    //初级
    self.banhezhanminchenCLabel.text = cellModel.chujiModel.banhezhanminchen;
    self.dengCLabel.text = cellModel.chujiModel.dengji;
    self.cbpsCLabel.text = cellModel.chujiModel.cbps;
    self.cblvCLabel.text = cellModel.chujiModel.cblv;
    self.reallvCLabel.text = [NSString stringWithFormat:@"%@%%",cellModel.chujiModel.reallv];
    
    //中级
    self.banhezhanminchenZLabel.text = cellModel.zhongjiModel.banhezhanminchen;
    self.dengZLabel.text = cellModel.zhongjiModel.dengji;
    self.cbpsZLabel.text = cellModel.zhongjiModel.cbps;
    self.cblvZLabel.text = cellModel.zhongjiModel.cblv;
    self.reallvZLabel.text = [NSString stringWithFormat:@"%@%%",cellModel.zhongjiModel.reallv];
    
    //高级
    self.banhezhanminchenGLabel.text = cellModel.gaojiModel.banhezhanminchen;
    self.dengGLabel.text = cellModel.gaojiModel.dengji;
    self.cbpsGLabel.text = cellModel.gaojiModel.cbps;
    self.cblvGLabel.text = cellModel.gaojiModel.cblv;
    self.reallvGLabel.text = [NSString stringWithFormat:@"%@%%",cellModel.gaojiModel.reallv];
    
    //总
    self.banhezhanminchenLabel.text = cellModel.totalModel.banhezhanminchen;
    self.dengLabel.text = cellModel.totalModel.dengji;
    self.cbpsLabel.text = cellModel.totalModel.cbps;
    self.cblvLabel.text = cellModel.totalModel.cblv;
    self.reallvLabel.text = [NSString stringWithFormat:@"%@%%",cellModel.totalModel.reallv];
    
    self.banhezhanminchenLabel.lineBreakMode  =NSLineBreakByTruncatingTail;
    self.banhezhanminchenCLabel.lineBreakMode =NSLineBreakByTruncatingMiddle;
    self.banhezhanminchenZLabel.lineBreakMode =NSLineBreakByTruncatingMiddle;
    self.banhezhanminchenGLabel.lineBreakMode =NSLineBreakByTruncatingMiddle;

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
