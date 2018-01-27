//
//  SW_CBCZ_Detail_Cell.m
//  toone
//
//  Created by sg on 2017/3/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SW_CBCZ_Detail_HeadCell.h"
@interface SW_CBCZ_Detail_HeadCell()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;


@end
@implementation SW_CBCZ_Detail_HeadCell

-(void)setModel:(SW_CBCZ_Detail_swHead *)model{
    self.lb1.text = model.baocunshijian;
    self.lb2.text = model.bhjName;
    self.lb3.text = model.chuliaoshijian;
    self.lb4.text = model.zcl;
}

@end
