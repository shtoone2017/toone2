//
//  SGAnimationType.h
//  核心动画
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
/** 动画设置，基于transform */
typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationNormal = 0,      // 从上往下动画
    AnimationTopBotttom = AnimationNormal,
    AnimationTopLeft,         // 左上角放大
    AnimationTopRight,        // 右上角放大
    AnimationBottomLeft,      // 左下角放大
    AnimationBottomRight,     // 右下角放大
    AnimationBottomTop,       // 从下往上
    AnimationLeftRight,       // 从左到右
    AnimationRightLeft        // 从右到左
};

@interface SGAnimationType : NSObject
+(void)show:(UIView*)view animation:(AnimationType)aniType;
+(void)remove:(UIView*)view animation:(AnimationType)aniType completion:(void(^)())animationIsFinished;
@end
