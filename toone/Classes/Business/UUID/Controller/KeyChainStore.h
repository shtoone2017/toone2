//
//  KeyChainStore.h
//  toone
//
//  Created by 上海同望 on 2017/5/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
