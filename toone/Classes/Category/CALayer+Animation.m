//
//  CALayer+animation.m
//  toone
//
//  Created by 十国 on 16/11/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer (Animation)


-(void)addTransitionWithType:(NSString*)type{
    CATransition * ani = [CATransition animation];
    ani.type = type;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 1.0;
    [self addAnimation:ani forKey:nil];
}

@end
