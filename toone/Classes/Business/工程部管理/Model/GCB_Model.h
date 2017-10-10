//
//  GCB_Model.h
//  toone
//
//  Created by 上海同望 on 2017/8/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface GCB_Model : MyModel
@property (nonatomic,copy)NSString *parentNo;//节点编号
@property (nonatomic,strong)NSNumber* shijifangliang;//实际方量
@property (nonatomic,strong)NSNumber *shejifangliang;//
@property (nonatomic,strong)NSNumber *jindu;//进度
@property (nonatomic,strong)NSNumber *projectType;//工程类型
@property (nonatomic,copy)NSString *projectName;//工程名称
@property (nonatomic,strong)NSNumber *uesid;//

/*home*/
@property (nonatomic, copy) NSString *isrCount;//浇筑令已配料
@property (nonatomic, copy) NSString *nsrCount;//浇筑令未配料
@property (nonatomic, copy) NSString *notijiaoCount;//未提交
@property (nonatomic, copy) NSString *isshengchancount;//已完工
@property (nonatomic, copy) NSString *shengchaningCount;//生产中
@property (nonatomic, copy) NSString *userGroupId;

@end
