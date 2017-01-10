//
//  HNT_SYS_typeAndSB_Controller.h
//  toone
//
//  Created by 十国 on 16/12/2.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    HNT_SYS_YLJ_SY,
    HNT_SYS_YLJ_SB,
    HNT_SYS_WNJ_SY,
    HNT_SYS_WNJ_SB
    
}HNT_SYS_TypeAndSB_t;

typedef void(^typeSBBlock_t)(NSString *,NSString*);

@interface HNT_SYS_typeAndSB_Controller : UIViewController

@property (nonatomic,assign) HNT_SYS_TypeAndSB_t typeAndSB;

@property (nonatomic,copy) typeSBBlock_t typeSBBlock;

@end
