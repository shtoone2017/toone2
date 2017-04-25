//
//  DayQueryModel.h
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"
//typedef void(^DayQueryBlock)(NSArray *result);

@interface DayQueryModel : MyModel

@property (nonatomic, strong) NSString *dailysbbh;//设备编号
@property (nonatomic, strong) NSString *dailyps;//盘数
@property (nonatomic, strong) NSString *dailyrq;//日期
@property (nonatomic, strong) NSString *dailycl;//采集产量


//@property (nonatomic, strong) NSArray *arry;

//-(void)dayQueryBlock:(DayQueryBlock)dayQueryBlock;
@end
