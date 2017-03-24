//
//  HNT_CBCZ_Detail_ShenPi_Cell.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_CBCZ_Detail_ShenPi_Cell.h"
#import "LLQ_CBCZ_Detail_lqjg.h"
@interface LLQ_CBCZ_Detail_ShenPi_Cell()
@property (nonatomic,weak) IBOutlet UILabel  * lb1 ;// 审批人：
@property (nonatomic,weak) IBOutlet UILabel  * lb2 ;// 审核时间：
@property (nonatomic,weak) IBOutlet UILabel  * lb3 ;// 审批意见：

@end
@implementation LLQ_CBCZ_Detail_ShenPi_Cell


-(void)setModel:(LLQ_CBCZ_Detail_lqjg *)model{
    _model = model;
    self.lb1.text = model.yezhuren;
    self.lb2.text = model.confirmdate;
    self.lb3.text = model.yezhuyijian;
}
@end
