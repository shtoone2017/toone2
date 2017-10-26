//
//  Car_localDetailController.h
//  toone
//
//  Created by 上海同望 on 2017/10/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ViewController.h"
@class Car_ScanModel;
@interface Car_localDetailController : ViewController
@property (nonatomic, strong) Car_ScanModel *Headmodel;
@property (nonatomic, copy) NSString *loation;//坐标
@property (nonatomic, copy) NSString *qsfl;//方量
@property (nonatomic, copy) NSString *status;//签收状态
@property (nonatomic, copy) NSString *jsyy;
@property (nonatomic, copy) NSString *jsyylx;
@property (nonatomic, copy) NSString *jsbz;//备注
@property (nonatomic, strong) UIImage *qsIcon;
@property (nonatomic, strong) UIImage *jsIcon;


typedef void (^imgBlock) (NSDictionary *);
@property (nonatomic,copy) imgBlock imgBlock;

@end
