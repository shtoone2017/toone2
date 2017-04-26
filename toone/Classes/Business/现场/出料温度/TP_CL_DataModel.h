//
//  TP_CL_Model.h
//  toone
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface TP_CL_DataModel : MyModel
@property (nonatomic,copy) NSString * tempRowNumber ;// number
@property (nonatomic,copy) NSString * tmpshijian ;// string 出料时间
@property (nonatomic,copy) NSString * tmpdata ;// string 出料温度
@property (nonatomic,copy) NSString * tmpid ;// number 编号
@property (nonatomic,copy) NSString * banhezhanminchen ;// string 拌合站名称
@property (nonatomic,copy) NSString * tempColumn ;// number
@end
