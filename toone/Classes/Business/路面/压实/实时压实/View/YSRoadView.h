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
#define YS_Scale 5

#define StartPoint_x self.frame.origin.x
#define StartPoint_y self.frame.origin.y
#define Formula(a) (a+StartPoint_x)*YS_Scale
#define Formula_GetPoint(a) a/YS_Scale

@interface YSRoadView : UIView

@property (nonatomic,strong)NSArray *leftData;

@property (nonatomic,strong)NSArray *rightData;

@property (nonatomic,strong)NSArray *gardenData;

@property (nonatomic,strong)NSArray *bridgeData;

//遍数数组
@property (nonatomic,strong)NSArray *bianshuData;

- (instancetype)initWithFrame:(CGRect)frame;

@end
