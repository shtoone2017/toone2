//
//  YSRoadView.m
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSRoadView.h"

#define AnimationTime 0.01
@interface YSRoadView ()<UIGestureRecognizerDelegate,CAAnimationDelegate>
{
    int z; //回放计数
    UIImageView *car_huifangImg; //回放车子
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

- (void)drawHuiFang
{
    z = 0;
    YS_HFModel * s_model = [_huifangArr objectAtIndex:z];
    CGPoint start_p = CGPointMake(Formula_x(s_model.Actual_dx,_offsetNum_x),Formula_y(s_model.Actual_dy, _offsetNum_y));
    YS_HFModel * e_model = [_huifangArr objectAtIndex:z+1];
    CGPoint end_p = CGPointMake(Formula_x(e_model.Actual_dx,_offsetNum_x),Formula_y(e_model.Actual_dy, _offsetNum_y));
    
//    CGPoint start_p = CGPointMake(100,100);
//    CGPoint end_p = CGPointMake(300,300);

    car_huifangImg = [UIImageView new];
    car_huifangImg.bounds =CGRectMake(0, 0, 30, 30);
    car_huifangImg.center = start_p;
    car_huifangImg.backgroundColor = [UIColor greenColor];
    [self addSubview:car_huifangImg];
    [self animationLoopWithPoint:start_p point1:end_p];
}

- (void)animationLoopWithPoint:(CGPoint)start_point point1:(CGPoint)end_point
{
    if (z<_huifangArr.count-2)
    {
//        float time = 3600/_huifangArr.count;

        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
        anima.delegate = self;
        // 动画结束后不变回初始状态
        anima.removedOnCompletion = NO;
        anima.fillMode = kCAFillModeForwards;
//        anima.autoreverses = YES; //逆动画效果
        anima.duration = AnimationTime;
//        anima.duration = time;
        anima.repeatCount = 1;
        anima.fromValue = [NSValue valueWithCGPoint:start_point]; // 起始帧
        anima.toValue = [NSValue valueWithCGPoint:end_point]; // 终了帧
        [car_huifangImg.layer addAnimation:anima forKey:@"move-layer"];
        
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:start_point];
        [path addLineToPoint:end_point];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor redColor].CGColor;
        [layer setFillColor:[UIColor clearColor].CGColor];
        layer.lineWidth = 2.5*YS_Scale;
        CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        anim1.fromValue = @0;
        anim1.toValue = @1;
        anim1.duration = AnimationTime;
        //        anima.duration = time;
        [layer addAnimation:anim1 forKey:NSStringFromSelector(@selector(strokeEnd))];
        
        [self.layer addSublayer:layer];
    }
}

/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    z++;
    YS_HFModel * s_model = [_huifangArr objectAtIndex:z];
    CGPoint start_p = CGPointMake(Formula_x(s_model.Actual_dx,_offsetNum_x),Formula_y(s_model.Actual_dy, _offsetNum_y));
    YS_HFModel * e_model = [_huifangArr objectAtIndex:z+1];
    CGPoint end_p = CGPointMake(Formula_x(e_model.Actual_dx,_offsetNum_x),Formula_y(e_model.Actual_dy, _offsetNum_y));
    [self animationLoopWithPoint:start_p point1:end_p];
    
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

- (void)setHuifangArr:(NSArray *)huifangArr
{
    _huifangArr = huifangArr;
    [self drawHuiFang];
}

@end
