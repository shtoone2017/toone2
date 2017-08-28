//
//  PickView.h
//  RestApp
//
//  Created by iOS香肠 on 15/11/9.
//  Copyright (c) 2015年 杭州迪火科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMTimePicker ;

@protocol YMTimePickerDelegate <NSObject>

@optional
- (void)monthPickerWillChangeDate:(YMTimePicker *)monthPicker;
- (void)monthPickerDidChangeDate:(YMTimePicker *)monthPicker;

@end




@interface YMTimePicker : UIPickerView <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic ,weak)id <YMTimePickerDelegate>monthPickerDelegate;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSNumber* minimumYear;
@property (nonatomic, strong) NSNumber* maximumYear;
@property (nonatomic) BOOL yearFirst;
@property (nonatomic) BOOL wrapMonths;
@property (nonatomic) BOOL enableColourRow;
-(id)init;
-(id)initWithDate:(NSDate *)date;
@end
