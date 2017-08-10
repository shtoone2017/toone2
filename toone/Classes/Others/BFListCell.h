//
//  BFListCell.h
//  toone
//
//  Created by 景晓峰 on 2017/8/10.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFListCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *JC_BF_Name;
@property (weak, nonatomic) IBOutlet UILabel *JC_CL_Name;
@property (weak, nonatomic) IBOutlet UILabel *JC_GYS_Name;
@property (weak, nonatomic) IBOutlet UILabel *JC_SJ;


@property (weak, nonatomic) IBOutlet UILabel *CC_BF_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_CL_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_GYS_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_SJ;
@property (weak, nonatomic) IBOutlet UILabel *CC_TYPE;

//详情
@property (strong, nonatomic) IBOutlet UILabel *GYS_Name;
@property (strong, nonatomic) IBOutlet UILabel *DB_Name;

@property (strong, nonatomic) IBOutlet UILabel *Person_Name;

@property (strong, nonatomic) IBOutlet UILabel *CC_Time;

@property (strong, nonatomic) IBOutlet UILabel *JC_Time;
@property (strong, nonatomic) IBOutlet UILabel *LC_Name;

@property (strong, nonatomic) IBOutlet UILabel *PC;

@property (strong, nonatomic) IBOutlet UILabel *Order_Num;
@property (strong, nonatomic) IBOutlet UILabel *Car_Num;
@property (strong, nonatomic) IBOutlet UILabel *Remeke;













@end
