//
//  GCB_RWD_Detail_ZXCell.m
//  toone
//
//  Created by 上海同望 on 2017/8/20.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_RWD_Detail_ZXCell.h"
#import "GCB_RWD_DetailModel.h"

@interface GCB_RWD_Detail_ZXCell ()
@property (weak, nonatomic) IBOutlet UILabel *jhLabel;
@property (weak, nonatomic) IBOutlet UILabel *wcLabel;
@property (weak, nonatomic) IBOutlet UILabel *panLabel;
@property (weak, nonatomic) IBOutlet UILabel *jdLabel;
@property (weak, nonatomic) IBOutlet UILabel *jcLabel;//节超


@end
@implementation GCB_RWD_Detail_ZXCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(GCB_RWD_DetailModel *)model {
    _model = model;
    _jhLabel.text = model.jihuafangliang;
    _wcLabel.text = model.shijifangliang;
    _panLabel.text = model.shijipanshu;
    _jdLabel.text = model.baifenbi;
    _jcLabel.text = model.jiechao;
}
-(void)setColor:(UIColor *)color {
    _color = color;
    self.jhLabel.textColor = color;
    self.wcLabel.textColor = color;
    self.panLabel.textColor = color;
    self.jdLabel.textColor = color;
    self.jcLabel.textColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
