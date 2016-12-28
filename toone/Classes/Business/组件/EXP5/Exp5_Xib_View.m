//
//  Exp1_xib_view.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp5_Xib_View.h"

@implementation Exp5_Xib_View


-(void)awakeFromNib{
    [super awakeFromNib];
    self.okButton.layer.cornerRadius = 17;
    [_startTimeButton setTitle:[TimeTools time_3_monthsAgo] forState:UIControlStateNormal];
    _startTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _startTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    [_endTimeButton setTitle:[TimeTools currentTime] forState:UIControlStateNormal];
    _endTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.sbButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.sbButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);

}

@end
