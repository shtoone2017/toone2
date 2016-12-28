//
//  MyModel.m
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

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
