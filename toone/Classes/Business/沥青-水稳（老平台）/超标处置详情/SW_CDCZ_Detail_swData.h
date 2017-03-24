//
//  SW_CDCZ_Detail_swData.h
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface SW_CDCZ_Detail_swData : MyModel
@property (nonatomic, copy) NSString * mbpeibi ;// string 目标配比
@property (nonatomic, copy) NSString * name ;// string 材料名称
@property (nonatomic, copy) NSString * scpeibi ;// string 生产配比
@property (nonatomic, copy) NSString * sgpeibi ;// string 施工配比
@property (nonatomic, copy) NSString * wucha ;// string 误差
@property (nonatomic, copy) NSString * yongliang ;// string 实际生产用量
@end
