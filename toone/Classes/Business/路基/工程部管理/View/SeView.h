//
//  SeView.h
//  Dduo
//
//  Created by 上海同望 on 2017/7/19.
//  Copyright © 2017年 FCB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCB_Model;
@interface SeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *wplLabel;//未提交
@property (weak, nonatomic) IBOutlet UILabel *yplLabel;//未配料
@property (weak, nonatomic) IBOutlet UILabel *wtjLabel;//已配料
@property (weak, nonatomic) IBOutlet UILabel *sczLabel;//生产中
@property (weak, nonatomic) IBOutlet UILabel *wcLabel;//完成

@property (nonatomic, strong) GCB_Model *model;
@end
