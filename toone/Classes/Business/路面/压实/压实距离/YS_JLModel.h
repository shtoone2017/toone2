//
//  YS_JLModel.h
//  toone
//
//  Created by 景晓峰 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YS_JLModel : JSONModel
@property (nonatomic,strong) NSString *date; //时间

@property (nonatomic,assign) float statistics; //距离
@end
