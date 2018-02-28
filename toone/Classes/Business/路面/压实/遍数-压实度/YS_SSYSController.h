//
//  YS_SSYSController.h
//  toone
//
//  Created by 上海同望 on 2018/2/27.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSRoadView.h"

@interface YS_SSYSController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *bgScroll;

//type 1= 遍数   2=压实度
@property (assign,nonatomic) NSInteger type;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIImageView *colorImg;
@end
