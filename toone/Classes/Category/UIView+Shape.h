//
//  UIView+Shape.h
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shape)
+(void)view:(UIView *)v shapeWithStatus:(BOOL)Status withCornerRadius:(CGFloat)radius withBorderColor:(UIColor*)color withBorderWidth:(CGFloat)width;
+(void)views:(NSArray *)array shapeWithStatus:(BOOL)Status withCornerRadius:(CGFloat)radius withBorderColor:(UIColor*)color withBorderWidth:(CGFloat)width;
@end
