//
//  NQ_BHZ_SCCX_InneModel.h
//  toone
//
//  Created by shtoone on 16/12/27.
//  Copyright © 2016年 shtoone. All rights reserved.
//字段名称（上段）

#import <Foundation/Foundation.h>
typedef void(^ProductionDetailsBlock_t)(NSMutableArray *result);

@interface NQ_BHZ_SCCX_InneModel : NSObject
@property (nonatomic, copy) NSString *shijian;//出料时间
@property (nonatomic, copy) NSString *sjysb;//实际油石比
@property (nonatomic, copy) NSString *llysb;//理论油石比
@property (nonatomic, copy) NSString *lqwd;//沥青温度
@property (nonatomic, copy) NSString *glwd;//石料温度
@property (nonatomic, copy) NSString *clwd;//出料温度


-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)moodWithDict:(NSDictionary*)dict;

-(void)productionDetailsBlock:(ProductionDetailsBlock_t)productionDetailsBlock;
@end
