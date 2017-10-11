//
//  HNT_BHZ_SB_Model.h
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_BHZ_SB_Model : MyModel
@property (nonatomic,copy) NSString * banhezhanminchen ;// 拌合站名称
@property (nonatomic,copy) NSString * departid ;// 组织机构id
@property (nonatomic,copy) NSString * gprsbianhao ;// 设备编号

//施工队
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *useId;

//设计强度 SJQD 坍塌度 TLD 浇筑方式 JZFS
/*
 typecode true string 数据编码
 typename true string 数据名称
 */

@property (nonatomic,copy) NSString * typecode;
@property (nonatomic,copy) NSString * typename;

@end
