//
//  SGAnimationType.m
//  核心动画
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGAnimationType.h"

@implementation SGAnimationType




+ (void)show:(UIView*)view animation:(AnimationType)aniType{
    
    switch (aniType) {
        case AnimationNormal:{
            CGRect   originRect = view.frame;
            view.transform = CGAffineTransformMakeScale(1, 0.0001);//参数是宽高缩放比例
            //            view.transform =   (CGAffineTransform){1, 0.0001};
            view.layer.anchorPoint = (CGPoint){0.5, 0};
            view.layer.position = (CGPoint){CGRectGetMidX(originRect), CGRectGetMinY(originRect)};
            break;
        }
        case AnimationTopRight:{
            CGRect   originRect = view.frame;
            view.transform =   CGAffineTransformMakeScale(0.0001, 0.0001);
            view.layer.anchorPoint = (CGPoint){1, 0};
            view.layer.position = CGPointMake(CGRectGetMaxX(originRect), CGRectGetMinY(originRect));
            break;
        }
        case AnimationTopLeft:{
            CGRect   originRect = view.frame;
            view.transform =   CGAffineTransformMakeScale(0.0001, 0.0001);
            view.layer.anchorPoint = (CGPoint){0, 0};
            view.layer.position = CGPointMake(CGRectGetMinX(originRect), CGRectGetMinY(originRect));
            break;
        }
        case AnimationBottomLeft:{
            CGRect   originRect = view.frame;
            view.transform =   CGAffineTransformMakeScale(0.0001, 0.0001);
            view.layer.anchorPoint = (CGPoint){0, 1};
            view.layer.position = CGPointMake(CGRectGetMinX(originRect), CGRectGetMaxY(originRect));
            break;
        }
        case AnimationBottomRight:{
            CGRect   originRect = view.frame;
            view.transform =   CGAffineTransformMakeScale(0.0001, 0.0001);
            view.layer.anchorPoint = (CGPoint){1, 1};
            view.layer.position = CGPointMake(CGRectGetMaxX(originRect), CGRectGetMaxY(originRect));
            break;
        }
        case AnimationBottomTop:{
            CGRect   originRect = view.frame;
            view.transform =   CGAffineTransformMakeScale(1, 0.0001);
            view.layer.anchorPoint = (CGPoint){0.5, 1};
            view.layer.position = CGPointMake(CGRectGetMidX(originRect), CGRectGetMaxY(originRect));
            break;
        }
        case AnimationLeftRight:{
            CGRect   originRect = view.frame;
            view.transform =   CGAffineTransformMakeScale(0.0001, 1);
            view.layer.anchorPoint = (CGPoint){0, 0.5};
            view.layer.position = CGPointMake(CGRectGetMinX(originRect), CGRectGetMidY(originRect));
            break;
        }
        case AnimationRightLeft:{
            CGRect   originRect = view.frame;
            view.transform =   CGAffineTransformMakeScale(0.0001, 1);
            view.layer.anchorPoint = (CGPoint){1, 0.5};
            view.layer.position = CGPointMake(CGRectGetMaxX(originRect), CGRectGetMidY(originRect));
            break;
        }
        default:
            break;
    }
    
    
    [UIView animateWithDuration:0.15 animations:^{
        view.transform = CGAffineTransformMakeScale(1, 1);
        
    }];
}

+(void)remove:(UIView*)view animation:(AnimationType)aniType completion:(void(^)())animationIsFinished{
    [UIView animateWithDuration:0.15 animations:^{
        switch (aniType) {
            case AnimationNormal:
                view.transform = CGAffineTransformMakeScale(1, 0.0001);
                break;
            case AnimationTopRight:
                view.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                break;
            case AnimationTopLeft:
                view.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                break;
            case AnimationBottomLeft:
                view.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                break;
            case AnimationBottomRight:
                view.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                break;
            case AnimationBottomTop:
                view.transform = CGAffineTransformMakeScale(1, 0.0001);
                break;
            case AnimationLeftRight:
                view.transform = CGAffineTransformMakeScale(0.0001, 1);
                break;
            case AnimationRightLeft:
                view.transform = CGAffineTransformMakeScale(0.0001, 1);
                break;
            default:
                break;
        }
        
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
    
    if (animationIsFinished) {
        animationIsFinished();
    }
}


@end
