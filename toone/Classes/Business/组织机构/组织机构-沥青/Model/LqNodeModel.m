//
//  LqNodeModel.m
//  toone
//
//  Created by shtoone on 16/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LqNodeModel.h"
#import "YYModel.h"
#import "NetworkTool.h"

@implementation LqNodeModel

-(void)lqNodeBlock:(LqNodeBlock)lqNodeBlock {
    NSString *dataTime = [SGDate getDay];
    
    NSString *loginDepartId = [UserDefaultsSetting shareSetting].loginDepartId;
    
    NSString *userRole = [UserDefaultsSetting shareSetting].userRole;
    
    NSString *urlString = [NSString stringWithFormat:LqAppDepartTree_4,dataTime,[UserDefaultsSetting shareSetting].funtype,loginDepartId,userRole];
    
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict[@"success"] boolValue]) {
            
            NSArray *dictArr = dict[@"data"];
            
            _channel = [NSArray yy_modelArrayWithClass:[LqNodeModel class] json:dictArr];
            
            if (lqNodeBlock) {
                lqNodeBlock(_channel);
            }
        }
        
    }];
    
}

@end
