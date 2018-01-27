//
//  HNT_sysModel.h
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"
@interface HNT_SYS_Model : MyModel
//公共属性
@property (nonatomic,copy) NSString * departName; //组织机构名称
@property (nonatomic,copy) NSString * sysCount;//试验室总数
@property (nonatomic,copy) NSString * syjCount;//试验机器总数

//私有属性
@property (nonatomic,copy) NSString * testName;//试验名称
@property (nonatomic,copy) NSString * testCount;//试验总数
@property (nonatomic,copy) NSString * notQualifiedCount;//不合格总数
@property (nonatomic,copy) NSString * realCount;//处置总数
@property (nonatomic,copy) NSString * realPer;//处置率
//
@property (nonatomic,copy) NSString * userGroupId;

-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)modelWithDict:(NSDictionary*)dict;
@end
