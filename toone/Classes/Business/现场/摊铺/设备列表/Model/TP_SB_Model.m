//
//  NY_SB_Model.m
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_SB_Model.h"
#import "NetworkTool.h"
#import "YYModel.h"

@implementation TP_SB_Model
-(void)sb_Block:(SB_Block_t)sb_Block {
    NSString *machineType = @"8";
    NSString *urlString = [NSString stringWithFormat:TP_SB_Data,[UserDefaultsSetting shareSetting].departId,machineType];
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        
        if ([dict[@"success"]  boolValue]) {
            NSArray *arr = dict[@"data"];
            self.arr = [NSArray yy_modelArrayWithClass:[TP_SB_Model class] json:arr];
            
            if (sb_Block) {
                sb_Block(self.arr);
            }
        }
    }];
}
@end
