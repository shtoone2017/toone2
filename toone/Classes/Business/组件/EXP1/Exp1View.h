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
    ExpButtonTypeEarthwork,
    ExpButtonTypeTjlxBut,//统计类型
    ExpButtonTypeCclxBut,//出场类型
    ExpButtonTypeRwdText,//任务单号
} ExpButtonType;

typedef void(^ExpBlock_t) (ExpButtonType,id,id);

@interface Exp1View : UIView
@property (nonatomic,copy) ExpBlock_t expBlock;
@end
