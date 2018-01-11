//
//  InputController.h
//  toone
//
//  Created by 上海同望 on 2018/1/10.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputController : UIViewController
@property (nonatomic,copy) void (^callBlock)(NSString*);
@property (nonatomic, copy) NSString *oldString;
@end
