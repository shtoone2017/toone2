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
    
    NSString *urlString = [NSString stringWithFormat:AppDepartTree_4,dataTime,[UserDefaultsSetting shareSetting].funtype,loginDepartId,userRole];
    NSString *url = @"http://192.168.11.113:8081/gxzjzqms/appWZproject.do?Appfenbufenxiang";

    [[NetworkTool sharedNetworkTool] getObjectWithURLString:url completeBlock:^(id result) {
        
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
