//
//  HNT_CBCZ_Detail_HeadMsg.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Detail_HeadMsg.h"

@implementation HNT_CBCZ_Detail_HeadMsg
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.xinxibianhao = Format(dict[@"xinxibianhao"]);
    }
    return self;
}
@end
