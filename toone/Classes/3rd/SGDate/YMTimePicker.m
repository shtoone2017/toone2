//
//  PickView.m
//  RestApp
//
//  Created by iOS香肠 on 15/11/9.
//  Copyright (c) 2015年 杭州迪火科技有限公司. All rights reserved.
//

#import "YMTimePicker.h"



#define MONTH_ROW_MULTIPLIER 340
#define DEFAULT_MINIMUM_YEAR 1
#define DEFAULT_MAXIMUM_YEAR 99999
#define DATE_COMPONENT_FLAGS NSCalendarUnitMonth | NSCalendarUnitYear

@interface YMTimePicker()

@property (nonatomic) NSInteger monthComponent;
@property (nonatomic) NSInteger yearComponent;
@property (nonatomic, readonly) NSArray* monthStrings;

-(long)yearFromRow:(NSUInteger)row;
-(NSUInteger)rowFromYear:(long)year;

@end

@implementation YMTimePicker

@synthesize date = _date;
@synthesize monthStrings = _monthStrings;
@synthesize enableColourRow = _enableColourRow;
@synthesize monthPickerDelegate = _monthPickerDelegate;

-(id)initWithDate:(NSDate *)date
{
    self = [super init];
    
    if (self)
    {
        
        [self prepare];
        [self setDate:date];
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

-(id)init
{
    self = [self initWithDate:[NSDate date]];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self prepare];
        if (!_date)
            [self setDate:[NSDate date]];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self prepare];
        if (!_date)
            [self setDate:[NSDate date]];
    }
    
    return self;
}

-(void)prepare
{
//    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    
    _enableColourRow = YES;
    _wrapMonths = YES;
    _yearFirst = YES;
}

-(id<UIPickerViewDelegate>)delegate
{
    return self;
}

-(void)setDelegate:(id<UIPickerViewDelegate>)delegate
{
    if ([delegate isEqual:self])
        [super setDelegate:delegate];
}

-(id<UIPickerViewDataSource>)dataSource
{
    return self;
}

-(void)setDataSource:(id<UIPickerViewDataSource>)dataSource
{
    if ([dataSource isEqual:self])
        [super setDataSource:dataSource];
}

-(NSInteger)monthComponent
{
    return self.yearComponent ^ 1;
}

-(NSInteger)yearComponent
{
    return !self.yearFirst;
}

-(NSArray *)monthStrings
{
    return [[NSDateFormatter alloc] init].monthSymbols;
}

-(void)setYearFirst:(BOOL)yearFirst
{
    _yearFirst = yearFirst;
    NSDate* date = self.date;
    [self reloadAllComponents];
    [self setNeedsLayout];
    [self setDate:date];
}

