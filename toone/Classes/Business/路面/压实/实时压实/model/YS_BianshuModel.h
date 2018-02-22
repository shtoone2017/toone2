//
//  YS_BianshuModel.h
//  toone
//
//  Created by 景晓峰 on 2018/1/31.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YS_BianshuModel : BaseModel

@property (nonatomic,assign) float lng;
@property (nonatomic,assign) float lat;
@property (nonatomic,assign) int grid_count;

@end
