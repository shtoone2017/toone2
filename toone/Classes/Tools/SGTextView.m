//
//  SGTextView.m
//  textView添加placeHorder属性
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 jzs.com. All rights reserved.
//

#import "SGTextView.h"
#define PlaceholderColor     [UIColor colorWithRed:200/205 green:200/205 blue:200/205 alpha:0.2]

@interface SGTextView ()
@property (nonatomic,retain) UILabel * LB;
@end
@implementation SGTextView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        //添加一个占位label
        UILabel * lb = [[UILabel alloc] init];
        lb.backgroundColor = [UIColor clearColor];
        lb.numberOfLines = 0;
        [self addSubview:lb];
        //赋值
        _LB = lb;
        _LB.textColor = PlaceholderColor;
        self.font = [UIFont systemFontOfSize:12.0f];
        //通知监听textDidChange
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个占位label
        UILabel * lb = [[UILabel alloc] init];
        lb.backgroundColor = [UIColor clearColor];
        lb.numberOfLines = 0;
        [self addSubview:lb];
        //赋值
        _LB = lb;
        _LB.textColor = PlaceholderColor;
         self.font = [UIFont systemFontOfSize:12.0f];
        //通知监听textDidChange
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
-(void)textChange{
    _LB.hidden = self.hasText;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = self.frame.size.width - 2*x;
    CGFloat height = [_LB.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_LB.font} context:nil].size.height;
    _LB.frame = CGRectMake(x, y, width, height);
}
-(void)setPlaceholder:(NSString *)placeholder{
//    _placeholder= [placeholder copy];
    if (!_placeholder) {
        _placeholder = placeholder;
        _LB.text = placeholder;
       [self setNeedsLayout];
    }
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    if (!_placeholderColor) {
        _placeholderColor = placeholderColor;
        _LB.textColor = placeholderColor;
    }
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    _LB.font = font;
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textChange];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}
@end
