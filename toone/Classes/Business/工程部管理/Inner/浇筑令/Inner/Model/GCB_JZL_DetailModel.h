//
//  GCB_JZL_DetailModel.h
//  toone
//
//  Created by 上海同望 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface GCB_JZL_DetailModel : MyModel
@property (nonatomic,copy)NSString *departname;//所属机构
@property (nonatomic,copy)NSString *departid;//组织机构id
@property (nonatomic,copy)NSString *jzbw;//浇筑部位
@property (nonatomic,copy)NSString *jiaozhufangshi;//浇筑方式
@property (nonatomic,copy)NSString *tanluodu;//坍落度
@property (nonatomic,copy)NSString *remark;//备注
@property (nonatomic,copy)NSString *jihuafangliang;//计划方量
@property (nonatomic,copy)NSString *createperson;//创建人
@property (nonatomic,copy)NSString *kaipanriqi;//开盘日期
@property (nonatomic,copy)NSString *createtime;//创建时间
@property (nonatomic,copy)NSString *gcmc;//工程名称
@property (nonatomic,copy)NSString *renwuno;//任务编号
@property (nonatomic,copy)NSString *org_code;//
@property (nonatomic,copy)NSString *kangdongdengji;//抗冻等级
@property (nonatomic,copy)NSString *kangshendengji;//抗滲等级
@property (nonatomic,copy)NSString *shuinibiaohao;//设计强度

@property (nonatomic,strong) NSNumber *tjId;//编辑id
@property (nonatomic, copy) NSString *shigongteamid;//施工队id
@property (nonatomic, copy) NSString *shigongteamname;//施工队

@end
