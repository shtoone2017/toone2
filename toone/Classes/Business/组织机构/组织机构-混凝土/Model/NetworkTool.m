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
//        NSLog(@"failure === %@",[error localizedDescription]);
    }];
}

-(void)postObjectWithURLString:(NSString *)URLString parmas:(NSDictionary *)params  completeBlock:(CompleteBlock)completeBlock{
    [self POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"错误 --> %@",[error localizedDescription]);
//        [Tools tip:@"网络故障，提交失败"];
    }];
}

@end
