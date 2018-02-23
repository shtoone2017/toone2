//
//  SSYSViewController.h
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSRoadView.h"
@interface SSYSViewController : UIViewController
@property (strong, nonatomic)  UIScrollView *bgview;

//type 1= 遍数   2=压实度
@property (assign,nonatomic) NSInteger type;

@end
