//
//  ScanResultController.h
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultController : UIViewController
@property (nonatomic, copy) NSString *result;


typedef void (^imgBlock) (NSDictionary *);
@property (nonatomic,copy) imgBlock imgBlock;

@end
