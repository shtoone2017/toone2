//
//  AppDelegate.m
//  toone
//
//  Created by 十国 on 16/11/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIInterfaceOrientationMask)application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


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


@end
