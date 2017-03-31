//
//  UIView+Frame.m
//  Demo-01
//
//  Created by 成研 on 16/11/9.
//  Copyright © 2016年 tw. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)



-(void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

-(CGFloat)y{
    return self.frame.origin.y;
}
@end
