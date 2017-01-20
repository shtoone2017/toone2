//
//  SGLineChart.m
//  bar自定义
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGLineChart.h"




@interface SGLineChart()

@end


@implementation SGLineChart


-(instancetype)initWithFrame:(CGRect)frame
                        data:(NSArray*)datas
                       title:(NSArray*)titleX
                       color:(id)color{
    _datas  = datas;
    _titleX = titleX;
    _color  = color;
    if (_titleX.count != _datas.count && _titleX) {
        NSLog(@"titles匹配错误");
    }
    if (!datas || datas.count==0) {
        NSLog(@"datas匹配错误");
        return nil;
    }
    if (_datas[0] && [_datas[0] isKindOfClass:[NSArray class]]) {
        if ([_color isKindOfClass:[NSArray class]]) {
            if (((NSArray*)_color).count != [(NSArray*)_datas[0] count]) {
                NSLog(@"colors匹配错误");
            }
        }
       
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self views];
    }
    return self;
}
-(void)views{
    CGFloat x = 0;
    CGFloat y = titleTop_height;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height-titleTop_height;
    _sc = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y,w, h)];
    [self addSubview:_sc];
    [self show];
}
-(void)show{
    [self remove];

    _line = [[SGLine alloc] initWithFrame:CGRectMake(0, 0, 0, _sc.frame.size.height)
                                     data:_datas
                                    title:_titleX
                                    color:_color];

    if (_line.sectionWidth * _datas.count    <   _sc.frame.size.width) {
        _line.center = CGPointMake(_sc.frame.size.width/2, _sc.frame.size.height/2);
    }
    _sc.contentSize = CGSizeMake(_line.frame.size.width, _sc.frame.size.height);
    [_sc addSubview:_line];
}
/**
 * 重新赋值
 */
-(void)setDatas:(NSArray *)datas{
    _datas = datas;
}
-(void)setTitleX:(NSArray *)titleX{
    _titleX = titleX;
}
-(void)setTitleTop:(NSArray *)titleTop{
    for (UIView  * view in self.subviews) {
        if ([view isKindOfClass:[SGSign class]]) {
            [view removeFromSuperview];
        }
    }
    for (long i=0; i<titleTop.count; ++i) {
        CGFloat x = self.frame.size.width-titleSign_width*(i+1);
        CGFloat y = 0;
        CGFloat w = titleSign_width;
        CGFloat h = titleTop_height;
        SGSign * sign_view = [[SGSign alloc] initWithFrame:CGRectMake(x, y, w, h)];
        if ([_color isKindOfClass:[NSArray class]]) {
            sign_view.color = _color[i];
        }else if ([_color isKindOfClass:[UIColor class]]){
            sign_view.color = _color;
        }else{
            sign_view.color = [UIColor blueColor];
        }
        sign_view.title = titleTop[titleTop.count-i-1];
        [self addSubview:sign_view];
    }
}

/**
 *  移除
 */
-(void)remove{
    if (_line) {
        [_line removeFromSuperview];
        _line = nil;
    }
}


@end
