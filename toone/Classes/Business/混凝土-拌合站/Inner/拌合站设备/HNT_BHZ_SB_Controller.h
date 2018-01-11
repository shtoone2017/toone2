//
//  HNT_BHZ_SB_Controller.h
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SBListType) {
    SBListTypeSJQD = 0,  //强度等级
};

@interface HNT_BHZ_SB_Controller : UIViewController
@property (nonatomic,copy) NSString * departId;
@property (nonatomic,copy) void (^callBlock)(NSString*,NSString*);

@property (nonatomic,assign) NSInteger type;
@end
