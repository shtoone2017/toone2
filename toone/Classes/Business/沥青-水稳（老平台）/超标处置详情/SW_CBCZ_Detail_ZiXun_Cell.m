//
//  HNT_CBCZ_Detail_ShenPi_Cell.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SW_CBCZ_Detail_ZiXun_Cell.h"
#import "SW_CBCZ_Detail_swjg.h"
@interface SW_CBCZ_Detail_ZiXun_Cell()
@property (nonatomic,weak) IBOutlet UILabel  * lb1 ;// 审批人：
@property (nonatomic,weak) IBOutlet UILabel  * lb2 ;// 审核时间：
@property (nonatomic,weak) IBOutlet UILabel  * lb3 ;// 审批意见：

@end
@implementation SW_CBCZ_Detail_ZiXun_Cell


-(void)setModel:(SW_CBCZ_Detail_swjg *)model{
    _model = model;
    self.lb1.text = model.zxdw;
    self.lb2.text = model.zxdwdate;
    self.lb3.text = model.zxdwyijian;

}
@end
