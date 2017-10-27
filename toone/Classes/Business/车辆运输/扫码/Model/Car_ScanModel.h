//
//  Car_ScanModel.h
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"
#import "YYModel.h"

@interface Car_ScanModel : MyModel<NSCoding, NSCopying>
@property (nonatomic,copy) NSString *orderStatus;//单子状态
@property (nonatomic,copy) NSString *outsideStatus;//外面的状态
@property (nonatomic, copy) NSString *JZLBH;//浇筑令编号
@property (nonatomic, copy) NSString *BHZMC;//拌合站
@property (nonatomic, copy) NSString *GCMC;//工程名称
@property (nonatomic, copy) NSString *SGBW;//施工部位
@property (nonatomic, copy) NSString *FCDBH;//发车单编号
@property (nonatomic, copy) NSString *XLWZ;//卸料位置
@property (nonatomic, copy) NSString *BHZBH;//拌合站编号
@property (nonatomic, copy) NSString *loation;//坐标

@property (nonatomic, copy) NSString *QDDJ;
@property (nonatomic, copy) NSString *TLD;
@property (nonatomic, copy) NSString *SJFL;
@property (nonatomic, copy) NSString *BCFL;
@property (nonatomic, copy) NSString *CH;
@property (nonatomic, copy) NSString *FCR;
@property (nonatomic, copy) NSString *FCSJ;
@property (nonatomic, copy) NSString *BZ;
@property (nonatomic, copy) NSString *SCRQ;
@property (nonatomic, copy) NSString *PHBBH;
@property (nonatomic, copy) NSString *LJCC;
@property (nonatomic, copy) NSString *SJ;
@property (nonatomic, copy) NSString *QSSJ;
@property (nonatomic, copy) NSString *QSR;


@property (nonatomic,copy) NSString * QS_img;
@property (nonatomic,copy) NSString * JS_img;
@property (nonatomic,copy) NSString * QSFL;
@property (nonatomic,copy) NSString * JSYY;
@property (nonatomic,copy) NSString * JSYYLX;
@property (nonatomic,copy) NSString * JSBZ;


@end
