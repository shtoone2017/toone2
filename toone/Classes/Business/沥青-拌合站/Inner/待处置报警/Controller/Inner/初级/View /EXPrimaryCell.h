//
//  EXPrimaryCell.h
//  toone
//
//  Created by shtoone on 16/12/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EXPrimaryModel,disposal_C_Model;

@interface EXPrimaryCell : UITableViewCell
@property (nonatomic, strong) EXPrimaryModel *EXPModel;
@property (nonatomic, strong) disposal_C_Model *disModel;

@end
