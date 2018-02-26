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

- (void)drawRoadData:(NSArray *)data
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if (data && data.count >0)
    {
        YS_ZhuangHao_Model * model = data.firstObject;
        [path moveToPoint:CGPointMake(Formula_x(model.Stake_dx,_offsetNum_x), (Formula_y(model.Stake_dy,_offsetNum_y)))];
        for (int i = 0; i<data.count; i++)
        {
            YS_ZhuangHao_Model * model = [data objectAtIndex:i];
            [path addLineToPoint:CGPointMake(Formula_x(model.Stake_dx,_offsetNum_x),(Formula_y(model.Stake_dy,_offsetNum_y)))];
            
            CATextLayer *textLayer = [CATextLayer layer];
            textLayer.string = model.stake_name;
            textLayer.frame = CGRectMake(Formula_x(model.Stake_dx,_offsetNum_x),(Formula_y(model.Stake_dy,_offsetNum_y)), 50, 50);
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

    if(_bianshuData && _bianshuData.count>0)
    {
        for (int i = 0; i < _bianshuData.count; i++)
        {
            YS_BianshuModel *model = _bianshuData[i];
            CAShapeLayer *roadLayer = [CAShapeLayer layer];
            [roadLayer setFillColor:[self getPointColorBianshu:model.grid_count]];
//            [roadLayer setStrokeColor:[UIColor blackColor].CGColor];
            [roadLayer setLineWidth:1.0f];
            [roadLayer setLineJoin:kCALineJoinMiter];
            CGRect frame = CGRectMake(Formula_x(model.lng,_offsetNum_x),(Formula_y(model.lat,_offsetNum_y)), 2, 2);
            UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
            roadLayer.path = circlePath.CGPath;
            [self.layer addSublayer:roadLayer];
            
        }
    }
    
    [self setNeedsDisplay];
}

- (CGColorRef)getPointColorBianshu:(NSInteger)a
{
    if (_type == 2)
    {
        //压实度
        if (a<_baojingModel.smc_qy || a>_baojingModel.smc_gy)
        {
            return SGCOLOR(252, 13, 27, 1).CGColor;   //红色
        }
        else
        {
            return SGCOLOR(41, 253, 47, 1).CGColor;  //绿色
        }
    }
    else
    {
        switch (a)
        {
        case 1:
            return SGCOLOR(11, 36, 252, 1).CGColor;
            break;
        case 2:
            return SGCOLOR(7, 27, 201, 1).CGColor;
            break;
        case 3:
            return SGCOLOR(3, 15, 150, 1).CGColor;
            break;
        case 4:
            return SGCOLOR(1, 7, 100, 1).CGColor;
            break;
        case 5:
            return SGCOLOR(4, 62, 4, 1).CGColor;
            break;
        case 6:
            return SGCOLOR(14, 126, 18, 1).CGColor;
            break;
        case 7:
            return SGCOLOR(27, 189, 32, 1).CGColor;
            break;
        case 8:
            return SGCOLOR(41, 253, 47, 1).CGColor;
            break;
        default:
            return SGCOLOR(252, 13, 27, 1).CGColor;
            break;
        }
    }
}

- (void)drawDevice
{
    for (id subview in self.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            [subview removeFromSuperview];
        }
    }
    for (int i = 0; i<_deviceData.count; i++)
    {
        YS_deviceModel *model = _deviceData[i];
        UIImageView * deviceImg = [UIImageView new];
        deviceImg.image = [UIImage imageNamed:@"跑车"];
        deviceImg.center = CGPointMake(Formula_x(model.Actual_dx,_offsetNum_x), Formula_y(model.Actual_dy,_offsetNum_y));
        deviceImg.bounds = CGRectMake(0, 0, 50, 50);
        [self addSubview:deviceImg];
    }
}

- (void)setLeftData:(NSArray *)leftData
{
    _leftData = leftData;
    [self drawRoadData:_leftData];
    [self setNeedsDisplay];
}

- (void)setRightData:(NSArray *)rightData
{
    _rightData = rightData;
    [self drawRoadData:_rightData];
    [self setNeedsDisplay];
}

- (void)setBianshuData:(NSArray *)bianshuData
{
    _bianshuData = bianshuData;
    [self drawBianshu];
}

- (void)setDeviceData:(NSArray *)deviceData
{
    _deviceData = deviceData;
    [self drawDevice];
}

- (void)setBaojingModel:(YS_BaojingModel *)baojingModel
{
    _baojingModel = baojingModel;
}


@end
