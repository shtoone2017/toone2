//
//  GCB_RWD_Detail_ZYCell.m
//  toone
//
//  Created by 上海同望 on 2017/8/20.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_RWD_Detail_ZYCell.h"
#import "GCB_RWD_DetailModel.h"

@interface  GCB_RWD_Detail_ZYCell ()
@property (weak, nonatomic) IBOutlet UILabel *yrwdLabel;
@property (weak, nonatomic) IBOutlet UILabel *rwdhLabel;
@property (weak, nonatomic) IBOutlet UILabel *flLabel;
@property (weak, nonatomic) IBOutlet UILabel *cztimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *czzLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *zrtypeLabel;

@end
@implementation GCB_RWD_Detail_ZYCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(GCB_RWD_DetailModel *)model {
    _model = model;
    _yrwdLabel.text = model.renwuno1;
    _rwdhLabel.text = model.renwuno2;
    _flLabel.text = model.fangliang;
    _cztimeLabel.text = model.shijian;
    _czzLabel.text = model.caozuozhe;
    if ([model.type isEqualToString:@"0"]) {
        _typeLabel.text = @"补方";
    }if ([model.type isEqualToString:@"1"]) {
        _typeLabel.text = @"方量转移";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
