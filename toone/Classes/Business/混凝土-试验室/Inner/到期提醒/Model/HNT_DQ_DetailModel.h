//
//  HNT_DQ_DetailModel.h
//  toone
//
//  Created by 上海同望 on 2018/1/10.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_DQ_DetailModel : MyModel
@property (nonatomic,strong) NSNumber *lq;
@property (nonatomic, copy) NSString *endTime;//试验结束时间
@property (nonatomic, copy) NSString *gcmc;
@property (nonatomic, copy) NSString *xiangmubuminchen;//试验室
@property (nonatomic, copy) NSString *sgbw;//浇筑部位
@property (nonatomic, copy) NSString *sjqd;//强度
@property (nonatomic, copy) NSString *startTime;//开始时间


@end
