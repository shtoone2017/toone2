//
//  SGym.m
//  SGDate
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGym.h"
#import "YMTimePicker.h"

#define SGCOLOR(r,g,b,a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

#define button_width   100
#define button_height  40
@interface SGym()
@property (nonatomic,retain) YMTimePicker * picker;
@property (nonatomic,retain) UIButton * ok;
@property (nonatomic,retain) UIButton * cancel;
@property (nonatomic,retain) UIButton * back;
@end
@implementation SGym

-(id)init{
    CGFloat  x = 0;
    CGFloat  y = SCREEN_HEIGHT;
    CGFloat  w = SCREEN_WIDTH;
    CGFloat  h = w*2/3;
    CGRect   frame = CGRectMake(x, y, w, h);
    self = [super initWithFrame:frame];
    if (self) {
        [self ui];
    }
    return self;
}
-(void)ui{
    self.backgroundColor = SGCOLOR(245, 245, 245, 1.0);
    
    _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancel.frame = CGRectMake(0, 0, button_width, button_height);
    [_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [_cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_cancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancel];
    
    _ok = [UIButton buttonWithType:UIButtonTypeCustom];
    _ok.frame = CGRectMake(SCREEN_WIDTH-button_width, 0,button_width, button_height);
    [_ok setTitle:@"确定" forState:UIControlStateNormal];
    [_ok setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_ok addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_ok];
    
    _picker = [[YMTimePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cancel.frame), SCREEN_WIDTH , self.frame.size.height-button_height)];
    //    _picker.monthPickerDelegate=self;
    _picker.maximumYear =@2116;
    _picker.minimumYear =@1949;
    _picker.backgroundColor = [UIColor whiteColor];
    [self addSubview:_picker];
    
    _back = [UIButton buttonWithType:UIButtonTypeCustom];
    _back.frame = [UIScreen mainScreen].bounds;
    _back.backgroundColor = SGCOLOR(0, 0, 0, 0.1);
    
    [self show];
}
-(void)click:(UIButton*)sender{
    if (sender == _ok && _block) {
        NSDate * date = [_picker date];
        NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM"];
        NSString * timeStr = [dateFormater stringFromDate:date];
        _block(timeStr);
    }
    CGPoint startPoint = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT+self.frame.size.height/2);
    CGPoint endPoint   = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-self.frame.size.height/2);
    [self layer:self.layer startPoint:endPoint endPoint:startPoint];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.35];
}
-(void)remove{
    [_back removeFromSuperview];
    _back = nil;
    [self removeFromSuperview];
    _picker = nil;
    _ok = nil;
    _cancel = nil;
    _block = nil;
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:_back];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGPoint startPoint = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT+self.frame.size.height/2);
    CGPoint endPoint   = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-self.frame.size.height/2);
    [self layer:self.layer startPoint:startPoint endPoint:endPoint];
}
-(void)layer:(CALayer*)layer startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:startPoint];
    animation.toValue = [NSValue valueWithCGPoint:endPoint];
    animation.duration = 0.35;
    layer.position = endPoint;//如果不设置position , 动画结束后view会返回初始位置 ; 设置以后会返回设置位置
    [layer addAnimation:animation forKey:nil];
}
@end
