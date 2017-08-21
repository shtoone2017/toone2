//
//  GCB_RWD_HeadModel.h
//  toone
//
//  Created by 上海同望 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface GCB_RWD_HeadModel : MyModel
//基本信息
@property (nonatomic,copy)NSString *departName;//所属机构
@property (nonatomic,copy)NSString *jzbw;//浇筑部位
@property (nonatomic,copy)NSString *gcmc;//工程名称
@property (nonatomic,copy)NSString *jiaozhufangshi;//浇筑方式
@property (nonatomic,copy)NSString *jihuafangliang;//计划方量
@property (nonatomic,copy)NSString *shuinibiaohao;//设计强度
@property (nonatomic,copy)NSString *kaipanriqi;//开盘日期
@property (nonatomic,copy)NSString *renwuno;//任务编号
@end
