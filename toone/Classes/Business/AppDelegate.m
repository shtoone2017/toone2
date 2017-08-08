//
//  AppDelegate.m
//  toone
//
//  Created by 十国 on 16/11/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "APIKey.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

@interface AppDelegate () {
    NSString *appURLStr;
}

@end
@implementation AppDelegate
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}

- (UIInterfaceOrientationMask)application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window{
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //集成蒲公英自动更新版本
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];
    [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
    [[PgyUpdateManager sharedPgyManager] updateLocalBuildNumber];

//    if ([UserDefaultsSetting shareSetting].isEnterApplication) {
    if ([UserDefaultsSetting_SW shareSetting].isEnterApplication) {
//        if ([UserDefaultsSetting shareSetting].isLogin) {
//            id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
//            self.window.rootViewController = vc;
//        }else{
            id vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
            self.window.rootViewController = vc;
//        }
        
    }
    return YES;
}
/**
 *  检查更新回调
 *
 *  @param response 检查更新的返回结果
 */
- (void)updateMethod:(NSDictionary *)response
{
    if (response[@"downloadURL"]) {
        appURLStr = response[@"appUrl"];
        NSString *message = response[@"releaseNote"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发现新版本"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil,
                                  nil];
        
        [alertView show];
    }
    
    //    调用checkUpdateWithDelegete后可用此方法来更新本地的版本号，如果有更新的话，在调用了此方法后再次调用将不提示更新信息。
    //    [[PgyUpdateManager sharedPgyManager] updateLocalBuildNumber];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURLStr]];
}

@end
