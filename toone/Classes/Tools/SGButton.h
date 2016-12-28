//
//  SGButton.h
//  MobileOrder
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SGLabel.h"
typedef NS_ENUM(NSInteger,SGAlignment){
    left,
    center,
    right
};


@interface SGButton : UIButton
/*
    标记
 */
@property (nonatomic,copy) NSString * sign_title;
@property (nonatomic,assign) int sign_count;
/*
    做个可点击的label
 */
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,retain) UIFont * titleFont;

@property (nonatomic,assign) BOOL isplaceholder;
@property(nonatomic) NSInteger numberOfLines;
@property (nonatomic,copy) NSString * placeholder;
@property (nonatomic) SGAlignment alignment;
@end