-(void)setMinimumYear:(NSNumber *)minimumYear
{
    NSDate* currentDate = self.date;
    NSDateComponents* components = [[NSCalendar currentCalendar] components:DATE_COMPONENT_FLAGS fromDate:currentDate];
    components.timeZone = [NSTimeZone localTimeZone];
    if (minimumYear && components.year < minimumYear.integerValue)
        components.year = minimumYear.integerValue;
    
    _minimumYear = minimumYear;
    [self reloadAllComponents];
    [self setDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

-(void)setMaximumYear:(NSNumber *)maximumYear
{
    NSDate* currentDate = self.date;
    NSDateComponents* components = [[NSCalendar currentCalendar] components:DATE_COMPONENT_FLAGS fromDate:currentDate];
    components.timeZone = [NSTimeZone defaultTimeZone];
    
    if (maximumYear && components.year > maximumYear.integerValue)
        components.year = maximumYear.integerValue;
    
    _maximumYear = maximumYear;
    [self reloadAllComponents];
    [self setDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

-(void)setWrapMonths:(BOOL)wrapMonths
{
    _wrapMonths = wrapMonths;
    [self reloadAllComponents];
}

-(long)yearFromRow:(NSUInteger)row
{
    NSInteger minYear = DEFAULT_MINIMUM_YEAR;
    
    if (self.minimumYear)
        minYear = self.minimumYear.integerValue;
    
    return  row + minYear;
}

-(NSUInteger)rowFromYear:(long)year
{
    NSInteger minYear = DEFAULT_MINIMUM_YEAR;
    
    if (self.minimumYear)
        minYear = self.minimumYear.integerValue;
    
    return year - minYear;
}

-(void)setDate:(NSDate *)date
{

    NSDateComponents* components = [[NSCalendar currentCalendar] components:DATE_COMPONENT_FLAGS fromDate:date];

    components.timeZone = [NSTimeZone defaultTimeZone];
    
    if (self.minimumYear && components.year < self.minimumYear.integerValue)
        components.year = self.minimumYear.integerValue;
    else if (self.maximumYear && components.year > self.maximumYear.integerValue)
        components.year = self.maximumYear.integerValue;
    
    if(self.wrapMonths){
        long monthMidpoint = self.monthStrings.count * (MONTH_ROW_MULTIPLIER / 2);
        
        [self selectRow:(components.month - 1 + monthMidpoint) inComponent:self.monthComponent animated:NO];
    }
    else {
        [self selectRow:(components.month - 1) inComponent:self.monthComponent animated:NO];
    }
    [self selectRow:[self rowFromYear:components.year] inComponent:self.yearComponent animated:NO];
    
    _date = [[NSCalendar currentCalendar] dateFromComponents:components];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDateComponents* components = [[NSDateComponents alloc] init];
    components.month = 1 + ([self selectedRowInComponent:self.monthComponent] % self.monthStrings.count);
    components.year = [self yearFromRow:[self selectedRowInComponent:self.yearComponent]];
    
    [self willChangeValueForKey:@"date"];
    if ([self.monthPickerDelegate respondsToSelector:@selector(monthPickerWillChangeDate:)])
        [self.monthPickerDelegate monthPickerWillChangeDate:self];
    
    _date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    if ([self.monthPickerDelegate respondsToSelector:@selector(monthPickerDidChangeDate:)])
        [self.monthPickerDelegate monthPickerDidChangeDate:self];
    [self didChangeValueForKey:@"date"];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == self.monthComponent && !self.wrapMonths)
        return self.monthStrings.count;
    else if(component == self.monthComponent)
        return MONTH_ROW_MULTIPLIER * self.monthStrings.count;
    
    long maxYear = DEFAULT_MAXIMUM_YEAR;
    if (self.maximumYear)
        maxYear = self.maximumYear.integerValue;
    
    return [self rowFromYear:maxYear] + 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == self.monthComponent)
        return 160.0f;
    else
        return 70.0f;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 34;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat width = [self pickerView:self widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 45.0f);
    
    if (component == self.monthComponent)
    {
        const CGFloat padding = 5.0f;
        if (component) {
            frame.origin.x += padding;
            frame.size.width -= padding;
        }
        frame.size.width -= padding;
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    if (component == self.monthComponent) {
        label.text = [self.monthStrings objectAtIndex:(row % self.monthStrings.count)];
        //显示月份
        label.text =[self monthday:label.text];
        
        formatter.dateFormat = @"m";
//        label.textAlignment = component ? NSTextAlignmentLeft : NSTextAlignmentRight;
        label.textAlignment =  NSTextAlignmentRight;
    } else {
        //显示年份
        label.text = [NSString stringWithFormat:@"%ld", [self yearFromRow:row]];
        label.adjustsFontSizeToFitWidth =YES;
        label.text =[NSString stringWithFormat:@"%@  年",label.text];
        label.textAlignment = NSTextAlignmentLeft;
        formatter.dateFormat = @"y";
    }
    
    if (_enableColourRow && [[formatter stringFromDate:[NSDate date]] isEqualToString:label.text])
    label.textColor = [UIColor colorWithRed:0.0f green:0.35f blue:0.91f alpha:1.0f];
    label.font = [UIFont systemFontOfSize:18.0f];
    label.adjustsFontSizeToFitWidth=YES;
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0.0f, 0.1f);
    label.shadowColor = [UIColor whiteColor];
    
    return label;
}
//英文转化为数字
- (NSString *)monthday:(NSString *)str
{
    if ([str isEqualToString:@"一月"]) {
        return @"1  月";
    }
    else if ([str isEqualToString:@"二月"])
    {
        return @"2  月";
    }
    else if ([str isEqualToString:@"三月"])
    {
        return @"3  月";
    }
    else if ([str isEqualToString:@"四月"])
    {
        return @"4  月";
    }
    else if ([str isEqualToString:@"五月"])
    {
        return @"5  月";
    }
    else if ([str isEqualToString:@"六月"])
    {
        return @"6  月";
    }
    else if ([str isEqualToString:@"七月"])
    {
        return @"7  月";
    }
    else if ([str isEqualToString:@"八月"])
    {
        return @"8  月";
    }
    else if ([str isEqualToString:@"九月"])
    {
        return @"9  月";
    }
    else if ([str isEqualToString:@"十月"])
    {
        return @"10  月";
    }
    else if ([str isEqualToString:@"十一月"])
    {
        return @"11  月";
    }
    else if ([str isEqualToString:@"十二月"])
    {
        return @"12  月";
    }
    return nil;
}
@end
