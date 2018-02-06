//
//  SW_CBCZ_Detail_Cell.m
//  toone
//
//  Created by sg on 2017/3/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//
#import "LLQ_LSSJ_Detail_HeadCell.h"
#import "LLQ_LSSJ_Detail_Head.h"
@interface LLQ_LSSJ_Detail_HeadCell()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;


@end
@implementation LLQ_LSSJ_Detail_HeadCell

-(void)setModel:(LLQ_LSSJ_Detail_Head *)model{
    self.lb1.text = model.bhjName;
    self.lb2.text = model.caijishijian;
    self.lb3.text = model.chuliaoshijian;
    self.lb4.text = model.cl;
}

-(void)setModel1:(LLQ_LSSJ_Detail_Head *)model1 {
    _model1 = model1;
    self.lb1.text = model1.banhezhanminchen;
    self.lb2.text = model1.caijishijian;
    self.lb3.text = model1.shijian;
    self.lb4.text = model1.changliang;
}

@end
