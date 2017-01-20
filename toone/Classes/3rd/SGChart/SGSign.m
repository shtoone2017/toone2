//
//  SGSign.m
//  bar自定义
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGSign.h"
#import "SGConst.h"


@interface SGSign()
@property (nonatomic,retain) UILabel * lb;
@property (nonatomic,retain) UIView  * view;
@end
@implementation SGSign
//   1.0
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self views];
    }
    return self;
}
-(void)views{
   _view = [[UIView alloc] initWithFrame:CGRectMake(0,Sign_TopView_Right_y, Sign_LittleView_Width, Sign_LittleView_Width)];
    [self addSubview:_view];
    
    _lb           = [[UILabel alloc] initWithFrame:CGRectMake(Sign_LittleView_Width*1.5, Sign_TopView_Right_y, self.frame.size.width-1.5*Sign_LittleView_Width,Sign_LittleView_Width)];
    _lb.textColor = [UIColor grayColor];
    _lb.numberOfLines = 2;
    _lb.textAlignment = NSTextAlignmentLeft;
    _lb.font      = [UIFont systemFontOfSize:9.0f];
    [self addSubview:_lb];
}
-(void)setTitle:(NSString *)title{
    _lb.text = title;
}

-(void)setColor:(UIColor *)color{
    _view.backgroundColor = color;
}




//   2.0
//-(instancetype)initWithFrame:(CGRect)frame
//                      colors:(NSArray*)colors
//                      titles:(NSArray*)titles
//{
//    if (colors.count != titles.count) {
//        NSLog(@"SGSign -> colors.count != titles.count");
//    }
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self colors:colors titles:titles];
//    }
//    return self;
//}
//-(void)colors:(NSArray*)colors titles:(NSArray*)titles{
//    for (int i = 0; i < titles.count; ++i) {
//        UIColor * color = i >= colors.count ? colors[1] :colors[i];
//        UIView * back = [self color:color title:titles[i] indexY:i];
//        [self addSubview:back];
//    }
//}
//-(UIView*)color:(UIColor*)color title:(NSString*)title  indexY:(long)i{
//    CGFloat height = self.bounds.size.height/5;
//    CGFloat width  = self.bounds.size.width;
//    UIView * back  = [[UIView alloc] initWithFrame:CGRectMake(0, height*i, width, height)];
//    
//    UIView * signView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Sign_LittleView_Width, Sign_LittleView_Width)];
//    signView.center = CGPointMake(Sign_LittleView_Width/2+2, CGRectGetMidY(back.bounds));
//    signView.backgroundColor = color;
//    [back addSubview:signView];
//    
//    UILabel * signLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*2+Sign_LittleView_Width, 0, width - Sign_LittleView_Width -2*3, height)];
//    signLabel.font = [UIFont systemFontOfSize:10.0];
//    signLabel.textColor = color;
//    signLabel.text = title;
//    [back addSubview:signLabel];
//    return  back;
//}


@end
