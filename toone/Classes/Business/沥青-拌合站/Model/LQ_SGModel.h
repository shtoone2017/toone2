//
//  LQ_SGModel.h
//  toone
//
//  Created by sg on 2017/4/24.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LQ_SGModel : MyModel
@property (nonatomic,copy) NSString* dailycl ;// string 每日产量
@property (nonatomic,strong) NSNumber* zcbps ;// number 总超标盘数
@property (nonatomic,strong) NSNumber* czps ;// number 处置盘数
@property (nonatomic,copy) NSString* dailyps ;// string 每日盘数
@property (nonatomic,copy) NSString* panshu ;// string 总盘数
@property (nonatomic,strong) NSNumber* dczps ;// number 待处置盘数
@property (nonatomic,strong) NSNumber* cblv ;// number 超标处置率
@property (nonatomic,copy) NSString* ljchangliang ;// string 总产量
@end
