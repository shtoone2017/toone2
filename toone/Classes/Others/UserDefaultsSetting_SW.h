//
//  LightweightData.h
//  toone
//
//  Created by 十国 on 16/11/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  存储登录信息
 */
@interface UserDefaultsSetting_SW : NSObject
+(instancetype)shareSetting;

@property (nonatomic,copy) NSString * acount;
@property (nonatomic,copy) NSString * password;
@property (nonatomic,assign,getter=isLogin) BOOL  login;
@property (nonatomic,assign,getter=isEnterApplication) BOOL enterApplication;
//保存到沙盒
-(void)saveToSandbox;
//存储开始时间和结束时间
@property (nonatomic,copy) NSString * startTime;
@property (nonatomic,copy) NSString * endTime;

//水稳本地存贮数据
@property (nonatomic,copy) NSString * biaoshi;
//用户类型 业主：1 标段：2 项目部：3 拌合站：5  (如果是业主，标示为空)
@property (nonatomic,copy) NSString * userType;
@property (nonatomic,copy) NSNumber * shenehe;
//@property (nonatomic,copy) NSString * zzjgName;
@end
