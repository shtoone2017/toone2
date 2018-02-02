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
#define YS_Scale 2

@interface YSRoadView : UIView

@property (nonatomic,strong)NSArray *leftData;

@property (nonatomic,strong)NSArray *rightData;

@property (nonatomic,strong)NSArray *gardenData;

@property (nonatomic,strong)NSArray *bridgeData;

//遍数数组
@property (nonatomic,strong)NSArray *bianshuData;

- (instancetype)initWithFrame:(CGRect)frame;

@end
