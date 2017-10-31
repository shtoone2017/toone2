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
@property (nonatomic,copy) NSString * shenehe;
@property (nonatomic,copy) NSString * chuzhi;
@property (nonatomic,copy) NSString * zxdwshenhe;
//@property (nonatomic,copy) NSString * zzjgName;
@property (nonatomic,copy) NSString * userFullName;


//车辆运输存贮数据
@property (nonatomic, copy) NSString *Token;
@property (nonatomic, copy) NSString *Jgdm;//用户所属拌和站编码

@property (nonatomic,copy) NSString * carLoad;//随机

//获取一个随机种子
@property (nonatomic,copy) NSString * randomSeed;


@end
