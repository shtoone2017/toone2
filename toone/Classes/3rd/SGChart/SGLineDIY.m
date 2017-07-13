//
//  SGLineDIY.m
//  lineText
//
//  Created by apple on 17/1/13.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SGLineDIY.h"
#import "Y.h"

@interface SGLineDIY()
@property (nonatomic,retain) Y*   y_left;
@property (nonatomic,retain) Y*   y_right;

@end
@implementation SGLineDIY

-(void)views{
    CGFloat x = distance;
    CGFloat y = titleTop_height;
    CGFloat w = super.frame.size.width-distance*2;
    CGFloat h = super.frame.size.height-y;
    super.sc = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y,w, h)];
    super.sc.showsHorizontalScrollIndicator = NO;
    [self addSubview:super.sc];
    
    _y_left = [[Y alloc] initWithFrame:CGRectMake(0, titleTop_height+titleHeader_height, distance, self.frame.size.height -titleX_height-titleHeader_height-titleTop_height)
                                 datas:super.datas
                              position:@"left"];
    [self addSubview:_y_left];

    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(x, y, 1, h-30)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line1];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(x, h-30+y, w, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line2];
    
    
    
    /**
     *  画箭头
     *
     *  @param x x值
     *  @param y y值
     *
     *  @return
     */
    [self drawWithPoint:CGPointMake(x, y)];

    
    /**
     *
     */
    [self show];
}
/**
 *  画y轴上方的箭头
 *
 *  @param point y轴顶点的坐标点
 */
-(void)drawWithPoint:(CGPoint)point{
    CGPoint p1 = CGPointMake(point.x, point.y-10);
    CGPoint p2 = CGPointMake(point.x-5, point.y+5);
    CGPoint p3 = CGPointMake(point.x+0.5, point.y);
    CGPoint p4 = CGPointMake(point.x+5, point.y+5);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    [path addLineToPoint:p3];
    [path addLineToPoint:p4];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer];
    layer.path = path.CGPath;
    
}
@end
