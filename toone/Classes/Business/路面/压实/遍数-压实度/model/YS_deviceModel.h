//
//  YS_deviceModel.h
//  toone
//
//  Created by 景晓峰 on 2018/2/22.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YS_deviceModel : BaseModel
@property (nonatomic, strong) NSString *actual_time;
@property (nonatomic, assign) double Actual_angle;
@property (nonatomic, strong) NSString *road_id;
@property (nonatomic, assign) double windv;
@property (nonatomic, assign) double actual_speed;
@property (nonatomic, strong) NSString *actual_lng;
@property (nonatomic, assign) double Actual_dx;
@property (nonatomic, strong) NSString *actual_lat;
@property (nonatomic, strong) NSString *device_name;
@property (nonatomic, assign) double accetra;
@property (nonatomic, assign) double envTem;
@property (nonatomic, assign) double amplitude;
@property (nonatomic, strong) NSString *deviceCode;
@property (nonatomic, assign) double Actual_dy;
@property (nonatomic, assign) double actual_tem;
@property (nonatomic, assign) double rhPercent;
@end
