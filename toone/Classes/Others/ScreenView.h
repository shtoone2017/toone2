//
//  ScreenView.h
//  toone
//
//  Created by 景晓峰 on 2017/8/7.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScreenIsShowBlock)(BOOL isShow);

typedef NS_ENUM(NSInteger,ScreenViewType)
{
    ScreenViewTypeBF = 0   //磅房筛选
    
    
};

@interface ScreenView : UIView

@property (nonatomic,strong) NSArray *titleArr;  //筛选条件名称

@property (nonatomic,assign) NSInteger type;    //筛选视图类型

@property (nonatomic,strong) UITableView *tbView;

@property (nonatomic,copy) ScreenIsShowBlock block;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr type:(NSInteger)type;

@end
