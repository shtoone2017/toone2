//
//  NodeMode.m
//  TreeTableView
//
//  Created by shtoone on 16/11/29.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import "NodeMode.h"
#import "YYModel.h"
#import "NetworkTool.h"


@implementation NodeMode

-(void)channelBlock:(ChannelBlock)channelBlock {
    
    NSString *dataTime = [SGDate getDay];
    
    NSString *loginDepartId = [UserDefaultsSetting shareSetting].loginDepartId;
    
    NSString *userRole = [UserDefaultsSetting shareSetting].userRole;
    
    NSString *urlString = [NSString stringWithFormat:AppDepartTree_gcb,dataTime,loginDepartId];

    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        
        NSDictionary *dict = (NSDictionary *)result;
        
        NSArray *dictArr = dict[@"data"];

        NSString *dictStr = dict[@"success"];
        _success = dictStr;
        
        _channel = [NSArray yy_modelArrayWithClass:[NodeMode class] json:dictArr];

        
        if (channelBlock) {
            channelBlock(_channel);
        }
    }];
}


@end
