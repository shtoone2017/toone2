//
//  HNT_CBCZ_Model.h
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_CBCZ_Model : MyModel
@property (nonatomic,copy) NSString *banhezhanminchen   ;// 拌合站名称
@property (nonatomic,copy) NSString *chaozuozhe         ;// 操作者
@property (nonatomic,copy) NSString *chuli              ;// 处理与否
@property (nonatomic,copy) NSString *chuliaoshijian     ;// 出料时间
@property (nonatomic,copy) NSString *gongchengmingcheng ;// 工程名称
@property (nonatomic,copy) NSString *gongdanhao         ;// 工单号
@property (nonatomic,copy) NSString *gujifangshu        ;// 估计方数
@property (nonatomic,copy) NSString *Sid                ;// 本条数据id
@property (nonatomic,copy) NSString *jiaobanshijian     ;// 搅拌时间
@property (nonatomic,copy) NSString *jiaozuobuwei       ;// 浇筑部位
@property (nonatomic,copy) NSString *peifanghao         ;// 配方号
@property (nonatomic,copy) NSString *qiangdudengji      ;// 强度等级
@property (nonatomic,copy) NSString *shenhe             ;// 审核与否
@property (nonatomic,copy) NSString *shuinipingzhong    ;// 水泥品种
@property (nonatomic,copy) NSString *sigongdidian       ;// 施工地点
@property (nonatomic,copy) NSString *waijiajipingzhong  ;// 外加剂品种
@property (nonatomic,copy) NSString *xinxibianhao       ;// 信息编号

@property (nonatomic, copy) NSString *bianhaoId;

@end
