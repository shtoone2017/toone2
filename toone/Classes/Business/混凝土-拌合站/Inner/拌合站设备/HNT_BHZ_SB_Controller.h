//
//  HNT_BHZ_SB_Controller.h
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SBListType) {
    SBListTypeBF = 0,  //磅房设备列表
    SBListTypeSJQD,   //设计强度
    SBListTypeTLD,    //塌落度
    SBListTypeJZFS,     //浇注方式
    SBListTypeRWDZT,     //任务单状态
    SBListTypeTon,    //统计类型
    SBListTypeStat,     //出场类别
    SBListTypeRWSCZ,     //生产中
    SBListTypeRWWSC,     //未生产
    SBListTypeCBCZ,    //超标处置
    SBListTypeYLQD,    //压力设计强度
    SBListTypeYLLQ,    //龄期
    SBListTypeSGD,    //施工队
};

@interface HNT_BHZ_SB_Controller : UIViewController
@property (nonatomic,copy) NSString * departId;
@property (nonatomic,copy) void (^callBlock)(NSString*,NSString*);
@property (nonatomic,assign) NSInteger type;

@end
