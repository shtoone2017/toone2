//
//  NameAxisValueFormatter.m
//  test3
//
//  Created by 十国 on 16/12/8.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "XnameAxisValueFormatter.h"
#import "BarModel.h"
@implementation XnameAxisValueFormatter
{
    NSArray * _axisNames;
    __weak BarLineChartViewBase *_chart;
}

- (id)initForChart:(BarLineChartViewBase *)chart withAxisNames:(NSArray*)axisNames;
{
    self = [super init];
    if (self)
    {
        _axisNames = [axisNames copy];
    }
    return self;
}
- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    int index = (int)value;
    return [(BarModel*)[_axisNames objectAtIndex:index] name];
}

@end
