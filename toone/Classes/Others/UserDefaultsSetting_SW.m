//
//  LightweightData.m
//  toone
//
//  Created by 十国 on 16/11/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "UserDefaultsSetting_SW.h"

@implementation UserDefaultsSetting_SW
+(instancetype)shareSetting{
    return [[self alloc] init];
}


static UserDefaultsSetting_SW * setting = nil;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting = [super allocWithZone:zone];
        [setting getFromSandbox];
    });
    return setting;
}

-(void)getFromSandbox{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    setting.acount   = [defaults objectForKey:@"acount_SWKey"];
    setting.password = [defaults objectForKey:@"password_SWKey"];
    setting.login    = [defaults boolForKey:@"login_SWKey"];
    setting.enterApplication = [defaults boolForKey:@"enterApplication_SWKey"];
    //存储时间
    setting.startTime = [defaults objectForKey:@"startTime_SWKey"];
    setting.endTime   = [defaults objectForKey:@"endTime_SWKey"];
    
//水稳本地存贮数据
    setting.biaoshi   = [defaults objectForKey:@"biaoshi_SWKey"];
    setting.userType   = [defaults objectForKey:@"userType_SWKey"];
    setting.shenehe   = [defaults objectForKey:@"shenehe_SWKey"];
//    setting.zzjgName   = [defaults objectForKey:@"zzjgName_SWKey"];
    
}
-(void)saveToSandbox{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.acount forKey:@"acount_SWKey"];
    [defaults setObject:self.password forKey:@"password_SWKey"];
    [defaults setBool:self.login            forKey:@"login_SWKey"];
    [defaults setBool:self.enterApplication forKey:@"enterApplication_SWKey"];
    //存储时间
    [defaults setObject:self.endTime     forKey:@"endTime_SWKey"];
    [defaults setObject:self.startTime   forKey:@"startTime_SWKey"];
    
    
//水稳本地存贮数据
    [defaults setObject:self.biaoshi   forKey:@"biaoshi_SWKey"];
    [defaults setObject:self.userType   forKey:@"userType_SWKey"];
    [defaults setObject:self.shenehe   forKey:@"shenehe_SWKey"];
//    [defaults setObject:self.zzjgName   forKey:@"zzjgName_SWKey"];
    
    
    
    
    
    
    
    [defaults synchronize];
}

@end
