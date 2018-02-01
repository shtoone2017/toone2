//
//  YSRoadView.m
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSRoadView.h"

#define StartPoint_x self.frame.origin.x +100
#define StartPoint_y self.frame.origin.y+self.frame.size.height -100
@interface YSRoadView ()<UIGestureRecognizerDelegate>
{
    UIBezierPath *path;
    UIBezierPath *path1;
}
@end

@implementation YSRoadView
+ (Class)layerClass
{
    return  [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if(_leftData&&_leftData.count>0 && _rightData&&_rightData.count > 0)
    {
        [self creteBezierPathWithData:_leftData];
        [self creteBezierPathWithData:_rightData];
    }
    //    [self drawBianshu];
}


- (void)creteBezierPathWithData:(NSArray *)data
{
    path = [UIBezierPath bezierPath];
    if (data && data.count >0)
    {
        YS_ZhuangHao_Model * model = data.firstObject;
        [path moveToPoint:CGPointMake(model.Stake_dx*YS_Scale+StartPoint_x, model.Stake_dy*YS_Scale+StartPoint_y)];
        for (int i = 0; i<data.count; i++)
        {
            YS_ZhuangHao_Model * model = [data objectAtIndex:i];
            [path addLineToPoint:CGPointMake(model.Stake_dx*YS_Scale+StartPoint_x,model.Stake_dy*YS_Scale+StartPoint_y)];
            
            CATextLayer *textLayer = [CATextLayer layer];
            textLayer.string = model.stake_name;
            textLayer.frame = CGRectMake(model.Stake_dx*YS_Scale+StartPoint_x,model.Stake_dy*YS_Scale+StartPoint_y, 50, 50);
            textLayer.fontSize = 10.0f;
            textLayer.wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
            textLayer.contentsScale = [UIScreen mainScreen].scale;//解决文字模糊 以Retina方式来渲染，防止画出来的文本像素化
            textLayer.foregroundColor =[UIColor blackColor].CGColor;
            [self.layer addSublayer:textLayer];
            
        }
    }
    CAShapeLayer *roadLayer = [CAShapeLayer layer];
    roadLayer.frame =  self.bounds;
    [roadLayer setFillColor:[UIColor clearColor].CGColor];
    [roadLayer setStrokeColor:[UIColor blackColor].CGColor];
    [roadLayer setLineWidth:1.0f];
    [roadLayer setLineJoin:kCALineJoinMiter];
    roadLayer.path = path.CGPath;
    [self.layer addSublayer:roadLayer];
}

- (void)drawBianshu
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if(_bianshuData && _bianshuData.count>0)
    {
        for (int i = 0; i < _bianshuData.count; i++)
        {
            YS_BianshuModel *model = _bianshuData[i];
            CGContextAddEllipseInRect(ctx, CGRectMake(model.lng*YS_Scale+StartPoint_x,model.lat*YS_Scale+StartPoint_y, 1, 1));
        }
    }
    CGContextSetStrokeColorWithColor(ctx,[UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 1);
    CGContextStrokePath(ctx);
}


//- (void)setLeftData:(NSArray *)leftData
//{
//    _leftData = leftData;
//
//}
//
//- (void)setRightData:(NSArray *)rightData
//{
//    _rightData = rightData;
//    [self setNeedsDisplay];
//}
//
//- (void)setBianshuData:(NSArray *)bianshuData
//{
//    _bianshuData = bianshuData;
//
//}


@end
