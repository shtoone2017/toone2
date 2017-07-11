//
//  HNT_bhzCell.m
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_SYS_Cell.h"
#import "LLQ_SYS_Model.h"

@interface LLQ_SYS_Cell()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *departNameLabel;//工程名称

//@property (weak, nonatomic) IBOutlet UILabel *countmxe;//马
@property (weak, nonatomic) IBOutlet UILabel *countrhd;//软
@property (weak, nonatomic) IBOutlet UILabel *countyd;//延度
@property (weak, nonatomic) IBOutlet UILabel *countzrd;//针入



@end
@implementation LLQ_SYS_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code  snowColor
    
}

-(void)setModel:(LLQ_SYS_Model *)model{
    self.departNameLabel.text = model.banhezhanminchen;
//    self.countmxe.text = model.countmxe;
    self.countrhd.text = model.countrhd;
    self.countyd.text = model.countyd;
    self.countzrd.text = model.countzrd;
}
@end
