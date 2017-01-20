//
//  DayDetailsController.h
//  toone
//
//  Created by shtoone on 17/1/3.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DayQueryModel;
@interface DayDetailsController : UITableViewController
@property (nonatomic, strong) DayQueryModel *model;
@property (nonatomic,weak) UIViewController * weakController;
@end
