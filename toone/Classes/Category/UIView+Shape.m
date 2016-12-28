//
//  UIView+Shape.m
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "UIView+Shape.h"

@implementation UIView (Shape)
+(void)view:(UIView *)v shapeWithStatus:(BOOL)Status withCornerRadius:(CGFloat)radius withBorderColor:(UIColor*)color withBorderWidth:(CGFloat)width{
    v.layer.masksToBounds = Status;
    v.layer.cornerRadius = radius;
    v.layer.borderColor = color.CGColor;
    v.layer.borderWidth = width;
}
+(void)views:(NSArray *)array shapeWithStatus:(BOOL)Status withCornerRadius:(CGFloat)radius withBorderColor:(UIColor*)color withBorderWidth:(CGFloat)width{
    for (UIView * v in array) {
        v.layer.masksToBounds = Status;
        v.layer.cornerRadius = radius;
        v.layer.borderColor = color.CGColor;
        v.layer.borderWidth = width;
    }
}
@end
