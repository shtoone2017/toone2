//
//  NameAxisValueFormatter.h
//  test3
//
//  Created by 十国 on 16/12/8.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <toone-Swift.h>
@interface XnameAxisValueFormatter : NSObject<IChartAxisValueFormatter>

- (id)initForChart:(BarLineChartViewBase *)chart withAxisNames:(NSArray*)axisNames;
@end
