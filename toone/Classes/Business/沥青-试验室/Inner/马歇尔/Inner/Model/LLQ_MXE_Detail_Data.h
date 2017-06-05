//
//  LLQ_MXE_Detail_Data.h
//  toone
//
//  Created by 上海同望 on 2017/6/5.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LLQ_MXE_Detail_Data : MyModel
@property (nonatomic,copy)NSString *avgvalue2;//稳定度均值
@property (nonatomic,copy)NSString *avgvalue1;//流均值
@property (nonatomic,copy)NSString *biaoZhun1;//标准值1
@property (nonatomic,copy)NSString *biaoZhun2;
@property (nonatomic,copy)NSString *biaoZhun3;//稳定值范围
@property (nonatomic,copy)NSString *liuzhi;//流值
@property (nonatomic,copy)NSString *wendingdu;//稳定值

@end
