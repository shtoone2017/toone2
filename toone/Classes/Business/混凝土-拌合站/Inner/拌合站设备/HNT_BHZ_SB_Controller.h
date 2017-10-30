//
//  HNT_BHZ_SB_Controller.h
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SBListType) {
    SBListTypeStatu = 0,  //签收状态
    SBListTypeQS,     //签收or拒收
    SBListTypeJSYY,     //拒收原因
    SBListTypeLocal,     //本地查询
};

@interface HNT_BHZ_SB_Controller : UIViewController
@property (nonatomic,copy) NSString * departId;
@property (nonatomic,copy) void (^callBlock)(NSString*,NSString*);
@property (nonatomic,assign) NSInteger type;

@end
