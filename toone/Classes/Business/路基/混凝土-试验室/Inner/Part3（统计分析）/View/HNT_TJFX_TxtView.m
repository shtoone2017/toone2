//
//  HNT_TJFX_TxtView.m
//  toone
//
//  Created by 十国 on 16/12/8.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_TJFX_TxtView.h"
#import "HNT_TJFX_Model.h"
@interface HNT_TJFX_TxtView()
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@end

@implementation HNT_TJFX_TxtView

-(void)setModel:(HNT_TJFX_Model *)model{
    self.label0.text = model.testName;
    self.label1.text = model.testCount;
    self.label2.text = model.qualifiedCount;
    self.label3.text = model.validCount;
    self.label4.text = model.notqualifiedCount;
    self.label5.text = model.qualifiedPer;
}
/*
 notqualifiedCount true string 不合格试验
 qualifiedCount true string 合格试验数
 qualifiedPer true string 合格率
 testCount true string 总共进行的试验数
 testName true string 试验名称
 testType true string 试验类型
 userGroupId true string 组织机构id
 validCount true string 有效的试验数
 */
@end
