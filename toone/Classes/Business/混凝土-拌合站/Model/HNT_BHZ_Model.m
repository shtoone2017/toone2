//
//  HNT_bhzModel.m
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_BHZ_Model.H"

@implementation HNT_BHZ_Model
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
