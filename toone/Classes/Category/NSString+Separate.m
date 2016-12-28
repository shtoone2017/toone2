//
//  NSString+Separate.m
//  test3
//
//  Created by 十国 on 16/12/5.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NSString+Separate.h"

@implementation NSString (Separate)
-(NSArray*)separatedWithFirstString:(NSString*)firstCharacter withSecondCharacter:(NSString*)secondCharacter{
    NSArray *array0 = [self componentsSeparatedByString:firstCharacter];
    NSMutableArray * array = [NSMutableArray arrayWithArray:array0];
    [array removeLastObject];
    
    NSMutableArray * lastArray = [NSMutableArray array];
    for (NSString * subString in array) {
        NSArray * subArray0 = [subString componentsSeparatedByString:secondCharacter];
        NSMutableArray * subArray = [NSMutableArray arrayWithArray:subArray0];
        [subArray removeLastObject];
        [lastArray addObject:subArray];
    }
    return lastArray;
}
@end
