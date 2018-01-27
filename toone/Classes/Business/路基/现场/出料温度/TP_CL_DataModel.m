
//
//  TP_CL_Model.m
//  toone
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_CL_DataModel.h"

@implementation TP_CL_DataModel
/*
 @property (nonatomic,copy) NSString * tempRowNumber ;// number
 @property (nonatomic,copy) NSString * tmpshijian ;// string 出料时间
 @property (nonatomic,copy) NSString * tmpdata ;// string 出料温度
 @property (nonatomic,copy) NSString * tmpid ;// number 编号
 @property (nonatomic,copy) NSString * banhezhanminchen ;// string 拌合站名称
 @property (nonatomic,copy) NSString * tempColumn ;// number
 */
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.tempRowNumber = Format(dict[@"tempRowNumber"]);
        self.tmpid = Format(dict[@"tmpid"]);
        self.tempColumn = Format(dict[@"tempColumn"]);
    }
    return self;
}
@end
