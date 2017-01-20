//
//  SGPie.m
//  CAlayer
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGPieChart.h"
#import "SGConst.h"


@interface SGPieChart()
@property (nonatomic,retain) UILabel * label;
@property (nonatomic,strong) CAShapeLayer *colorLayer;
@property (nonatomic,retain) UIColor * color;
@property (nonatomic,assign) CGFloat start_percent;
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation SGPieChart


-(instancetype)initWithFrame:(CGRect)frame
                     percent:(CGFloat)percent
                       color:(UIColor*)color{
    _color = color;
    _percent = percent;
    _start_percent = 0;
    CGRect self_frame = frame;
    self_frame.size.width = frame.size.height;
    self = [super initWithFrame:self_frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width/2;
        
        [self views:_percent color:_color];
        
        CAShapeLayer *whiteLayer = [self layer:1.0 withColor:[UIColor whiteColor]];
        [self.layer addSublayer:whiteLayer];
        
        _colorLayer = [self layer:_percent withColor:_color];
        [self.layer addSublayer:_colorLayer];
        
        CABasicAnimation * animation = [self animation];
        [_colorLayer addAnimation:animation forKey:nil];
        
        // 配置CADisplayLink
        [self configDisplayLink];
    }
    return self;
}
-(void)views:(CGFloat)percent color:(UIColor *)color{
    UILabel * finshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60 , 20)];
    finshLabel.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5-5);
    finshLabel.text = @"完成率";
    finshLabel.textAlignment = NSTextAlignmentCenter;
    finshLabel.font = [UIFont systemFontOfSize:8.0f];
    finshLabel.textColor = color;
    [self addSubview:finshLabel];
    
    
    CGFloat  w = self.frame.size.width*(1-pie_scale);
    CGFloat  h = w;
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    _label.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5+5);
    _label.text = [self readPercent:_percent];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:12.0f];
    _label.textColor = color;
    [self addSubview:_label];
}
-(NSString*)readPercent:(CGFloat)percent{
    NSString * text = [NSString stringWithFormat:@"%.2f%%",percent*100];
    if ([text hasSuffix:@".00%"]) {
        text = [text substringToIndex:text.length-4];
        text = [NSString stringWithFormat:@"%@%%",text];
        return text;
    }
    
    if ([text hasSuffix:@"0%"]) {
        text = [text substringToIndex:text.length-2];
        text = [NSString stringWithFormat:@"%@%%",text];
        return text;
    }
    return text;
}
-(CAShapeLayer*)layer:(CGFloat)percent withColor:(UIColor*)color{
    if (percent < 0) {
        return nil;
    }
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radius = self.frame.size.width*(1-pie_scale*0.5)*0.5;
    CGFloat startA = -M_PI;
    CGFloat endA =   startA+2*M_PI*percent;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.lineWidth = self.frame.size.width/2*pie_scale;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    layer.strokeColor = color.CGColor ? :[UIColor redColor].CGColor;
    return layer;
}
#pragma mark - 动画

/**
 *  填充动画过程
 *
 *  @return CABasicAnimation
 */
- (CABasicAnimation *)animation{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration            = 3.0*_percent;
    fillAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode            = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue           = @(0.f);
    fillAnimation.toValue             = @(1.f);
    return fillAnimation;
}

-(void)setPercent:(CGFloat)percent{
    _displayLink.paused = YES;
    _percent = percent;

    [_colorLayer removeAllAnimations];
    [_colorLayer removeFromSuperlayer];
    _colorLayer = nil;
    
    _colorLayer = [self layer:_percent withColor:_color];
    [self.layer addSublayer:_colorLayer];
    
    CABasicAnimation * animation = [self animation];
    [_colorLayer addAnimation:animation forKey:nil];
    
    _start_percent = 0;
    _displayLink.paused = NO;
}

- (void)configDisplayLink {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(run)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = NO; // 开启
}
-(void)run{
    if (_start_percent >= _percent) {
         _displayLink.paused = YES;
        return;
    }
    _start_percent += 0.0051;
    _start_percent = _start_percent> _percent ? _percent : _start_percent;
    _label.text    = [self readPercent:_start_percent];
}
@end
