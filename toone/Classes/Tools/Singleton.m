//
//  Singleton.m
//  toone
//
//  Created by 景晓峰 on 2017/10/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static  Singleton *_instance;

//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    @synchronized (self)
//    {
//        if (_instance == nil)
//        {
//            _instance = [super allocWithZone:zone];
//        }
//        return _instance;
//    }
//}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil)
        {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+ (instancetype)shareSingleton
{
    return [[self alloc] init];
}


- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}





@end
