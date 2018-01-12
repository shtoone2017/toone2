//
//  Exp1View.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum{
    ExpButtonTypeOk,
    ExpButtonTypeCancel,
    ExpButtonTypeStartTimeButton,
    ExpButtonTypeEndTimeButton,
    ExpButtonTypeChoiceSBButton,
    ExpButtonTypeChoiceTypeButton,
    ExpButtonTypeUsePosition,
    ExpButtonTypeSJQDText,//设计强度
    ExpButtonTypeLQText,//龄期
    ExpButtonTypeJZBWext,//浇筑部位
} ExpButtonType;

typedef void(^ExpBlock_t) (ExpButtonType,id,id);

@interface Exp1View : UIView
@property (nonatomic,copy) ExpBlock_t expBlock;
@end
