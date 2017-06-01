//
//  TP_SB_Controller.h
//  toone
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyViewController.h"

@interface TP_CLSB_Controller : MyViewController
@property (nonatomic,copy) void(^callBack)(NSString*,NSString*);
@end
