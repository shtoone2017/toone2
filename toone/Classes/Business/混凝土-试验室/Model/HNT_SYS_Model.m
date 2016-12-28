//
//  HNT_sysModel.m
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SYS_Model.h"

@implementation HNT_SYS_Model


-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)modelWithDict:(NSDictionary*)dict{
    return  [[self alloc] initWithDict:dict];
}
@end
