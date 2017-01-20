//
//  NQ_BHZ_SCCX_Inne_Cell.h
//  toone
//
//  Created by shtoone on 16/12/27.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NQ_BHZ_SCCX_InneModel,NQ_BHZ_SCCX_Inne__moreModel,ProductionDetailsM,ProductionDetailsG;

@interface NQ_BHZ_SCCX_Inne_Cell : UITableViewCell
@property (nonatomic, strong) NQ_BHZ_SCCX_Inne__moreModel *moreModel;
@property (nonatomic, strong) NQ_BHZ_SCCX_InneModel *model;
@property (nonatomic, strong) ProductionDetailsM *modelM;
@property (nonatomic, strong) ProductionDetailsG *modelG;

@end
