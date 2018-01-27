//
//  SW_ZZJG_Data.h
//  toone
//
//  Created by sg on 2017/3/13.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SW_ZZJG_Data : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray   *children;

- (id)initWithName:(NSString *)name children:(NSArray *)array;

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children;

- (void)addChild:(id)child;
- (void)removeChild:(id)child;


//补充的字段
@property (strong, nonatomic) NSString * biaoshiid;
@property (strong, nonatomic) NSString * departType;
@property (strong, nonatomic) NSString * shebeibianhao;
@end
