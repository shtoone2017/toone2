//
//  SGButton.m
//  MobileOrder
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGButton.h"
#define PlaceholderColor     [UIColor colorWithRed:200/205 green:200/205 blue:200/205 alpha:0.2]
@interface SGButton()
@property (nonatomic,retain) UILabel * LB;

@end

@implementation SGButton

-(void)initUI{
    _title = @"";
    //添加一个占位label
    UILabel * lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor clearColor];
    lb.numberOfLines = 0;
    [self addSubview:lb];
    //赋值
    _LB = lb;
    _LB.textColor = [UIColor blackColor];
    _LB.textAlignment = NSTextAlignmentLeft;
    _LB.font = [UIFont systemFontOfSize:12.0f];
    _LB.numberOfLines = 1;
}
/*
      错误 ！！！
 */
-(id)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _LB.frame = CGRectMake(x, y, width, height);
    
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _LB.text = title;
//    if (_isplaceholder) {
        if (title.length > 0) {
            _LB.textColor =  [UIColor blackColor];
        }
        else{
            _LB.text =_placeholder ? _placeholder : @"必选";
            _LB.textColor = PlaceholderColor;
        }
//    }
    [self setNeedsLayout];
}
-(void)setTitleColor:(UIColor *)titleColor{
    _LB.textColor = titleColor;
}
-(void)setTitleFont:(UIFont *)titleFont{
    _LB.font = titleFont;
}
-(void)setIsplaceholder:(BOOL)isplaceholder{
    _isplaceholder = isplaceholder;
    if (_isplaceholder) {
        [self setTitle:_title];
    }
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    if (_placeholder) {
        [self setTitle:_title];
    }
}
-(void)setNumberOfLines:(NSInteger)numberOfLines{
    _numberOfLines = numberOfLines;
    _LB.numberOfLines = numberOfLines;
    [self setNeedsLayout];
}
-(void)setAlignment:(SGAlignment)alignment{
    _alignment = alignment;
    if (_alignment == left) {
        _LB.textAlignment = NSTextAlignmentLeft;
    }
    if (_alignment == center) {
        _LB.textAlignment = NSTextAlignmentCenter;
    }
    if (_alignment == right) {
        _LB.textAlignment = NSTextAlignmentRight;
    }
}
@end
