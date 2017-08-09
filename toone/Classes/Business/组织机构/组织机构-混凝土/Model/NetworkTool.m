//
//  NetworkTool.m
//  toone
//
//  Created by shtoone on 16/12/9.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

static NetworkTool *_instance;

+ (instancetype)sharedNetworkTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (void)getObjectWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock{
    [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (completeBlock) {
//            completeBlock(error);
//        }
    }];
}

-(void)postObjectWithURLString:(NSString *)URLString parmas:(NSDictionary *)params  completeBlock:(CompleteBlock)completeBlock{
    [self POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (completeBlock) {
//            completeBlock(error);
//        }
    }];
}


/**
 GET:带有参数字典

 @param URLString <#URLString description#>
 @param params <#params description#>
 @param completeBlock <#completeBlock description#>
 */
- (void)getObjectWithURLString:(NSString *)URLString parmas:(NSDictionary *)params completeBlock:(CompleteBlock)completeBlock{
    [self GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}


@end
