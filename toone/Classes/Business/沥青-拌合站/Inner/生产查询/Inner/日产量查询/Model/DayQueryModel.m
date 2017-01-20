//
//  DayQueryModel.m
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "DayQueryModel.h"
//#import "YYModel.h"
//#import "NetworkTool.h"
//#import "MyViewController.h"

@implementation DayQueryModel
//
//-(void)dayQueryBlock:(DayQueryBlock)dayQueryBlock {
//    
//    MyViewController *myVc = [[MyViewController alloc] init];
//    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:myVc.startTime];
//    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:myVc.endTime];
//    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
//    
//    NSString *urlString = [NSString stringWithFormat:DayQuery,userGroupId,startTimeStamp,endTimeStamp];
//    
//    //    __weak typeof(self)  weakSelf = self;
//    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
//        NSDictionary *dict = (NSDictionary *)result;
//        
//        if ([dict[@"success"] boolValue]) {
//            NSArray *dictArr = dict[@"data"];
//            
//            _arry = [NSArray yy_modelArrayWithClass:[DayQueryModel class] json:dictArr];
//    
//            if (dayQueryBlock) {
//                dayQueryBlock(_arry);
//            }
//            
//        }
//    }];
//
//}

@end
