//
//  GCB_RWD_DetailModel.h
//  toone
//
//  Created by 上海同望 on 2017/8/20.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface GCB_RWD_DetailModel : MyModel
//执行情况
@property (nonatomic,copy)NSString *shijifangliang;//已完成方量
@property (nonatomic,copy)NSString *baifenbi;//执行进度
@property (nonatomic,copy)NSString *jihuafangliang;//计划方量
@property (nonatomic,copy)NSString *jiechao;//节超
@property (nonatomic,copy)NSString *shijipanshu;//盘数量
//修改记录
@property (nonatomic, copy) NSString *xiugairen;//name
@property (nonatomic, copy) NSString *xiugaishijian;//time
@property (nonatomic, copy) NSString *renwuno;//编号
@property (nonatomic, copy) NSString *xgtype;//

//转移记录
@property (nonatomic,copy)NSString *caozuozhe;//操作者
@property (nonatomic,copy)NSString *renwuno2;//任务单编号
@property (nonatomic,copy)NSString *fangliang;//方量
@property (nonatomic,copy)NSString *renwuno1;//原任务单编号
@property (nonatomic,copy)NSString *shijian;//操作时间
@property (nonatomic,copy)NSString *type;//0：补方 1：方量转移

@end
