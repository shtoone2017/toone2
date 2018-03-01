//
//  YS_YLJModel.h
//  toone
//
//  Created by 景晓峰 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YS_YLJModel : BaseModel

@property (nonatomic,assign) float wendu;
@property (nonatomic,assign) float sudu;
@property (nonatomic,strong) NSString *dinweishijian;
@property (nonatomic,assign) float huanjingwendu;
@property (nonatomic,assign) float fengsu;
@property (nonatomic,assign) float shidu;

@end
