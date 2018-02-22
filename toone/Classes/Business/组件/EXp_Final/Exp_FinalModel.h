//
//  Exp_FinalModel.h
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "YS_deviceModel.h"
@interface Exp_FinalModel : BaseModel

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *contentName; //选择后展示的名字

@property (nonatomic,strong) NSString *contentId; //选择后获得对应的参数  value

@property (nonatomic,strong) NSString *para_key;  //对应的参数  key

@property (nonatomic,assign) NSInteger type;     //根据type来展示对应跳转的页面

@property (nonatomic,strong) YS_deviceModel *tempModel;     //实时选择设备后传的含坐标的model


@end
