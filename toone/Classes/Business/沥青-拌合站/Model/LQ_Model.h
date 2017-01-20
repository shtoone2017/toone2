//
//  LQ_Model.h
//  toone
//
//  Created by shtoone on 16/12/30.
//  Copyright © 2016年 shtoone. All rights reserved.
//


#import "MyModel.h"
@interface LQ_Model: MyModel
@property (nonatomic,copy) NSString *  bhjCount;//机数
@property (nonatomic,copy) NSString *   bhzCount;//站数

@property (nonatomic,copy) NSString *   panshu;//盘数
@property (nonatomic,copy) NSString *   changliang;//产量
@property (nonatomic,copy) NSString *  banhezhanminchen;//标段
@property (nonatomic,copy) NSString *   dengji;//等级
@property (nonatomic,copy) NSString *   cbps;//超标盘数
@property (nonatomic,copy) NSString *   cblv;//超标率
@property (nonatomic,copy) NSString *   reallv;//处置率

@property (nonatomic,copy) NSString *   deptId;//组织机构ID
@property (nonatomic,copy) NSString *   deptName;//组织机构名称
@property (nonatomic,copy) NSString *   shebeibianhao;//设备编号

@end
