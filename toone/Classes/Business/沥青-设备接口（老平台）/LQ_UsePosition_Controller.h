
//
//  LQ_UsePosition_controller.h
//  toone
//
//  Created by sg on 2017/3/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQ_UsePosition_Controller : UIViewController
@property (nonatomic,strong) NSDictionary * conditonDict;
@property (nonatomic,copy) void (^callBlock)(NSString*);
@end

