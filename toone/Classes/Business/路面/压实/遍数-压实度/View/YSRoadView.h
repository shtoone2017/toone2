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
#import "YS_BaojingModel.h"
#import "YS_HFModel.h"
#define YS_Scale 5


//根据真实路面坐标显示在手机,乘以五倍后得到的在手机上的坐标 xy   (请求之后做手机上的展示)
#define Formula_x(a,x) (a-x)*YS_Scale
#define Formula_y(b,y) (-b+y)*YS_Scale

//根据手机上的坐标来除以五,获得的真实路面上的坐标
#define Formula_GetPoint(z) z/YS_Scale

// (根据手机上的展示获得xy参数去请求)
#define Formula_min_x(a,x) (a+x)-Screen_w/2/YS_Scale
#define Formula_max_x(b,x) (b+x)+Screen_w/2/YS_Scale
#define Formula_min_y(c,y) (c-y)-Screen_h/2/YS_Scale
#define Formula_max_y(d,y) (d-y)+Screen_h/2/YS_Scale



@interface YSRoadView : UIView

@property (nonatomic,strong)NSArray *leftData;

@property (nonatomic,strong)NSArray *rightData;

@property (nonatomic,strong)NSArray *gardenData;

@property (nonatomic,strong)NSArray *bridgeData;

//遍数数组
@property (nonatomic,strong)NSArray *bianshuData;

//设备数组
@property (nonatomic,strong)NSArray *deviceData;

@property (nonatomic,strong) YS_BaojingModel *baojingModel;

//遍数1  压实度2
@property (nonatomic,assign)NSInteger type;

@property (nonatomic,assign)float offsetNum_x; //偏移x
@property (nonatomic,assign)float offsetNum_y; //偏移

//回放数据
@property (nonatomic,strong)NSArray *huifangArr;



- (instancetype)initWithFrame:(CGRect)frame;

@end
