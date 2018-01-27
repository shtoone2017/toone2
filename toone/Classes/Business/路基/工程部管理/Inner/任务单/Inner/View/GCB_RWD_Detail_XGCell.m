//
//  GCB_RWD_Detail_XGCell.m
//  toone
//
//  Created by 上海同望 on 2017/8/20.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_RWD_Detail_XGCell.h"
#import "GCB_RWD_DetailModel.h"

@interface GCB_RWD_Detail_XGCell ()
@property (weak, nonatomic) IBOutlet UILabel *rwdbhLabel;
@property (weak, nonatomic) IBOutlet UILabel *czrLabel;
@property (weak, nonatomic) IBOutlet UILabel *cztimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *czfsLabel;


@end
@implementation GCB_RWD_Detail_XGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(GCB_RWD_DetailModel *)model {
    _model = model;
    _rwdbhLabel.text = model.renwuno;
    _czrLabel.text = model.xiugairen;
    _cztimeLabel.text = model.xiugaishijian;
    if ([model.xgtype isEqualToString:@"0"]) {
        _czfsLabel.text = @"新增";
    }else if ([model.xgtype isEqualToString:@"1"]) {
        _czfsLabel.text = @"修改";
    }else if ([model.xgtype isEqualToString:@"2"]) {
        _czfsLabel.text = @"提交";
    }else if ([model.xgtype isEqualToString:@"3"]) {
        _czfsLabel.text = @"删除";
    }else if ([model.xgtype isEqualToString:@"4"]) {
        _czfsLabel.text = @"结束";
    }
}

-(void)setColor:(UIColor *)color {
    _color = color;
    self.rwdbhLabel.textColor = color;
    self.czrLabel.textColor = color;
    self.cztimeLabel.textColor = color;
    self.czfsLabel.textColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
