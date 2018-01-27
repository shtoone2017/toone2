//
//  JZL_JZBW_Controller.h
//  toone
//
//  Created by 上海同望 on 2017/8/24.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyInputController.h"

@interface JZL_JZBW_Controller : MyInputController
@property (nonatomic,copy) void (^callBlock)(NSDictionary*);
//@property (nonatomic,copy) void (^callsBlock)(NSString*,NSString*,NSString*);
@end
