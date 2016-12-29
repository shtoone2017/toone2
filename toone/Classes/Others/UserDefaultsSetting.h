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
@interface UserDefaultsSetting : NSObject
+(instancetype)shareSetting;

@property (nonatomic,copy) NSString * acount;
@property (nonatomic,copy) NSString * password;
@property (nonatomic,copy) NSString * loginDepartId;
@property (nonatomic,copy) NSString * departId;
@property (nonatomic,copy) NSString * departName;
@property (nonatomic,copy) NSString * userRole;
@property (nonatomic,copy) NSString * userPhoneNum;
@property (nonatomic,copy) NSString * userFullName;
@property (nonatomic, strong) NSNumber *funtype;


@property (nonatomic,assign,getter=isLogin) BOOL  login;
@property (nonatomic,assign,getter=isEnterApplication) BOOL enterApplication;

//保存到沙盒
-(void)saveToSandbox;

//权限
@property (nonatomic,assign) BOOL  hntchaobiaoReal;
@property (nonatomic,assign) BOOL  hntchaobiaoSp;
@property (nonatomic,assign) BOOL  syschaobiaoReal;


//存储开始时间和结束时间
@property (nonatomic,copy) NSString * startTime;
@property (nonatomic,copy) NSString * endTime;
@end
