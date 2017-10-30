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

typedef void (^imgBlock) (NSDictionary *);
@property (nonatomic,copy) imgBlock imgBlock;

@end
