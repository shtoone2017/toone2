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
    
}
-(void)saveToSandbox{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.acount forKey:@"acount_SWKey"];
    [defaults setObject:self.password forKey:@"password_SWKey"];
    [defaults setBool:self.login            forKey:@"login_SWKey"];
    [defaults setBool:self.enterApplication forKey:@"enterApplication_SWKey"];
    //存储时间
    [defaults setBool:self.endTime     forKey:@"endTime_SWKey"];
    [defaults setBool:self.startTime   forKey:@"startTime_SWKey"];
    
    
//水稳本地存贮数据
    [defaults setBool:self.biaoshi   forKey:@"biaoshi_SWKey"];
    [defaults setBool:self.userType   forKey:@"userType_SWKey"];
    
    
    
    
    
    
    
    [defaults synchronize];
}

@end
