//
//  TZD_ListModel.h
//  toone
//
//  Created by 景晓峰 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "BaseModel.h"

@interface TZD_ListModel : BaseModel
/*
 renwuNo true string 任务单编号
 createDateTime true string 试验日期
 departname true string 所属机构
 llphbNo true string 设计配合比编号
 jzbw true string 浇筑部位
 shihaofangliang true string 实耗方量
 jihuafangliang true string 计划方量
 sjqd true string 设计强度
 sgphbNo true string 配比通知单号
 */
@property(nonatomic,strong)NSString * renwuNo;

@property(nonatomic,strong)NSString *createDateTime;

@property(nonatomic,strong)NSString *llphbNo;

@property(nonatomic,strong)NSString *departname;

@property(nonatomic,strong)NSString * sgphbNo;

@property(nonatomic,strong)NSString * jzbw;

@property(nonatomic,strong)NSString *shihaofangliang;

@property(nonatomic,strong)NSString * jihuafangliang;

@property(nonatomic,strong)NSString * sjqd;


@end
