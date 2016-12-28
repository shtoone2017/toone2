//
//  Drawer.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Drawer.h"

@implementation Drawer


+(instancetype)drawerWithDict:(NSDictionary*)dict{
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
    }
    return self;
}
+(NSArray*)datas{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"DrawerList" ofType:@"plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray * resultArray = [NSMutableArray array];
    for (NSArray * subArray in array) {
        NSMutableArray * newSubArray = [NSMutableArray array];
        for (NSDictionary * d in subArray) {
            [newSubArray addObject:[Drawer drawerWithDict:d]];
        }
        [resultArray addObject:newSubArray];
    }
    return resultArray;
}

@end
