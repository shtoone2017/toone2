//
//  SGBar.h
//  CAlayer
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGBar : UIView
/**
 *  动画时间
 */
@property (assign,nonatomic) CGFloat totalTime;
/**
 *  根据view的layer属性生成一个bar
 *
 *  @param frame   bar的frame
 *  @param percent 根据百分比显示bar的高度
 *  @param color   bar的颜色
 *
 *  @return 返回一个bar
 */
-(instancetype)initWithFrame:(CGRect)frame
                     percent:(CGFloat)percent
                       color:(UIColor*)color;
@end
