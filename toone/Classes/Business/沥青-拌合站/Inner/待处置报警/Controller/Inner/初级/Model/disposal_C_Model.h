//
//  disposal_C_Model.h
//  toone
//
//  Created by shtoone on 16/12/30.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface disposal_C_Model : MyModel
//字段名
@property (nonatomic, copy) NSString *shijian;//出料时间
@property (nonatomic, copy) NSString *sjf1;     //粉料1
@property (nonatomic, copy) NSString *sjf2;
@property (nonatomic, copy) NSString *sjg1;     //石料1
@property (nonatomic, copy) NSString *sjg2;
@property (nonatomic, copy) NSString *sjg3;
@property (nonatomic, copy) NSString *sjg4;
@property (nonatomic, copy) NSString *sjg5;
@property (nonatomic, copy) NSString *sjg6;
@property (nonatomic, copy) NSString *sjg7;
@property (nonatomic, copy) NSString *sjlq;//沥青
@property (nonatomic, copy) NSString *sjtjj;//添加剂
@property (nonatomic, copy) NSString *sjysb;//油石比
@property (nonatomic, copy) NSString *bh;//编号

@end
