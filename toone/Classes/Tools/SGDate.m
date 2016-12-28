//
//  SGChooseDate.m
//  BI
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGDate.h"

@implementation SGDate
+(NSString*)getDate:(NSDate*)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * time = [formatter stringFromDate:date];
    return time;
}
+(NSString*)getToday{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd 07:30"];
    NSString * time = [dateFormater stringFromDate:[NSDate date]];
    return time;
}
+(NSString*)getYesterday{
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSString * time = [dateFormater stringFromDate:yesterday];
    return time;
}
+(NSString*)getThedaybefore:(NSString*)currentTime{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormater dateFromString:currentTime];
    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];
    return [dateFormater stringFromDate:yesterday];
}
+(NSString*)getThedayafter:(NSString*)currentTime{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormater dateFromString:currentTime];
    NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    return [dateFormater stringFromDate:tomorrow];
}
+(BOOL)compareYear:(NSString*)theDayBefore with:(NSString*)theDayAfter{
    NSString * str1 = [theDayBefore substringToIndex:4];
    NSString * str2 = [theDayAfter  substringToIndex:4];
    NSComparisonResult state = [str1 compare:str2 options:NSCaseInsensitiveSearch];

    return state == NSOrderedSame ? YES : NO;
}
+(BOOL)compareTime:(NSString*)theDayBefore with:(NSString*)theDayAfter{
    NSComparisonResult state = [theDayBefore compare:theDayAfter options:NSCaseInsensitiveSearch ];
    return state == NSOrderedAscending ? YES : NO;
}
+(NSString*)changeDateFormatter:(NSString*)time{
    NSString * str1 = [time substringToIndex:10];
    NSString * str2 = [time substringFromIndex:11];
    NSString * str3 = [NSString stringWithFormat:@"%@T%@",str1,str2];
    return str3;
}
+(NSString*)getMonth{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM"];
    NSString * time = [dateFormater stringFromDate:[NSDate date]];
    return time;
}
+(NSString*)getThemonthbefore:(NSString*)currentTime{
    NSString * str1 = [currentTime substringToIndex:4];
    NSString * str2 = [currentTime substringFromIndex:5];
    int year = [str1 intValue];
    int month = [str2 intValue];
    month = month - 1;
    if (month == 0) {
        month = 12;
        year = year - 1;
        str2 = [NSString stringWithFormat:@"%d",month];
    }
    if (month < 10 && month > 0) {
        str2 = [NSString stringWithFormat:@"0%d",month];
    }
    if (month >= 10) {
        str2 = [NSString stringWithFormat:@"%d",month];
    }
    str1 = [NSString stringWithFormat:@"%d",year];
    NSString * time = [NSString stringWithFormat:@"%@-%@",str1,str2];
    return time;
}
+(NSString*)getThemonthafter:(NSString*)currentTime{
    NSString * str1 = [currentTime substringToIndex:4];
    NSString * str2 = [currentTime substringFromIndex:5];
    int year = [str1 intValue];
    int month = [str2 intValue];
    month = month + 1;
    if (month > 12) {
        month = month - 12;
        year = year + 1;
        str2 = [NSString stringWithFormat:@"0%d",month];
    }
    if (month <10) {
        str2 = [NSString stringWithFormat:@"0%d",month];
    }
    if (month >= 10 && month <= 12) {
        str2 = [NSString stringWithFormat:@"%d",month];
    }
    str1 = [NSString stringWithFormat:@"%d",year];
    NSString * time = [NSString stringWithFormat:@"%@-%@",str1,str2];
    return time;
}
+(NSString*)getMonth:(NSDate*)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString * time = [formatter stringFromDate:date];
    return time;
}
+(NSArray*)getMonthTime:(NSString*)currentTime{
    NSString * str1 = [currentTime substringToIndex:4];
    NSString * str2 = [currentTime substringFromIndex:5];
    int year = [str1 intValue];
    int month = [str2 intValue];
    int day;
    if (month == 2) {
        if ((year % 4  == 0 && year % 100 != 0)  || year % 400 == 0){
            day = 29;
        }else{
            day = 28;
        }
    }
    else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10|| month == 12) {
        day = 31;
    }
    else{
        day = 30;
    }
    NSString * beginTime = [NSString stringWithFormat:@"%@-01",currentTime];
    NSString * endTime = [NSString stringWithFormat:@"%@-%dT23:59:59",currentTime,day];
    return @[beginTime,endTime];
}
+(NSArray*)getYMFromTime:(NSString*)currentTime{
    NSString * str1 = [currentTime substringToIndex:4];
    NSString * str2 = [currentTime substringFromIndex:5];
    return @[str1,str2];
}
+(NSString*)getDay{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSString * time = [dateFormater stringFromDate:[NSDate date]];
    return time;
}
+(NSString*)getYear{
    NSDateFormatter  * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy"];
    NSString * time = [dateFormater stringFromDate:[NSDate date]];
    return time;
}
@end
