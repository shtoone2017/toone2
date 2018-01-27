//
//  SW_LSSJ_Detail_Chart2Cell.m
//  toone
//
//  Created by sg on 2017/3/24.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SW_LSSJ_Detail_Chart2Cell.h"
#import "SW_LSSJ_Detail_Chart.h"

@interface SW_LSSJ_Detail_Chart2Cell()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;

@end
@implementation SW_LSSJ_Detail_Chart2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lb1.adjustsFontSizeToFitWidth = YES;
    self.lb2.adjustsFontSizeToFitWidth = YES;
    self.lb3.adjustsFontSizeToFitWidth = YES;
    self.lb4.adjustsFontSizeToFitWidth = YES;
    self.lb5.adjustsFontSizeToFitWidth = YES;
}
-(void)setModel:(SW_LSSJ_Detail_Chart *)model{
    self.lb1.text = model.name;
    self.lb2.text = model.passper;
    self.lb3.text = model.standPassper;
    self.lb4.text = model.wcz;
    self.lb5.text = model.yjz;
    
}


@end
