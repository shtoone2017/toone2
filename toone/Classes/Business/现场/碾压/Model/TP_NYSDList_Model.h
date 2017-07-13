//
//  TP_NYSD_Model.h
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface TP_NYSDList_Model : MyModel
//速度
@property (nonatomic) NSNumber *tempRowNumber;
@property (nonatomic) NSNumber *tempColumn;
@property (nonatomic, assign) NSNumber *gpsid;//数据id
@property (nonatomic, copy) NSString *sudu;
@property (nonatomic, copy) NSString *shijian;
@property (nonatomic, copy) NSString *banhezhanminchen;//拌和站名称
//温度
@property (nonatomic,copy)NSString *tmpsudu;//速度
@property (nonatomic, copy) NSString *tmpshijian;//时间
@property (nonatomic, copy) NSString *tmpdata;//温度

@property (nonatomic,copy)NSString *tmpno;//设备编号


@end
