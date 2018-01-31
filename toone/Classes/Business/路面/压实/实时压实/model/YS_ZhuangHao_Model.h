//
//  YS_ZhuangHao_Model.h
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

@interface YS_ZhuangHao_Model : JSONModel

@property (nonatomic,strong) NSString *stake_name;

@property (nonatomic,strong) NSString *stake_no;

@property (nonatomic,assign) CGFloat Stake_dx;

@property (nonatomic,assign) CGFloat Stake_dy;

@property (nonatomic,assign) NSInteger stake_type;

@end
