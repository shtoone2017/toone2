//
//  SB_Model.h
//  toone
//
//  Created by shtoone on 16/12/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SB_Block_t)(NSArray *result);

@interface SB_Model : NSObject
@property (nonatomic, copy) NSString *banhezhanminchen;//拌合站名称
@property (nonatomic, copy) NSString *departid;//住址机构id
@property (nonatomic, copy) NSString *gprsbianhao;//设备编号

@property (nonatomic, strong) NSArray *arr;

-(void)sb_Block:(SB_Block_t)sb_Block;
@end
