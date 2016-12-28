

//
//  UIButton+Item.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "UIButton+Img_20.h"

@implementation UIButton (Img_20)
+(UIButton*)img_20WithName:(NSString*)name{
    
    UIImageView * imgv = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    imgv.frame = CGRectMake(0, 0, 20, 20);
    
    UIButton * btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 40, 40);
    
//    imgv.center = CGPointMake(btn.center.x+12 , btn.center.y+1);
    imgv.center = CGPointMake(btn.center.x , btn.center.y+1);
    [btn addSubview:imgv];
    return btn;
}
+(UIButton*)img_20_leftWithName:(NSString*)name{
    UIImageView * imgv = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    imgv.frame = CGRectMake(0, 0, 30, 30);
    
    UIButton * btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 20, 40);
//    btn.backgroundColor = [UIColor yellowColor];
    imgv.center = CGPointMake(btn.center.x-5, btn.center.y);
    [btn addSubview:imgv];
    return btn;
}
@end
