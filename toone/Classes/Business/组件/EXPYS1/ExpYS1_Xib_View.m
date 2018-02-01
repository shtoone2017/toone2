//
//  Exp1_xib_view.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "ExpYS1_Xib_View.h"

@implementation ExpYS1_Xib_View


-(void)awakeFromNib{
    [super awakeFromNib];
    self.okButton.layer.cornerRadius = 17;
//    [_startTimeButton setTitle:[UserDefaultsSetting shareSetting].startTime forState:UIControlStateNormal];
    _startTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _startTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
//    [_endTimeButton setTitle:[UserDefaultsSetting shareSetting].endTime forState:UIControlStateNormal];
    _endTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.sbButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.sbButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.mcButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.mcButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
}

@end
