//
//  SW_CBCZ_Detail_Cell.m
//  toone
//
//  Created by sg on 2017/3/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_CBCZ_Detail_HeadCell.h"
@interface LLQ_CBCZ_Detail_HeadCell()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;


@end
@implementation LLQ_CBCZ_Detail_HeadCell

-(void)setModel:(LLQ_CBCZ_Detail_lqHead *)model{
    self.lb1.text = model.banhezhanminchen;
    self.lb2.text = model.caijishijian;
    self.lb3.text = model.shijian;
    self.lb4.text = model.changliang;
}

@end
