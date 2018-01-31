//
//  LightweightData.m
//  toone
//
//  Created by 十国 on 16/11/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "UserDefaultsSetting.h"

@implementation UserDefaultsSetting
+(instancetype)shareSetting{
    return [[self alloc] init];
}


static UserDefaultsSetting * setting = nil;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting.randomSeed = @"0";
        setting = [super allocWithZone:zone];
        [setting getFromSandbox];
    });
    return setting;
}

-(void)getFromSandbox{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    setting.acount   = [defaults objectForKey:@"acountKey"];
    setting.password = [defaults objectForKey:@"passwordKey"];
    setting.departId = [defaults objectForKey:@"departIdKey"];
    setting.loginDepartId = [defaults objectForKey:@"loginDepartIdKey"];
    setting.departName = [defaults objectForKey:@"departNameKey"];
    setting.userRole = [defaults objectForKey:@"userRoleKey"];
    setting.login    = [defaults boolForKey:@"loginKey"];
    setting.enterApplication = [defaults boolForKey:@"enterApplicationKey"];
    setting.userPhoneNum = [defaults objectForKey:@"userPhoneNumKey"];
    setting.userFullName = [defaults objectForKey:@"userFullNameKey"];
    //项目选择
    setting.funtype = [defaults objectForKey:@"funtypeKey"];
    //分部分项
    setting.partialName = [defaults objectForKey:@"partialNameKey"];
    
    //权限
    setting.hntchaobiaoReal = [defaults boolForKey:@"hntchaobiaoRealKey"];
    setting.hntchaobiaoSp = [defaults boolForKey:@"hntchaobiaoSpKey"];
    setting.syschaobiaoReal = [defaults boolForKey:@"syschaobiaoRealKey"];
    setting.wzgcbReal = [defaults boolForKey:@"wzgcbRealKey"];
    
    
    //存储时间
    setting.startTime = [defaults objectForKey:@"startTimeKey"];
    setting.endTime   = [defaults objectForKey:@"endTimeKey"];
    
    //沥青超标等级
    setting.dengji = [defaults objectForKey:@"dengjiKey"];
    //    生产数据查询设备编号
    setting.shebeibianhao = [defaults objectForKey:@"shebeibianhaoKey"];
    setting.bianhao = [defaults objectForKey:@"bianhaoKey"];
    
    //日产量id
    setting.dailyid = [defaults objectForKey:@"dailyidKey"];
    //日产量设备编号
    setting.dailysbbh = [defaults objectForKey:@"dailysbbhKey"];
    //待处置编号，设备编号
    setting.CBbianhao = [defaults objectForKey:@"CBbianhaoKey"];
    setting.CBshebeibianhao = [defaults objectForKey:@"CBshebeibianhaoKey"];
    //沥青超标处理
    setting.chuli = [defaults objectForKey:@"chuliKey"];
    //生产查询筛选设备编号
    setting.shebString = [defaults objectForKey:@"shebStringKey"];
    //    超标处置类型
    setting.CBczlx = [defaults objectForKey:@"CBczlxKey"];
    
    
    //水稳本地存贮数据
    setting.biaoshi   = [defaults objectForKey:@"biaoshi_SWKey"];
    setting.userType   = [defaults objectForKey:@"userType_SWKey"];
    setting.shenehe   = [defaults objectForKey:@"shenehe_SWKey"];
    setting.chuzhi   = [defaults objectForKey:@"chuzhi_SWKey"];
    setting.zxdwshenhe   = [defaults objectForKey:@"zxdwshenhe_SWKey"];
    setting.userFullName   = [defaults objectForKey:@"userFullName_SWKey"];
    setting.randomSeed = [defaults objectForKey:@"seed_SWKey"];
    //路线id
    setting.road_id = [defaults objectForKey:@"road_idKey"];
}
-(void)saveToSandbox{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.acount forKey:@"acountKey"];
    [defaults setObject:self.password forKey:@"passwordKey"];
    [defaults setObject:self.departId forKey:@"departIdKey"];
    [defaults setObject:self.loginDepartId forKey:@"loginDepartIdKey"];
    [defaults setObject:self.departName forKey:@"departNameKey"];
    [defaults setObject:self.userRole forKey:@"userRoleKey"];
    [defaults setObject:self.userPhoneNum forKey:@"userPhoneNumKey"];
    [defaults setObject:self.userFullName forKey:@"userFullNameKey"];
    [defaults setBool:self.login            forKey:@"loginKey"];
    [defaults setBool:self.enterApplication forKey:@"enterApplicationKey"];
    //    组织机构项目选择
    [defaults setObject:self.funtype forKey:@"funtypeKey"];
    //分部分项
    [defaults setObject:self.partialName forKey:@"partialNameKey"];
    
    //权限
    [defaults setBool:self.hntchaobiaoReal   forKey:@"hntchaobiaoRealKey"];
    [defaults setBool:self.hntchaobiaoSp     forKey:@"hntchaobiaoSpKey"];
    [defaults setBool:self.syschaobiaoReal   forKey:@"syschaobiaoRealKey"];
    [defaults setBool:self.wzgcbReal   forKey:@"wzgcbRealKey"];
    
    //存储时间
    [defaults setBool:self.endTime     forKey:@"endTimeKey"];
    [defaults setBool:self.startTime   forKey:@"startTimeKey"];
    
    
    //沥青超标等级
    [defaults setObject:self.dengji forKey:@"dengjiKey"];
    //生产数据查询设备编号
    [defaults setObject:self.shebeibianhao forKey:@"shebeibianhaoKey"];
    [defaults setObject:self.bianhao forKey:@"bianhaoKey"];
    //日产量id
    [defaults setObject:self.dailyid forKey:@"dailyidKey"];
    //日产量设备编号
    [defaults setObject:self.dailysbbh forKey:@"dailysbbhKey"];
    //待处置编号，设备编号
    [defaults setObject:self.CBbianhao forKey:@"CBbianhaoKey"];
    [defaults setObject:self.CBshebeibianhao forKey:@"CBshebeibianhaoKey"];
    //沥青超标处理
    [defaults setObject:self.chuli forKey:@"chuliKey"];
    
    //生产查询筛选设备编号
    [defaults setObject:self.shebString forKey:@"shebStringKey"];
    //超标处置类型
    [defaults setObject:self.CBczlx forKey:@"CBczlxKey"];
    
    
    
    //水稳本地存贮数据
    [defaults setObject:self.biaoshi   forKey:@"biaoshi_SWKey"];
    [defaults setObject:self.userType   forKey:@"userType_SWKey"];
    [defaults setObject:self.shenehe   forKey:@"shenehe_SWKey"];
    [defaults setObject:self.chuzhi   forKey:@"chuzhi_SWKey"];
    [defaults setObject:self.zxdwshenhe   forKey:@"zxdwshenhe_SWKey"];
    //    [defaults setObject:self.zzjgName   forKey:@"zzjgName_SWKey"];
//    [defaults setObject:self.userFullName   forKey:@"userFullName_SWKey"];
    [defaults setObject:self.randomSeed   forKey:@"seed_SWKey"];
    
    //路线id
    [defaults setObject:self.road_id   forKey:@"road_idKey"];
    
    [defaults synchronize];
}

@end
