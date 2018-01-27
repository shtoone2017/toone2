//
//  SW_CBCZ_Detail_swjg.h
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface SW_LSSJ_Detail_Chart : MyModel

@property (nonatomic, copy) NSString * maxPassper ;// string 允许波动上限
@property (nonatomic, copy) NSString * minPassper ;// string 允许波动下限
@property (nonatomic, copy) NSString * name ;// string 筛选率 X轴
@property (nonatomic, copy) NSString * passper ;// string 实际级配
@property (nonatomic, copy) NSString * standPassper ;// string 标准级配
@property (nonatomic, copy) NSString * yjsx ;// string 预警上限
@property (nonatomic, copy) NSString * yjxx ;// string 预警下限
@property (nonatomic, copy) NSString * wcz ;// string 误差值 （用于表格）
@property (nonatomic, copy) NSString * yjz ;// string 预警区间 （用于表格）
@end
