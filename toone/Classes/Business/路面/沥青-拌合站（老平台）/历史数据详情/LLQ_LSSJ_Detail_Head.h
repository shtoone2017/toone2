//
//  SW_CBCZ_Detail_swHead.h
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LLQ_LSSJ_Detail_Head : MyModel

//历史数据
@property (nonatomic, copy) NSString * bhjName ;// string 拌和机名称
@property (nonatomic, copy) NSString * caijishijian ;// string 采集时间
@property (nonatomic, copy) NSString * chuliaoshijian ;// string 出料时间
@property (nonatomic, copy) NSString * cl ;// string 每锅产量

//材料核算
@property (nonatomic, copy) NSString *banhezhanminchen;
//@property (nonatomic, copy) NSString *caijishijian1;
@property (nonatomic, copy) NSString *shijian;
@property (nonatomic, copy) NSString *changliang;


@end
