//
//  HNT_WNSY_DetailModel.h
//  toone
//
//  Created by 十国 on 16/12/7.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_WNSY_DetailModel : MyModel
@property (nonatomic,copy) NSString * GCMC ;//工程名称
@property (nonatomic,copy) NSString * GGZL ;// 公称直径
@property (nonatomic,copy) NSString * LZ ;// 最大力值
@property (nonatomic,copy) NSString * LZQD ;// 抗拉强度
@property (nonatomic,copy) NSString * PDJG ;// 评定及格 0.不合格 1.合格
@property (nonatomic,copy) NSString * PZBM ;// 品种
@property (nonatomic,copy) NSString * QFLZ ;// 屈服力值
@property (nonatomic,copy) NSString * QFQD ;// 屈服强度
@property (nonatomic,copy) NSString * SCL ;// 伸长率
@property (nonatomic,copy) NSString * SGBW ;// 施工部位
@property (nonatomic,copy) NSString * SJBH ;// 施件编号
@property (nonatomic,copy) NSString * SYRQ ;// 试验日期
@property (nonatomic,copy) NSString * chuli ;// 处理与否
@property (nonatomic,copy) NSString * f_GUID ;// 曲线图id 两个图，用&隔开
@property (nonatomic,copy) NSString * f_LZ ;// 图形Y轴
@property (nonatomic,copy) NSString * f_SJ ;// 图形X轴
@property (nonatomic,copy) NSString * shebeiname ;// 设备名称
@property (nonatomic,copy) NSString * testName ;// 试验名称

@property (nonatomic, copy) NSString *chuliren;
@property (nonatomic, copy) NSString *chulishijian;
@property (nonatomic, copy) NSString *chulifangshi;
@property (nonatomic, copy) NSString *wentiyuanyin;
@property (nonatomic, copy) NSString *chulijieguo;
@end
