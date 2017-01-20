//
//  LQ_CLHS_Cell.h
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQ_CLHS_ModelG,LQ_CLHS_DataModel;

@interface LQ_CLHS_Cell : UITableViewCell
@property (nonatomic, strong) LQ_CLHS_ModelG *modelG;
@property (nonatomic, strong) LQ_CLHS_DataModel *dataModel;

@property (nonatomic,strong) NSArray * datas1;
@property (nonatomic,strong) NSArray * datas2;
@property (weak, nonatomic) IBOutlet UIButton *unitButton;

@end
