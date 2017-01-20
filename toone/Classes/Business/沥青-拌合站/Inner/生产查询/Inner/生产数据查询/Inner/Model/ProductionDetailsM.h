//
//  ProductionDetailsM.h
//  toone
//
//  Created by shtoone on 16/12/27.
//  Copyright © 2016年 shtoone. All rights reserved.
//数据显示（上段）

#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface ProductionDetailsM : MyModel
//油石比
@property (nonatomic, copy) NSString *shijian;//时间
@property (nonatomic, copy) NSString *sjysb;//实际用量
@property (nonatomic, copy) NSString *llysb;//配比(理论）
@property (nonatomic, copy) NSString *wsjysb;//误差率
@property (nonatomic, copy) NSString *lqwd;//沥青温度
@property (nonatomic, copy) NSString *glwd;//石料温度
@property (nonatomic, copy) NSString *clwd;//出料温度

@end


