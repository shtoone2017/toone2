//
//  YS_SB_Model.h
//  toone
//
//  Created by 上海同望 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface YS_SB_Model : MyModel
/*压实*/
@property (nonatomic, strong) NSNumber *stake_no;//桩号
@property (nonatomic, copy) NSString *stake_name;

@property (nonatomic, copy) NSString *road_name;//路线名称
@property (nonatomic, copy) NSString *roadId;//路线ID

@property (nonatomic, copy) NSString *mcName;//面层
@property (nonatomic, copy) NSString *mcNum;


@property (nonatomic, copy) NSString *device_name;//
@property (nonatomic, copy) NSString *device_code;//
@end
