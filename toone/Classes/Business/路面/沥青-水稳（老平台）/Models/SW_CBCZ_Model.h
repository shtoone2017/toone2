//
//  SW_CBCZ_Model.h
//  toone
//
//  Created by sg on 2017/3/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SW_CBCZ_Model : NSObject
@property (nonatomic ,strong) NSDictionary * dataDict;
@property (nonatomic ,strong) NSDictionary * fieldDict;
@property (nonatomic ,strong) NSDictionary * isShow;

@property (nonatomic,copy) NSString * bianhao;
@property (nonatomic,copy) NSString * sbbh;

@property (nonatomic,copy) NSString * chuli;
@property (nonatomic,copy) NSString * shenhe;
@property (nonatomic,copy) NSString * zxdwshenhe;
@end
