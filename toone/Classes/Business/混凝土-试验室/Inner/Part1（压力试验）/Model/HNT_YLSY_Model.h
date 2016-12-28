//
//  HNT_YLSY_Model.h
//  toone
//
//  Created by 十国 on 16/11/30.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_YLSY_Model : MyModel

@property (nonatomic,copy) NSString * SYRQ;

@property (nonatomic,copy) NSString * SJBH;
@property (nonatomic,copy) NSString * SJQD;
@property (nonatomic,copy) NSString * QDDBZ;

@property (nonatomic,copy) NSString * GCMC;
@property (nonatomic,copy) NSString * SGBW;
@property (nonatomic,copy) NSString * testName;
@property (nonatomic,copy) NSString * shebeiname;

@property (nonatomic,copy) NSString * PDJG;
@property (nonatomic,copy) NSString * chuzhi;

@property (nonatomic,copy) NSString * SYJID;// 试验机id
/*
 GCMC true string 工程名称
 PDJG true string 评定及格 0.不合格 1.合格 2.有效 3.无效
 QDDBZ true string 强度代表值
 SGBW true string 施工部位
 SJBH true string 试件编号
 SJQD true string 设计强度
 SYJID true string 试验机id
 SYRQ true string 试验日期
 chuzhi true string 0.未处置 1.已处置
 shebeiname true string 设备名称
 testName true string 试验名称
 */

@end
