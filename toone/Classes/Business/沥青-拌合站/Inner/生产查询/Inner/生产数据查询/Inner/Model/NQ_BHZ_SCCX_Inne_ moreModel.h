//
//  NQ_BHZ_SCCX_Inne_ moreModel.h
//  toone
//
//  Created by shtoone on 16/12/27.
//  Copyright © 2016年 shtoone. All rights reserved.
//数据显示（核算表）

#import <Foundation/Foundation.h>
#import "MyModel.h"

@interface NQ_BHZ_SCCX_Inne__moreModel : MyModel

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

//实际比
@property (nonatomic, copy) NSString *persjf1;//粉料1
@property (nonatomic, copy) NSString *persjf2;
@property (nonatomic, copy) NSString *persjg1;//石料1
@property (nonatomic, copy) NSString *persjg2;
@property (nonatomic, copy) NSString *persjg3;
@property (nonatomic, copy) NSString *persjg4;
@property (nonatomic, copy) NSString *persjg5;
@property (nonatomic, copy) NSString *persjg6;
@property (nonatomic, copy) NSString *persjg7;
@property (nonatomic, copy) NSString *persjlq;//沥青
@property (nonatomic, copy) NSString *persjtjj;//理论添加剂

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
