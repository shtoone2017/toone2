//
//  HNT_CLHS_Model.h
//  toone
//
//  Created by 十国 on 2016/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LLQ_CLHS_Model : MyModel

@property (nonatomic,copy) NSString * mbpeibi ;// string 理论用量
@property (nonatomic,copy) NSString * name ;// string 材料名称
@property (nonatomic,copy) NSString * scpeibi ;// string 没用
@property (nonatomic,copy) NSString * sgpeibi ;// string 没用
@property (nonatomic,copy) NSString * wucha ;// string 误差值
@property (nonatomic,copy) NSString * yongliang ;// string 用量

@property (nonatomic, copy) NSString *banhezhanminchen;//
@property (nonatomic, copy) NSString *shijian;
@property (nonatomic, copy) NSString *sjysb;//油石比
@property (nonatomic, copy) NSString *jbsj;//搅拌时间
@property (nonatomic, copy) NSString *sjg1;

@property (nonatomic, copy) NSString *detaId;

@end
