
//
//  LQ_ZCL_CL1_Cell.m
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_ZCL_CL1_Cell.h"
#import "LQ_ZCL_CL_Model.h"

@interface LQ_ZCL_CL1_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UILabel *clLabel;
@property (weak, nonatomic) IBOutlet UIView *bkView;

@end
@implementation LQ_ZCL_CL1_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)model:(LQ_ZCL_CL_Model *)model withIndex:(long)index {
    self.sjLabel.text = [NSString stringWithFormat:@"%@-%@",model.xa,model.xb];
    self.clLabel.text = model.changliang;
    self.bkView.backgroundColor = index%2==0 ? Color1: Color2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
