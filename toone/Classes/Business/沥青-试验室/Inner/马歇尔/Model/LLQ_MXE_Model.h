//
//  LLQ_MXE_Model.h
//  toone
//
//  Created by 上海同望 on 2017/6/3.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LLQ_MXE_Model : MyModel
//@property (nonatomic ,strong) NSDictionary * dataDict;

@property (nonatomic,copy)NSString *is_testtime;//试验时间
@property (nonatomic,copy)NSString *isQualified;//是否合格
@property (nonatomic,copy)NSString *SHeader2;//部位
@property (nonatomic,copy)NSString *header5;//样品编号
@property (nonatomic,copy)NSString *header3;//工程名称
@property (nonatomic,copy)NSString *f_GUID;//实验id
@property (nonatomic,copy)NSString *f_SBBH;//设备编号

@property (nonatomic,copy)NSString *avgvalue2;//稳定度均值
@property (nonatomic,copy)NSString *avgvalue1;//流均值
@property (nonatomic,copy)NSString *biaoZhun1;//标准值1
@property (nonatomic,copy)NSString *biaoZhun2;
@property (nonatomic,copy)NSString *biaoZhun3;

@property (nonatomic,copy)NSString *ruanhuadian1;//软化度1
@property (nonatomic,copy)NSString *ruanhuadian2;//

@property (nonatomic,copy)NSString *zhenrudu;//针入度



@end
