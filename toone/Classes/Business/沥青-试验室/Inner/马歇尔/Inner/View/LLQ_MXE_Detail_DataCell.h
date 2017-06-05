//
//  SW_CBCZ_Detail_DataCell.h
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendActionBlock)(NSInteger);

@class LLQ_MXE_Detail_Data;
@interface LLQ_MXE_Detail_DataCell : UITableViewCell
@property (nonatomic) LLQ_MXE_Detail_Data * model;

@property (nonatomic,copy) SendActionBlock block;

@end
