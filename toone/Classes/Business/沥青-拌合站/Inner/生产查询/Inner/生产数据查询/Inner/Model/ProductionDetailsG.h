//
//  ProductionDetailsG.h
//  toone
//
//  Created by shtoone on 16/12/27.
//  Copyright © 2016年 shtoone. All rights reserved.
//字段显示（核算表）

#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface ProductionDetailsG : MyModel
//材料名称
@property (nonatomic, copy) NSString *sjf1;//粉料1
@property (nonatomic, copy) NSString *sjf2;
@property (nonatomic, copy) NSString *sjg1;//石料1
@property (nonatomic, copy) NSString *sjg2;
@property (nonatomic, copy) NSString *sjg3;
@property (nonatomic, copy) NSString *sjg4;
@property (nonatomic, copy) NSString *sjg5;
@property (nonatomic, copy) NSString *sjg6;
@property (nonatomic, copy) NSString *sjg7;
@property (nonatomic, copy) NSString *sjlq;//沥青
@property (nonatomic, copy) NSString *sjtjj;//添加剂

@end
