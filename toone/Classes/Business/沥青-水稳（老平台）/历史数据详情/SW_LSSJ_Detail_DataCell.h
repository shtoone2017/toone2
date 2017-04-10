//
//  SW_CBCZ_Detail_DataCell.h
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SW_LSSJ_Detail_Data;
@interface SW_LSSJ_Detail_DataCell : UITableViewCell
@property (nonatomic) SW_LSSJ_Detail_Data * model;
@property (nonatomic,strong) UIColor * color;
@end
