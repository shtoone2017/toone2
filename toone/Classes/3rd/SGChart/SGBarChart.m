//
//  SGBarChart.m
//  bar自定义
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGBarChart.h"
#import "SGBarSuper.h"
#import "SGSign.h"
#import "SGConst.h"


@interface SGBarChart()
@property (nonatomic,retain) UIScrollView * sc;
@property (nonatomic,retain) SGBarSuper * bar;
@property (nonatomic,retain) id color;
@property (nonatomic,retain) NSArray * colors;
@property (nonatomic,assign) int sign; //标记
@end
@implementation SGBarChart



-(instancetype)initWithFrame:(CGRect)frame
                        data:(NSArray*)datas
                       title:(NSArray*)titleX
                       color:(id)color{
    _sign   = 1;
    _datas  = datas;
    _titleX = titleX;
    _color  = color;
    
    
    if (_titleX.count != _datas.count && _titleX) {
        NSLog(@"title匹配错误");
    }
    if ([_color isKindOfClass:[NSArray class]] && _color) {
        if ([(NSArray*)_color count] != _datas.count) {
            NSLog(@"color匹配错误");
        }
    }else{
        if (![_color isKindOfClass:[UIColor class]]) {
            NSLog(@"color is not UIColor class , color = %@",_color);
        }
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        [self views];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
                       datas:(NSArray*)datas
                      titles:(NSArray*)titleX
                      colors:(NSArray*)colors{
    _sign   = 2;
    _datas  = datas;
    _titleX = titleX;
    _colors = colors;
    if (_titleX.count != _datas.count && _titleX) {
        NSLog(@"titles匹配错误");
    }
    if (_datas[0]) {
        if (colors.count != [(NSArray*)_datas[0] count]) {
            NSLog(@"colors匹配错误");
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
    switch (_sign) {
        case 1:
            _bar = [[SGBarSuper alloc] initWithFrame:_sc.frame
                                                data:_datas
                                               title:_titleX
                                               color:_color];
            break;
        case 2:
            _bar = [[SGBarSuper alloc] initWithFrame:_sc.frame
                                               datas:_datas
                                              titles:_titleX
                                              colors:_colors];
            break;
        default:
            break;
    }
    
    if (_bar.sectionWidth * _datas.count    <   _sc.frame.size.width) {
        _bar.center = CGPointMake(_sc.frame.size.width/2, _sc.frame.size.height/2);
    }
    _sc.contentSize = CGSizeMake(_bar.frame.size.width, _sc.frame.size.height);
    [_sc addSubview:_bar];
}
/*
 重新赋值
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
        sign_view.color= _sign == 1  ?
        ([_color  isKindOfClass:[UIColor class]] ? _color     : [UIColor blueColor]):
        ([_colors isKindOfClass:[NSArray class]] ? _colors[_colors.count-i-1] : [UIColor blueColor]);
        sign_view.title = titleTop[titleTop.count-i-1];
        [self addSubview:sign_view];
    }
}
/*
 移除
 */
-(void)remove{
    if (_bar) {
        [_bar removeFromSuperview];
        _bar = nil;
    }
}

@end
