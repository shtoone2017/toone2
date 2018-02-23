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
@property (weak, nonatomic) IBOutlet UIScrollView *bgScroll;

//type 1= 遍数   2=压实度
@property (assign,nonatomic) NSInteger type;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIImageView *colorImg;

@end
