//
//  ScanResultCell.h
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car_ScanModel;
@interface ScanResultCell : UITableViewCell
@property (nonatomic, strong) Car_ScanModel *model;

@property (nonatomic, copy) NSString *dataImg;//图片参数
@property (nonatomic, copy) NSString *jsImg;//图片参数
@property (nonatomic, copy) NSString *loation;

@end
