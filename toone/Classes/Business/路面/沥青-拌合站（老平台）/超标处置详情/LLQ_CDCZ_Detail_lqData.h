//
//  SW_CDCZ_Detail_swData.h
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LLQ_CDCZ_Detail_lqData : MyModel
@property (nonatomic, copy) NSString * mbpeibi ;// string 目标配比1
@property (nonatomic, copy) NSString * name ;// string 材料名称
@property (nonatomic, copy) NSString * scpeibi ;// string 生产配比
@property (nonatomic, copy) NSString * sgpeibi ;// string 施工配比
@property (nonatomic, copy) NSString * wucha ;// string 误差
@property (nonatomic, copy) NSString * yongliang ;// string 实际生产用量
@property (nonatomic, copy) NSString * cblx;


@property (nonatomic, copy) NSString *leixing;
//粉料
@property (nonatomic, copy) NSString *sjf1;//实际值
@property (nonatomic, copy) NSString *sjf1per;//实际
@property (nonatomic, copy) NSString *llf1;//理论
@property (nonatomic, copy) NSString *sjf1wc;//误差
@property (nonatomic, copy) NSString *sjf2;
@property (nonatomic, copy) NSString *sjf2per;
@property (nonatomic, copy) NSString *llf2;
@property (nonatomic, copy) NSString *sjf2wc;

//石料
@property (nonatomic, copy) NSString *sjg1;//实际值
@property (nonatomic, copy) NSString *sjg1per;//实际
@property (nonatomic, copy) NSString *llg1;//理论
@property (nonatomic, copy) NSString *sjg1wc;//误差
@property (nonatomic, copy) NSString *sjg2;
@property (nonatomic, copy) NSString *sjg2per;
@property (nonatomic, copy) NSString *llg2;
@property (nonatomic, copy) NSString *sjg2wc;

@property (nonatomic, copy) NSString *sjg3;//实际值
@property (nonatomic, copy) NSString *sjg3per;//实际
@property (nonatomic, copy) NSString *llg3;//理论
@property (nonatomic, copy) NSString *sjg3wc;//误差
@property (nonatomic, copy) NSString *sjg4;
@property (nonatomic, copy) NSString *sjg4per;
@property (nonatomic, copy) NSString *llg4;
@property (nonatomic, copy) NSString *sjg4wc;

@property (nonatomic, copy) NSString *sjg5;//实际值
@property (nonatomic, copy) NSString *sjg5per;//实际
@property (nonatomic, copy) NSString *llg5;//理论
@property (nonatomic, copy) NSString *sjg5wc;//误差
@property (nonatomic, copy) NSString *sjg6;
@property (nonatomic, copy) NSString *sjg6per;
@property (nonatomic, copy) NSString *llg6;
@property (nonatomic, copy) NSString *sjg6wc;
@property (nonatomic, copy) NSString *sjg7;//实际值
@property (nonatomic, copy) NSString *sjg7per;//实际
@property (nonatomic, copy) NSString *llg7;//理论
@property (nonatomic, copy) NSString *sjg7wc;//误差


//油石比
@property (nonatomic, copy) NSString *sjysb;//实际值
@property (nonatomic, copy) NSString *sjysbper;//实际
@property (nonatomic, copy) NSString *llysb;//理论
@property (nonatomic, copy) NSString *sjysbwc;//误差

//沥青
@property (nonatomic, copy) NSString *sjlq;//实际值
@property (nonatomic, copy) NSString *sjlqper;//实际
@property (nonatomic, copy) NSString *lllq;//理论
@property (nonatomic, copy) NSString *sjlqwc;//误差

//添加剂
@property (nonatomic, copy) NSString *sjtjj;//实际值
@property (nonatomic, copy) NSString *sjtjjper;//实际
@property (nonatomic, copy) NSString *lltjj;//理论
@property (nonatomic, copy) NSString *sjtjjwc;//误差


@end
