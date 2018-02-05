//
//  YS_SB_Controller.h
//  toone
//
//  Created by 上海同望 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SBListType) {
    SBListTypeYSZH = 0,    //桩号
    SBListTypeYSLX,    //路线
    SBListTypeYSMC,    //面层
    
};

@interface YS_SB_Controller : UIViewController
@property (nonatomic,copy) void (^YScallBlock)(NSString*,NSString*);
@property (nonatomic,assign) NSInteger type;
@end
