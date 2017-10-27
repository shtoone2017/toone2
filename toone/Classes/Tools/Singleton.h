//
//  Singleton.h
//  toone
//
//  Created by 景晓峰 on 2017/10/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car_ScanModel.h"

@interface Singleton : NSObject

+ (instancetype)shareSingleton;
- (NSArray *)queryData;
- (BOOL)deleteData:(Car_ScanModel *)model;
- (BOOL)insertData:(Car_ScanModel *)model;
- (NSArray *)queryDataWithKeyStr:(NSString *)KeyStr valueStr:(NSString *)valueStr;
@end
