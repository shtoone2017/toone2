//
//  TimeTools.m
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "TimeTools.h"

@implementation TimeTools

+(NSString*)current_HH_mm_SS{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm:SS"];
    NSString * time = [dateFormater stringFromDate:[NSDate date]];
    return time;
}
+(NSString*)current_HH_mm{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm"];
    NSString * time = [dateFormater stringFromDate:[NSDate date]];
    return time;
}
+(NSString*)currentTime{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * time = [dateFormater stringFromDate:[NSDate date]];
    return time;
}
+(NSString*)time_3_monthsAgo{
    NSDate * mydate = [NSDate date];

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//     DebugLog(@"---当前的时间的字符串 =%@",currentDateStr);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-3];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
//     DebugLog(@"---前两个月 =%@",beforDate);
    return beforDate;
}
+(NSString*)timeStampWithTimeString:(NSString*)timeString{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormater dateFromString:timeString];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];  //转化为UNIX时间戳
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
}
//iOS 时间戳转换为时间
+(NSString*)timeWithTimeStampString:(NSString*)timeStampString{
    NSString *str=timeStampString;//时间戳
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

@end
