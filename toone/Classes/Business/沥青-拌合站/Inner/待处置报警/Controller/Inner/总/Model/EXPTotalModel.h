//
//  EXPTotalModel.h
//  toone
//
//  Created by shtoone on 16/12/26.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXPTotalModel : NSObject
//字段名
//@property (nonatomic, copy) NSString *shijian;//出料时间
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

//数据展示
@property (nonatomic, strong) NSNumber *bianhao;//编号
@property (nonatomic, copy) NSString *shijian;//出料时间
@property (nonatomic, copy) NSString *wsjf1;     //粉料1
@property (nonatomic, copy) NSString *wsjf2;
@property (nonatomic, copy) NSString *wsjg1;     //石料1
@property (nonatomic, copy) NSString *wsjg2;
@property (nonatomic, copy) NSString *wsjg3;
@property (nonatomic, copy) NSString *wsjg4;
@property (nonatomic, copy) NSString *wsjg5;
@property (nonatomic, copy) NSString *wsjg6;
@property (nonatomic, copy) NSString *wsjg7;
@property (nonatomic, copy) NSString *wsjlq;//沥青
@property (nonatomic, copy) NSString *wsjtjj;//添加剂
@property (nonatomic, copy) NSString *wsjysb;//油石比
@property (nonatomic, copy) NSString *chuli;//是否处理（1，0）

@end
