//
//  Exp_Final.h
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exp_FinalCell.h"
#import "Exp_FinalModel.h"

typedef NS_OPTIONS(NSInteger, YS_Search_Type)
{
    YS_Search_Type_StartStack = 0,
    YS_Search_Type_EndStack,
    YS_Search_Type_RoadID,
    YS_Search_Type_StartTime,
    YS_Search_Type_EndTime,
    YS_Search_Type_Layer
};

@interface Exp_Final : UIView

@property (strong, nonatomic) NSMutableArray *dataArr;

@end
