//
//  UpButton.m
//  toone
//
//  Created by 上海同望 on 2017/10/9.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "UpButton.h"

@implementation UpButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2 + 10;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    //    newFrame.origin.y = self.imageView.frame.size.height + 5;
    newFrame.origin.y = self.height - newFrame.size.height - 10;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
