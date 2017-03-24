//
//  HNT_BHZ_SB_Controller.h
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQ_SB_Controller : UIViewController
@property (nonatomic,strong) NSDictionary * conditonDict;
@property (nonatomic,copy) void (^callBlock)(NSString*,NSString*);
@end
