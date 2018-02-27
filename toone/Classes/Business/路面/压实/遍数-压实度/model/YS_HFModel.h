//
//  YS_HFModel.h
//  toone
//
//  Created by 景晓峰 on 2018/2/26.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "BaseModel.h"

@interface YS_HFModel : BaseModel
@property (nonatomic, strong) NSString *actual_time;
@property (nonatomic, assign) double Actual_dx;
@property (nonatomic, assign) double Actual_dy;
@property (nonatomic, assign) double Actual_angle;
@end
