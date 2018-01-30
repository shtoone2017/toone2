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

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
//    self.backgroundColor = [UIColor yellowColor];
    [self creteBezierPathWithData:_leftData];
    [self creteBezierPathWithData:_rightData];
}

- (void)creteBezierPathWithData:(NSArray *)data
{
    UIColor *color = [UIColor blackColor];
    [color set]; //设置线条颜色
    path = [UIBezierPath bezierPath];
    path.lineWidth = 1.5;
    path.lineCapStyle = kCGLineCapButt; //线条拐角
    path.lineJoinStyle = kCGLineCapSquare; //终点处理
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
    [path stroke];
}

- (void)setLeftData:(NSArray *)leftData
{
    _leftData = leftData;
    [self setNeedsDisplay];
}

- (void)setRightData:(NSArray *)rightData
{
    _rightData = rightData;
    [self setNeedsDisplay];

}

//+ (Class)layerClass {
//    return [CATiledLayer class];
//}

@end
