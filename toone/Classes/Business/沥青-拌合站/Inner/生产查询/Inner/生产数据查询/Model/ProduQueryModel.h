//
//  ProduQueryModel.h
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface ProduQueryModel : MyModel
@property (nonatomic, strong) NSNumber *bianhao;//编号
@property (nonatomic, copy) NSString *deptId; //组织机构id
@property (nonatomic, copy) NSString *shebeibianhao;//设备编号

@property (nonatomic, copy) NSString *clwd;//出料温度
@property (nonatomic, copy) NSString *shijian;//时间
@property (nonatomic, copy) NSString *sjlq;//沥青量
@property (nonatomic, copy) NSString *sjysb; //油石比

@property (nonatomic, strong) NSArray *arr;

@end
