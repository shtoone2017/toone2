//
//  SW_LSSJ_Cell1.m
//  toone
//
//  Created by 上海同望 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "SW_LSSJ_Cell1.h"
#import "SW_LSSJ_Model.h"

@interface SW_LSSJ_Cell1()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *clLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;


@end
@implementation SW_LSSJ_Cell1

-(void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(SW_LSSJ_Model *)model {
    _model = model;
    _name.text = model.banhezhanminchen;
    _clLabel.text = [NSString stringWithFormat:@"%@",model.glchangliang];
    _sjsLabel.text = [NSString stringWithFormat:@"%@",model.sjshui];
    _sjLabel.text = model.shijian;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
