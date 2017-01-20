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
@property (nonatomic, strong) NSString *dailybeizhu;//备注
@property (nonatomic, strong) NSString *dailyxzcl;//修正产量
@property (nonatomic, strong) NSNumber *dailyid;//id
@property (nonatomic, strong) NSString *dailycd;//长度
@property (nonatomic, strong) NSString *dailykd;//宽度
@property (nonatomic, strong) NSString *dailyhd;//厚度
@property (nonatomic, strong) NSString *dailymd;//密度
@property (nonatomic, strong) NSString *dailysbbh;//设备编号
@property (nonatomic, strong) NSString *dailysjhd;//实际厚度
@property (nonatomic, strong) NSString *dailyxh;

@property (nonatomic, strong) NSString *dailyps;//盘数
@property (nonatomic, strong) NSString *dailyrq;//日期
@property (nonatomic, strong) NSString *dailycl;//采集产量
@property (nonatomic, strong) NSString *dailybuwei;//施工桩号

@property (nonatomic, assign) long indexRow;//施工桩号

//@property (nonatomic, strong) NSArray *arry;

//-(void)dayQueryBlock:(DayQueryBlock)dayQueryBlock;
@end
