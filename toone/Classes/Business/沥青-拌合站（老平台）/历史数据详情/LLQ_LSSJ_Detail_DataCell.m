
//
//  SW_CBCZ_Detail_DataCell.m
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_LSSJ_Detail_DataCell.h"
#import "LLQ_LSSJ_Detail_Data.h"
@interface LLQ_LSSJ_Detail_DataCell()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@end

@implementation LLQ_LSSJ_Detail_DataCell
/**
 mbpeibi true string 目标配比
 name true string 材料名称
 scpeibi true string 生产配比
 sgpeibi true string 施工配比
 wucha true string 误差
 yongliang true string 实际生产用量
 */
-(void)setModel:(LLQ_LSSJ_Detail_Data *)model{
        self.lb1.text = model.name;
        self.lb2.text = model.mbpeibi;
        self.lb3.text = model.scpeibi;
        self.lb4.text = model.sgpeibi;
        self.lb5.text = model.wucha;
        self.lb6.text = model.yongliang;
}

@end
