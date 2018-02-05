//
//  DrawerController.h
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZJG_View.h"
#import "ScreenView.h"

typedef void(^SendTimeBlock)();

typedef void(^SendDateStrBlock)(NSString *dateStr);

@interface MyViewController : UIViewController<UIGestureRecognizerDelegate,CalendarViewControllerDelegate>
@property (nonatomic,copy)NSString * startTime;
@property (nonatomic,copy)NSString * endTime;

@property (nonatomic,strong) NSArray *screenViewTitleArr;

@property (nonatomic,assign) NSInteger screenViewType;

@property (nonatomic,strong) ScreenView *scView;

@property (nonatomic,copy) SendTimeBlock block;

@property (nonatomic,copy) SendDateStrBlock dateBlock;

@property (nonatomic,assign) BOOL onlyDate;//只有日期,没有具体几点

@property (nonatomic,assign) BOOL isDetailSecond;//压实具体到秒

/**
 * 提供一个可供子类继承/重写的buttonClick:
 */
-(void)searchButtonClick:(UIButton*)sender;

/**
 * 封装3rd时间组件
 */
-(void)calendarWithTimeString:(NSString*)timeString obj:(id)obj;

/*
 添加移动手势
 */
-(void)addPanGestureRecognizer;
-(void)pan;
/*
    添加搜索按钮
 */
-(void)addSearchButton;


@end
