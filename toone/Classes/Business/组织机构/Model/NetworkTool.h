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

@end
