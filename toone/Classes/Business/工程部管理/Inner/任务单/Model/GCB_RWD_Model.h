//
//  GCB_RWD_Model.h
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface GCB_RWD_Model : MyModel
@property (nonatomic,copy)NSString *departname;//所属机构
@property (nonatomic,copy)NSString *createTime;//创建时间
@property (nonatomic,copy)NSString *renwuNo;//任务单编号
@property (nonatomic,copy)NSString *jiaozhufangshi;//浇筑方式

@property (nonatomic,strong) NSNumber *baifenbi;//任务完成百分比
@property (nonatomic,copy)NSString *gcmc;//工程名称
@property (nonatomic,copy)NSString *departId;//组织机构id
@property (nonatomic,copy)NSString *jzbw;//浇筑部位
@property (nonatomic,copy)NSString *jihuafangliang;//计划方量
@property (nonatomic,strong) NSNumber *jiechao;//节超
@property (nonatomic,copy)NSString *shuinibiaohao;//强度等级
@property (nonatomic,copy)NSString *kaipanriqi;//开盘时间
@property (nonatomic,strong) NSNumber *shijifangliang;//实耗方量
@property (nonatomic,copy)NSString *zhuangtai;//生产状态 0:未配料 1：已配料 2：生产中 3：已完成
@property (nonatomic,copy)NSString *sgphbNo;//配比通知单号

@end
