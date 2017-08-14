//
//  GCB_Table_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_Table_Cell.h"
#import "GCB_Model.h"

@interface GCB_Table_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *bxLabl;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;//设计
@property (weak, nonatomic) IBOutlet UILabel *ssjLabel;
@property (weak, nonatomic) IBOutlet UILabel *gcLabel;
@property (weak, nonatomic) IBOutlet UILabel *jdLabel;

@property (weak, nonatomic) IBOutlet UIView *jdView;


@end
@implementation GCB_Table_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(GCB_Model *)model {
    _model = model;
    _sjLabel.text = [NSString stringWithFormat:@"%@",model.shejifangliang];
    _ssjLabel.text = [NSString stringWithFormat:@"%@",model.shijifangliang];
    _gcLabel.text = model.projectName;
    _jdLabel.text = [NSString stringWithFormat:@"工程进度:%@%%",model.jindu];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
