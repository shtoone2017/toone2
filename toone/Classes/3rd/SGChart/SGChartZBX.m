//
//  SGLineChartZBX.m
//  afafaadafaaf
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGChartZBX.h"
#import "Y.h"

@interface SGChartZBX()
@property (nonatomic,retain) id         bar_color;
@property (nonatomic,retain) Y*   y_left;
@property (nonatomic,retain) Y*   y_right;

@end

@implementation SGChartZBX

-(instancetype)initWithFrame:(CGRect)frame
                      titleX:(NSArray*)titleX
                   line_data:(NSArray*)line_data
                  line_color:(id)line_color
                    bar_data:(NSArray*)bar_data
                   bar_color:(id)bar_color
{
    if (line_data.count != bar_data.count) {
        NSLog(@"SGChartZBX ->  line_data.count != bar_data.count");
    }
    _bar_data = bar_data;
    _bar_color = bar_color;
    return [super initWithFrame:frame data:line_data title:titleX color:line_color];
}

-(void)views{
    CGFloat x = distance;
    CGFloat y = titleTop_height;
    CGFloat w = super.frame.size.width-distance*2;
    CGFloat h = super.frame.size.height-y;
    super.sc = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y,w, h)];
    super.sc.showsHorizontalScrollIndicator = NO;
    [self addSubview:super.sc];
    
    _y_left = [[Y alloc] initWithFrame:CGRectMake(0, titleTop_height+titleHeader_height, distance, self.frame.size.height -titleX_height-titleHeader_height-titleTop_height)
                                          datas:_bar_data
                                       position:@"left"];
    [self addSubview:_y_left];
    _y_right = [[Y alloc] initWithFrame:CGRectMake(w+distance, titleTop_height+titleHeader_height, distance, self.frame.size.height -titleX_height-titleHeader_height-titleTop_height)
                                 datas:super.datas
                              position:@"right"];
    [self addSubview:_y_right];
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(x, y, 1, h-30)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line1];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(x, h-30+y, w, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line2];
    
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(x+w, y, 1, h-30)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line3];
    
    
    /**
     *  画箭头
     *
     *  @param x x值
     *  @param y y值
     *
     *  @return
     */
    [self drawWithPoint:CGPointMake(x, y)];
    [self drawWithPoint:CGPointMake(x+w, y)];
    
    /**
     *
     */
    [self show];
}
-(void)setBar_data:(NSArray *)bar_data{
    _bar_data = bar_data;
    _y_left.datas = bar_data;
}
-(void)setDatas:(NSArray *)datas{
    super.datas = datas;
    _y_right.datas = datas;
}
-(void)show{
    [self remove];
    
    
  
    
    _bar = [[SGBarSuper alloc] initWithFrame:CGRectMake(0, 0, 0, super.sc.frame.size.height)
                                        data:_bar_data
                                       title:super.titleX
                                       color:_bar_color];
    [super.sc addSubview:_bar];
  

    if (_bar.sectionWidth * super.datas.count    <   super.sc.frame.size.width) {
        _bar.center = CGPointMake(super.sc.frame.size.width/2, super.sc.frame.size.height/2);
    }
    
    super.sc.contentSize = CGSizeMake(_bar.frame.size.width, super.sc.frame.size.height);
    

    


//    _signR = [[SGSign alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_bar.frame), titleTop_height, rightView_Width, super.sc.frame.size.height-titleX_height-titleTop_height) colors:colors titles:_signR_data];
//    [super.sc addSubview:_signR];
//    
    
    [self performSelector:@selector(runAfter) withObject:nil afterDelay:3.0];
}
-(void)runAfter{
    super.line = [[SGLine alloc] initWithFrame:CGRectMake(0, 0, 0, super.sc.frame.size.height)
                                          data:super.datas
                                         title:nil
                                         color:super.color];
    
    [super.sc addSubview:super.line];
    
    if (super.line.sectionWidth * super.datas.count    <   super.sc.frame.size.width) {
        super.line.center = CGPointMake(super.sc.frame.size.width/2, super.sc.frame.size.height/2);
    }
}

/**
 *  移除
 */
-(void)remove{
    if (_bar) {
        [_bar removeFromSuperview];
        _bar = nil;
    }
    
    if (super.line) {
        [super.line removeFromSuperview];
        super.line = nil;
    }
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
-(void)setTitleTop:(NSArray *)titleTop{
    for (UIView  * view in super.subviews) {
        if ([view isKindOfClass:[SGSign class]]) {
            [view removeFromSuperview];
        }
    }
    
    /**
     *    数据处理 titleTop颜色数组
     */
        NSMutableArray * colors = [NSMutableArray array];
        [colors addObject:[_bar_color isKindOfClass:[UIColor class]] ? _bar_color :[UIColor blueColor]];
        if ([super.color isKindOfClass:[NSArray class]]) {
            [colors addObjectsFromArray:(NSArray*)super.color];
        }else if([super.color isKindOfClass:[UIColor class]]){
            [colors addObject:super.color];
        }
        else{
            [colors addObject:[UIColor blackColor]];
        }
    
    for (long i=0; i<titleTop.count; ++i) {
        CGFloat x = self.frame.size.width-signTopR_width*(i+1);
        CGFloat y = 0;
        CGFloat w = signTopR_width;
        CGFloat h = titleTop_height;
        SGSign * sign_view = [[SGSign alloc] initWithFrame:CGRectMake(x, y, w, h)];
        sign_view.color = colors[i>colors.count ? 1 : titleTop.count-i-1];
        sign_view.title = titleTop[titleTop.count-i-1];
        
        
        [self addSubview:sign_view];
    }
}
@end
