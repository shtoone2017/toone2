//
//  SB_Model.m
//  toone
//
//  Created by shtoone on 16/12/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "SB_Model.h"
#import "NetworkTool.h"
#import "YYModel.h"

@implementation SB_Model

-(void)sb_Block:(SB_Block_t)sb_Block {
    NSString *urlString = [NSString stringWithFormat:LQ_SB_Data,[UserDefaultsSetting shareSetting].departId];
    
    //        __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        
        if ([dict[@"success"]  boolValue]) {
            NSArray *arr = dict[@"data"];
            self.arr = [NSArray yy_modelArrayWithClass:[SB_Model class] json:arr];
            
            if (sb_Block) {
                sb_Block(self.arr);
            }
        }
    }];    
}

@end
