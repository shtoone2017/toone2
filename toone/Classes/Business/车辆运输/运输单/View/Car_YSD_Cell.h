//
//  Car_YSD_Cell.h
//  toone
//
//  Created by 上海同望 on 2017/10/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car_YSD_Model,Car_ScanModel;
@interface Car_YSD_Cell : UITableViewCell
@property (nonatomic, strong) Car_YSD_Model *model;

@property (nonatomic, strong) Car_ScanModel *localModel;

@end
