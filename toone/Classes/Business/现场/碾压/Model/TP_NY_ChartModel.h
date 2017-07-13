//
//  TP_NY_ChartModel.h
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface TP_NY_ChartModel : MyModel
@property (nonatomic, copy) NSString *sudu;
@property (nonatomic, copy) NSString *shijian;
@property (nonatomic, copy) NSString *wendu;

@property (nonatomic,copy)NSString *tmpshijian;//时间
@property (nonatomic,copy)NSString *tmpdata;//温度
@property (nonatomic,copy)NSString *tmpsudu;//速度
@end
