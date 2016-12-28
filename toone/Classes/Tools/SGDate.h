//
//  SGChooseDate.h
//  BI
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 jzs.com. All rights reserved.
//
/*
    默认时间格式  [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
 */
#import <Foundation/Foundation.h>

@interface SGDate : NSObject
/**
 *  <#Description#>
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)getDate:(NSDate*)date;
+(NSString*)getToday;
+(NSString*)getYesterday;
+(NSString*)getThedaybefore:(NSString*)currentTime;
+(NSString*)getThedayafter:(NSString*)currentTime;
+(BOOL)compareYear:(NSString*)theDayBefore with:(NSString*)theDayAfter;
+(BOOL)compareTime:(NSString*)theDayBefore with:(NSString*)theDayAfter;
+(NSString*)changeDateFormatter:(NSString*)time;


+(NSString*)getMonth;
+(NSString*)getMonth:(NSDate*)date;
+(NSString*)getThemonthbefore:(NSString*)currentTime;
+(NSString*)getThemonthafter:(NSString*)currentTime;
+(NSArray*)getMonthTime:(NSString*)currentTime;

+(NSArray*)getYMFromTime:(NSString*)currentTime;
/**
 *  查询当前日期  yyyy-MM-dd
 */
+(NSString*)getDay;
/**
 *  查询当前年  yyyy
 */
+(NSString*)getYear;
@end
