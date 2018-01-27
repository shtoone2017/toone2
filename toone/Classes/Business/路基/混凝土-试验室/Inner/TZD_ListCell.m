//
//  TZD_ListCell.m
//  toone
//
//  Created by 景晓峰 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TZD_ListCell.h"

@implementation TZD_ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)btnAction:(UIButton *)sender
{
    if (_block)
    {
        _block(sender.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
