//
//  LLQ_SYS_Model.h
//  toone
//
//  Created by 上海同望 on 2017/6/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LLQ_SYS_Model : MyModel
@property (nonatomic,copy)NSString *banhezhanminchen;//拌合站名称
@property (nonatomic,copy)NSString *bsid;//bsid
@property (nonatomic,copy)NSString *countmxe;//马歇尔累计条数
@property (nonatomic,copy)NSString *countrhd;//软化度累计条数
@property (nonatomic,copy)NSString *countyd;//延度累计条数
@property (nonatomic,copy)NSString *countzrd;//针入度累计条数

@end
