//
//  HNT_CBCZ_Detail_HeadMsg.h
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_CBCZ_Detail_HeadMsg : MyModel


@property (nonatomic,copy) NSString *  banhezhanminchen ;//  拌合站名称
@property (nonatomic,copy) NSString *  chaozuozhe ;//  操作者
@property (nonatomic,copy) NSString *  chuli ;//  处理与否
@property (nonatomic,copy) NSString *  chuliaoshijian ;//  出料时间
@property (nonatomic,copy) NSString *  gongchengmingcheng ;//  工程名称
@property (nonatomic,copy) NSString *  gongdanhao ;//  工单号
@property (nonatomic,copy) NSString *  gujifangshu ;//  估计方数
@property (nonatomic,copy) NSString *  SId ;//  id
@property (nonatomic,copy) NSString *  jiaobanshijian ;//  搅拌时间
@property (nonatomic,copy) NSString *  jiaozuobuwei ;//  浇筑部位
@property (nonatomic,copy) NSString *  peifanghao ;//  配方号
@property (nonatomic,copy) NSString *  qiangdudengji ;//  强度等级
@property (nonatomic,copy) NSString *  shenhe ;//  审核
@property (nonatomic,copy) NSString *  shuinipingzhong ;//  水泥品种
@property (nonatomic,copy) NSString *  sigongdidian ;//  施工地点
@property (nonatomic,copy) NSString *  waijiajipingzhong ;//  外加剂品种
@property (nonatomic,copy) NSString *  xinxibianhao ;//  信息编号


@property (nonatomic,copy) NSString *  chuzhifangshi ;//  处置：处理方式
@property (nonatomic,copy) NSString *  chulijieguo ;//  处置：处理结果
@property (nonatomic,copy) NSString *  chuliren ;//  处置：处理人
@property (nonatomic,copy) NSString *  chulishijian ;//  处置：处理时间
@property (nonatomic,copy) NSString *  wentiyuanyin ;//  处置：处置原因
@property (nonatomic,copy) NSString *  filePath ;//  处置：
@property (nonatomic, copy) NSString *filepath;//路径

@property (nonatomic, copy) NSString *chuzhishijian;//超标处置时间
@property (nonatomic, copy) NSString *chuzhiren;//超标处置人
@property (nonatomic, copy) NSString *chaobiaoyuanyin;//沥青超标原因

@property (nonatomic,copy) NSString *  confirmdate ;//  审批：确认时间
@property (nonatomic,copy) NSString *  jianliresult ;//  审批：监理结果
@property (nonatomic,copy) NSString *  jianlishenpi ;//  审批：监理审批
@property (nonatomic,copy) NSString *  shenpidate ;//  审批：审批时间
@property (nonatomic,copy) NSString *  shenpiren ;//  审批：审批人
@end
