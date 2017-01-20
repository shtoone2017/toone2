//
//  LQ_ZCL_CL_Model.h
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LQ_ZCL_CL_Model : MyModel
@property (nonatomic, copy) NSString *highPer;//低级超标率
@property (nonatomic, copy) NSString *highps;//低级超标盘数
@property (nonatomic, copy) NSString *middlePer;//中级超标率
@property (nonatomic, copy) NSString *middleps;//中级超标盘数
@property (nonatomic, copy) NSString *panshu;//盘数
@property (nonatomic, copy) NSString *primaryPer;//高级超标率
@property (nonatomic, copy) NSString *primaryps;//高级超标盘数

@property (nonatomic, copy) NSString *changliang;//产量
@property (nonatomic, copy) NSString *xa;//年
@property (nonatomic, copy) NSString *xb;
@end
