//
//  NQ_BHZ_SCCX_InneModel.m
//  toone
//
//  Created by shtoone on 16/12/27.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NQ_BHZ_SCCX_InneModel.h"
#import "NetworkTool.h"

@implementation NQ_BHZ_SCCX_InneModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)moodWithDict:(NSDictionary*)dict{
    return  [[self alloc] initWithDict:dict];
}

-(void)productionDetailsBlock:(ProductionDetailsBlock_t)productionDetailsBlock {
   NSString *shebeiStr = [UserDefaultsSetting shareSetting].shebeibianhao;
    NSNumber *bianhaoBer = [UserDefaultsSetting shareSetting].bianhao;
    NSString *urlString = [NSString stringWithFormat:ProductionDetails,shebeiStr,bianhaoBer];
//      __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
            NSMutableArray * datas = [NSMutableArray array];
            NSDictionary *dict = (NSDictionary *)result;
        
        if (dict[@"success"]) {
                [datas addObject: [NQ_BHZ_SCCX_InneModel moodWithDict:dict[@"data"]]];
            
                [datas addObject: [NQ_BHZ_SCCX_InneModel moodWithDict:dict[@"Fields"]]];
            
            if (productionDetailsBlock) {
                productionDetailsBlock(datas);
            }
            }
        
        }
    ];
    
}

@end
