//
//  YSRoadView.h
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YS_ZhuangHao_Model.h"
#import "YS_BianshuModel.h"
#import "YS_deviceModel.h"

#define YS_Scale 5

//起始坐标xy
#define StartPoint_x 20
#define StartPoint_y -20

//根据真实路面坐标显示在手机,乘以五倍后得到的在手机上的坐标 xy   (请求之后做手机上的展示)
#define Formula_x(a) (a+StartPoint_x)*YS_Scale
#define Formula_y(b) (b+StartPoint_y)*YS_Scale

//根据手机上的坐标来除以五,获得的真实路面上的坐标
#define Formula_GetPoint(z) z/YS_Scale

// (根据手机上的展示获得xy参数去请求)
#define Formula_min_x(a) (a+StartPoint_x)-Screen_w/2/YS_Scale
#define Formula_max_x(b) (b+StartPoint_x)+Screen_w/2/YS_Scale
#define Formula_min_y(c) (c+StartPoint_y)-Screen_h/2/YS_Scale
#define Formula_max_y(d) (d+StartPoint_y)+Screen_h/2/YS_Scale



@interface YSRoadView : UIView

@property (nonatomic,strong)NSArray *leftData;

@property (nonatomic,strong)NSArray *rightData;

@property (nonatomic,strong)NSArray *gardenData;

@property (nonatomic,strong)NSArray *bridgeData;

//遍数数组
@property (nonatomic,strong)NSArray *bianshuData;

//设备数组
@property (nonatomic,strong)NSArray *deviceData;

- (instancetype)initWithFrame:(CGRect)frame;

@end
