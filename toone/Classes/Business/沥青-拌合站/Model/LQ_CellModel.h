//
//  LQ_CellModel.h
//  toone
//
//  Created by shtoone on 16/12/30.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"
@class LQ_Model;
@interface LQ_CellModel : MyModel
@property (nonatomic,strong) LQ_Model * totalModel;
@property (nonatomic,strong) LQ_Model * chujiModel;
@property (nonatomic,strong) LQ_Model * zhongjiModel;
@property (nonatomic,strong) LQ_Model * gaojiModel;
@end
