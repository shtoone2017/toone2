//
//  GCB_JZL_Model.h
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface GCB_JZL_Model : MyModel
@property (nonatomic,copy)NSString *baifenbi;//执行进度
@property (nonatomic,copy)NSString *shijifangliang;//实耗方量
@property (nonatomic,copy)NSString *jzbw;//浇筑部位
@property (nonatomic,copy)NSString *gcmc;//工程名称
@property (nonatomic,copy)NSString *jihuafangliang;//计划方量
@property (nonatomic,copy)NSString *jiechao;//节超
@property (nonatomic,copy)NSString *sgphbno;//配比通知单号
@property (nonatomic,copy)NSString *shuinibiaohao;//强度等级
@property (nonatomic,copy)NSString *kaipanriqi;//开盘日期
@property (nonatomic,copy)NSString *zhuangtai;//状态
@property (nonatomic,copy)NSString *renwuno;//任务单编号
@property (nonatomic,copy)NSString *shejifangliang;//设计方量
@property (nonatomic,copy)NSString *createtime;//创建时间
@property (nonatomic,copy)NSString *createperson;//创建人

@property (nonatomic,copy)NSString *rwdId;//任务单跳转(编辑)
@end
