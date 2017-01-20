//
//  SGBar.m
//  CAlayer
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGBar.h"
#import "SGConst.h"

@implementation SGBar

-(CGFloat)totalTime{
    if (!_totalTime) {
        _totalTime = BAR_TOTALTIME;
    }
    return _totalTime;
}
-(instancetype)initWithFrame:(CGRect)frame
                     percent:(CGFloat)percent
                       color:(UIColor*)color{
    self = [super initWithFrame:frame];
    if (self) {
        [self layer:percent withColor:color];
    }
    return self;
}
/**
 *  <#Description#>
 *
 *  @param percent 根据百分比参数计算bar的高度
 *  @param color   layer的颜色
 */
-(void)layer:(CGFloat)percent withColor:(UIColor*)color{
    
    //起点
    CGPoint startPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    
    //终点
    CGPoint   endPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height*(1-percent));
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];

    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.lineWidth = self.frame.size.width;
    [self.layer addSublayer:layer];
    layer.path = path.CGPath;
    layer.strokeColor = color.CGColor ? :[UIColor redColor].CGColor;
    
    
    CABasicAnimation *fillAnimation = [self animation:percent];
    [layer addAnimation:fillAnimation forKey:nil];
}

#pragma mark - 动画
/**
 *  填充动画过程
 *
 *  @return CABasicAnimation
 */

- (CABasicAnimation *)animation:(CGFloat)percent{
    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration       = BAR_TOTALTIME*percent;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fillAnimation.fromValue      = @0.0;
    fillAnimation.toValue        = @1.0;
    fillAnimation.autoreverses   = NO;
    return fillAnimation;
}

@end
