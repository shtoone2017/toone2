//
//  DataVC.h
//  toone
//
//  Created by sg on 2017/4/19.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataVC : UIViewController
@property (nonatomic,strong) NSArray * datas;
@property (nonatomic,copy) void(^callBlock)(NSString*);
@end
