//
//  MySJView.h
//  toone
//
//  Created by 十国 on 2016/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>





typedef enum {
    SJOkClick,
    SJCancelClick
}SJButtonClickType;

typedef void(^callBackBlock_t)(SJButtonClickType,NSString*);


@interface MySJView : UIView

@property (nonatomic,copy) callBackBlock_t callBack;

@property (nonatomic,assign) BOOL isDetailSecond;  //压实中需要获取到秒


@end
