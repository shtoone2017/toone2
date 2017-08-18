//
//  Exp1_xib_view.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp71_Xib_View.h"
@interface Exp71_Xib_View ()

@end
@implementation Exp71_Xib_View

-(void)awakeFromNib{
    [super awakeFromNib];
    self.okButton.layer.cornerRadius = 17;
    [_startTimeButton setTitle:[UserDefaultsSetting shareSetting].startTime forState:UIControlStateNormal];
    _startTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _startTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    [_endTimeButton setTitle:[UserDefaultsSetting shareSetting].endTime forState:UIControlStateNormal];
    _endTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.sbButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.sbButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.usePositionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.usePositionButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.earthworkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.earthworkButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.tjlxBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.tjlxBut.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.cclxBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.cclxBut.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
}


@end
