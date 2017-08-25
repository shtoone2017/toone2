//
//  TimeTools.h
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGDate.h"


@interface TimeTools : SGDate

+(NSString*)current_HH_mm_SS;


//获取当前时间   格式：HH:mm
+(NSString*)current_HH_mm;


//获取当前时间   格式：yy-MM-dd
+(NSString*)current_yy_MM_dd;


//获取当前时间   格式：yyyy-MM-dd HH:mm
+(NSString*)currentTime;


//获取当前时间3个月前的时间   yyyy-MM-dd HH:mm
+(NSString*)time_3_monthsAgo;


//时间字符串 转 时间戳字符串
+(NSString*)timeStampWithTimeString:(NSString*)timeString;


//时间戳转换为时间
+(NSString*)timeWithTimeStampString:(NSString*)timeStampString;
@end
