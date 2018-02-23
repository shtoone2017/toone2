//
//  YS_BaojingModel.h
//  toone
//
//  Created by 景晓峰 on 2018/2/23.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "BaseModel.h"

@interface YS_BaojingModel : BaseModel

@property (nonatomic, strong) NSString *roadId;
@property (nonatomic, assign) double isbj;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) double smc_qy;
@property (nonatomic, assign) double smc_gy;

@property (nonatomic, assign) double zmc_qy;
@property (nonatomic, assign) double zmc_gy;

@property (nonatomic, assign) double xmc_qy;
@property (nonatomic, assign) double xmc_gy;

@property (nonatomic, assign) double smc_qy_ysd;
@property (nonatomic, assign) double smc_gy_ysd;

@property (nonatomic, assign) double zmc_qy_ysd;
@property (nonatomic, assign) double zmc_gy_ysd;

@property (nonatomic, assign) double xmc_qy_ysd;
@property (nonatomic, assign) double xmc_gy_ysd;

@end
