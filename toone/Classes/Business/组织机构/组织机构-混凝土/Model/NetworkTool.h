//
//  NetworkTool.h
//  toone
//
//  Created by shtoone on 16/12/9.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "AFHTTPSessionManager.h"
typedef void(^CompleteBlock)(id result);

@interface NetworkTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;

- (void)getObjectWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock;
-(void)postObjectWithURLString:(NSString *)URLString parmas:(NSDictionary *)params  completeBlock:(CompleteBlock)completeBlock;

/**
 GET:带有参数字典
 
 @param URLString <#URLString description#>
 @param params <#params description#>
 @param completeBlock <#completeBlock description#>
 */
- (void)getObjectWithURLString:(NSString *)URLString parmas:(NSDictionary *)params completeBlock:(CompleteBlock)completeBlock;


@end
