//
//  ProduQueryCell.m
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NQ_BHZ_SCCX_Inner_Cell.h"
#import "ProduQueryModel.h"

@interface NQ_BHZ_SCCX_Inner_Cell()
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *clwdLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjysbLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjlqLabel;

@end
@implementation NQ_BHZ_SCCX_Inner_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setProduQueryModel:(ProduQueryModel *)ProduQueryModel {
    _ProduQueryModel = ProduQueryModel;
    
    self.DateLabel.text = ProduQueryModel.shijian;
    self.clwdLabel.text = ProduQueryModel.clwd;
    self.sjysbLabel.text = ProduQueryModel.sjysb;
    self.sjlqLabel.text = ProduQueryModel.sjlq;
    
    //            保存编号
    [UserDefaultsSetting shareSetting].shebeibianhao = ProduQueryModel.shebeibianhao;
    [UserDefaultsSetting shareSetting].bianhao = ProduQueryModel.bianhao;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
