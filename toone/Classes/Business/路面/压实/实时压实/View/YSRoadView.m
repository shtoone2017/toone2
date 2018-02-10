//
//  YSRoadView.m
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSRoadView.h"



@interface YSRoadView ()<UIGestureRecognizerDelegate>

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

- (void)creteBezierPathWithData:(NSArray *)data
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if (data && data.count >0)
    {
        YS_ZhuangHao_Model * model = data.firstObject;
        [path moveToPoint:CGPointMake(Formula(model.Stake_dx), -(Formula(model.Stake_dy)))];
        for (int i = 0; i<data.count; i++)
        {
            YS_ZhuangHao_Model * model = [data objectAtIndex:i];
            [path addLineToPoint:CGPointMake(Formula(model.Stake_dx),-(Formula(model.Stake_dy)))];
            
//            CATextLayer *textLayer = [CATextLayer layer];
//            textLayer.string = model.stake_name;
//            textLayer.frame = CGRectMake(model.Stake_dx*YS_Scale+StartPoint_x,-(model.Stake_dy*YS_Scale+StartPoint_y), 50, 50);
//            textLayer.fontSize = 10.0f;
//            textLayer.wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
//            textLayer.contentsScale = [UIScreen mainScreen].scale;//解决文字模糊 以Retina方式来渲染，防止画出来的文本像素化
//            textLayer.foregroundColor =[UIColor blackColor].CGColor;
//            [self.layer addSublayer:textLayer];
            
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

    if(_bianshuData && _bianshuData.count>0)
    {
        for (int i = 0; i < _bianshuData.count; i++)
        {
            YS_BianshuModel *model = _bianshuData[i];
            CAShapeLayer *roadLayer = [CAShapeLayer layer];
            [roadLayer setFillColor:[UIColor blackColor].CGColor];
//            [roadLayer setStrokeColor:[UIColor blackColor].CGColor];
            [roadLayer setLineWidth:1.0f];
            [roadLayer setLineJoin:kCALineJoinMiter];
            CGRect frame = CGRectMake(Formula(model.lng),-(Formula(model.lat)), 1, 1);
            UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
            roadLayer.path = circlePath.CGPath;
            [self.layer addSublayer:roadLayer];
            
        }
    }
    
    [self setNeedsDisplay];
}


- (void)setLeftData:(NSArray *)leftData
{
    _leftData = leftData;
    [self creteBezierPathWithData:_leftData];
    [self setNeedsDisplay];
}

- (void)setRightData:(NSArray *)rightData
{
    _rightData = rightData;
    [self creteBezierPathWithData:_rightData];
    [self setNeedsDisplay];
}


- (void)setBianshuData:(NSArray *)bianshuData
{
    _bianshuData = bianshuData;
    [self drawBianshu];
}


@end
