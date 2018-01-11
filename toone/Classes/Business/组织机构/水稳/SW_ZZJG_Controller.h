//
//  SW_ZZJG_Controller.h
//  toone
//
//  Created by sg on 2017/3/13.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyViewController.h"
#import "SW_ZZJG_Data.h"


typedef void(^zzjgCallBackBlock_t)(SW_ZZJG_Data* data);
@interface SW_ZZJG_Controller : MyViewController

@property (nonatomic,copy) zzjgCallBackBlock_t  zzjgCallBackBlock;

@property (nonatomic,copy) NSString * modelType;

@property (nonatomic, copy) NSString *type;
@end
