//
//  YSRoadView.m
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSRoadView.h"

#define AnimationTime 5
@interface YSRoadView ()<UIGestureRecognizerDelegate,CAAnimationDelegate>
{

    NSArray *colorArr;//颜色集合
    NSMutableArray *newData_huifang;
    
    NSMutableArray *numArr; //计数集合
    NSMutableArray *carImgArr; //车子集合

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
        colorArr = @[SGCOLOR(11, 36, 252, 1),SGCOLOR(7, 27, 201, 1),SGCOLOR(3, 15, 150, 1),SGCOLOR(1, 7, 100, 1),SGCOLOR(4, 62, 4, 1),SGCOLOR(14, 126, 18, 1),SGCOLOR(27, 189, 32, 1),SGCOLOR(41, 253, 47, 1),SGCOLOR(252, 13, 27, 1)];
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


//回放
- (void)drawHuiFang
{
    newData_huifang = [NSMutableArray array];
    [newData_huifang addObject:@[_huifangArr[0]]];
    for (YS_HFModel * tempModel in _huifangArr)
    {
        [self doForModel:tempModel];
    }
    numArr = [NSMutableArray array];
    carImgArr = [NSMutableArray array];
    for (int i = 0; i < newData_huifang.count; ++i) {
        [numArr addObject:[NSNumber numberWithInt:0]];
        
        UIImageView * car_huifangImg = [UIImageView new];
        car_huifangImg.bounds =CGRectMake(0, 0, 30, 30);
        car_huifangImg.backgroundColor = [UIColor greenColor];
        [self addSubview:car_huifangImg];
        
        [carImgArr addObject:car_huifangImg];
    }
    
    for (int i = 0; i < newData_huifang.count; i++) {
        NSArray *arr2 = [newData_huifang objectAtIndex:i];
        YS_HFModel * s_model = arr2[0];
        CGPoint start_p = CGPointMake(Formula_x(s_model.Actual_dx,_offsetNum_x),Formula_y(s_model.Actual_dy, _offsetNum_y));
        YS_HFModel * e_model = arr2[1];
        CGPoint end_p = CGPointMake(Formula_x(e_model.Actual_dx,_offsetNum_x),Formula_y(e_model.Actual_dy, _offsetNum_y));
        
        UIImageView *img = [carImgArr objectAtIndex:i];
        img.center = start_p;

        [self animationLoopWithPoint:start_p point1:end_p];    }
}

- (void)doForModel:(YS_HFModel *)tempModel
{
    BOOL isExit = NO;
    for (int i = 0; i<newData_huifang.count; i++)
    {
        NSMutableArray *arr2 = [NSMutableArray arrayWithArray:newData_huifang[i]];
        YS_HFModel * tempModel1 = arr2[0];
        if ([tempModel.device_code isEqualToString:tempModel1.device_code])
        {
            [arr2 addObject:tempModel];
            [newData_huifang setObject:arr2 atIndexedSubscript:i];
            isExit = YES;
            break;
        }
    }
    if (isExit == NO)
    {
        NSMutableArray *arr2 = [NSMutableArray array];
        [arr2 addObject:tempModel];
        [newData_huifang addObject:arr2];
    }
}

- (UIColor *)huifangGetColorWithCount:(NSInteger)a
{
//    NSArray *tempColors;
//    //取色范围调整
//    if (newData_huifang.count < 200)
//    {
//        tempColors = [colorArr subarrayWithRange:NSMakeRange(0, 3)];
//    }
//    else if (newData_huifang.count > 200&&newData_huifang.count<400)
//    {
//        tempColors = [colorArr subarrayWithRange:NSMakeRange(0, 6)];
//    }
//    else
//    {
//        tempColors = [colorArr subarrayWithRange:NSMakeRange(0, 9)];
//    }
//
//    NSInteger b = floor(a/(newData_huifang.count/tempColors.count));
//    UIColor *aColor;
//    if (b>= tempColors.count)
//    {
//        aColor = [tempColors lastObject];
//    }
//    else
//    {
//        aColor = tempColors[a];
//    }
    return [UIColor redColor];
}

- (void)animationLoopWithPoint:(CGPoint)start_point point1:(CGPoint)end_point
{
    for (int i = 0; i < newData_huifang.count; ++i) {
        NSInteger a = [[numArr objectAtIndex:i] integerValue];
        UIImageView *imgview = (UIImageView *)carImgArr[i];
        NSArray *arr = newData_huifang[i];
        if (a<arr.count-2)
        {
            float time = 3600/newData_huifang.count;
            
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
            [imgview.layer addAnimation:anima forKey:@"move-layer"];
            
            UIBezierPath *path = [UIBezierPath new];
            [path moveToPoint:start_point];
            [path addLineToPoint:end_point];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            layer.strokeColor = [self huifangGetColorWithCount:a].CGColor;
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
    
}

/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    for (int i = 0; i < newData_huifang.count; ++i) {
        NSArray *arr = newData_huifang[i];

        NSInteger a = [[numArr objectAtIndex:i] integerValue];
        if (a<arr.count-2)
        {
            a ++;
            [numArr setObject:[NSNumber numberWithInteger:a] atIndexedSubscript:i];
            YS_HFModel * s_model = [arr objectAtIndex:a];
            CGPoint start_p = CGPointMake(Formula_x(s_model.Actual_dx,_offsetNum_x),Formula_y(s_model.Actual_dy, _offsetNum_y));
            YS_HFModel * e_model = [arr objectAtIndex:a+1];
            CGPoint end_p = CGPointMake(Formula_x(e_model.Actual_dx,_offsetNum_x),Formula_y(e_model.Actual_dy, _offsetNum_y));
            [self animationLoopWithPoint:start_p point1:end_p];
        }
    }
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
        if (a>8)
        {
            UIColor *color = colorArr[8];
            return color.CGColor;
        }
        else
        {
            UIColor *color = colorArr[a-1];
            return color.CGColor;
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
