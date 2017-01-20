//
//  LQ_CLHS_DataModel.h
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LQ_CLHS_DataModel : MyModel
//配比
@property (nonatomic, copy) NSString *llf1;//粉料1
@property (nonatomic, copy) NSString *llf2;
@property (nonatomic, copy) NSString *llg1;//石料1
@property (nonatomic, copy) NSString *llg2;
@property (nonatomic, copy) NSString *llg3;
@property (nonatomic, copy) NSString *llg4;
@property (nonatomic, copy) NSString *llg5;
@property (nonatomic, copy) NSString *llg6;
@property (nonatomic, copy) NSString *llg7;
@property (nonatomic, copy) NSString *lllq;//沥青
@property (nonatomic, copy) NSString *lltjj;//添加剂

//实际用量
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

//误差率
@property (nonatomic, copy) NSString *wsjf1;//粉料1
@property (nonatomic, copy) NSString *wsjf2;
@property (nonatomic, copy) NSString *wsjg1;//石料1
@property (nonatomic, copy) NSString *wsjg2;
@property (nonatomic, copy) NSString *wsjg3;
@property (nonatomic, copy) NSString *wsjg4;
@property (nonatomic, copy) NSString *wsjg5;
@property (nonatomic, copy) NSString *wsjg6;
@property (nonatomic, copy) NSString *wsjg7;
@property (nonatomic, copy) NSString *wsjlq;//沥青
@property (nonatomic, copy) NSString *wsjtjj;//添加剂

@end
