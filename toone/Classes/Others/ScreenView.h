//
//  ScreenView.h
//  toone
//
//  Created by 景晓峰 on 2017/8/7.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScreenBlock)(NSDictionary *paraDic);

//磅房参数
/*
 jinchangshijian1 true 进场时间1
 jinchangshijian2 true 进场时间2
 chuchangshijian1 true 出场时间1
 chuchangshijian2 true 出场时间2
 orgcode true 组织机构编号
 pageNo true 当前页
 maxPageItems true 每页条数
 pici true 批次
 cheliangbianhao true 车辆编号
 gprsbianhao true 设备编号（shebeibianhao）
 cailiaono
 */
#define jinchangshijian1 @"jinchangshijian1"
#define chuchangshijian1 @"chuchangshijian1"
#define orgcode @"orgcode"
#define apici @"pici"
#define cheliangbianhao @"cheliangbianhao"
#define gprsbianha @"gprsbianhao"
#define cailiaono @"cailiaono"

#define LIST_JCTime1 @"LIST_JCTime1"
#define LIST_CCTime1 @"LIST_CCTime1"
#define LIST_ZZJG @"LIST_ZZJG"
#define LIST_PICI @"LIST_PC"
#define LIST_CAR_NUM @"LIST_CAR_NUM"
#define LIST_SB_NUM @"LIST_SB_NUM"
#define LIST_CL_NUM @"LIST_CL_NUM"



typedef void(^ScreenIsShowBlock)(BOOL isShow);

typedef NS_ENUM(NSInteger,ScreenViewType)
{
    ScreenViewTypeBF_JC = 0,   //磅房筛选  进场
    ScreenViewTypeBF_CC        //出场
    
};

@interface ScreenView : UIView

@property (nonatomic,strong) NSArray *titleArr;  //筛选条件名称

@property (nonatomic,assign) NSInteger type;    //筛选视图类型

@property (nonatomic,strong) UITableView *tbView;

@property (nonatomic,copy) ScreenIsShowBlock block;

@property (nonatomic,strong) NSMutableDictionary *paraDic;  //参数字典

@property (nonatomic,strong) ScreenBlock paraBlock;


- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr type:(NSInteger)type;

@end
