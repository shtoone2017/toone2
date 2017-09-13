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
@property (weak, nonatomic) IBOutlet UILabel *JC_JZ;


@property (weak, nonatomic) IBOutlet UILabel *CC_BF_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_CL_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_GYS_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_SJ;
@property (weak, nonatomic) IBOutlet UILabel *CC_TYPE;

//详情
@property (strong, nonatomic) IBOutlet UILabel *Detail_GYS_Name;
@property (strong, nonatomic) IBOutlet UILabel *Detail_DB_Name;

@property (strong, nonatomic) IBOutlet UILabel *Detail_Person_Name;

@property (strong, nonatomic) IBOutlet UILabel *Detail_CC_Time;

@property (strong, nonatomic) IBOutlet UILabel *Detail_JC_Time;
@property (strong, nonatomic) IBOutlet UILabel *Detail_LC_Name;

@property (strong, nonatomic) IBOutlet UILabel *Detail_PC;

@property (strong, nonatomic) IBOutlet UILabel *Detail_Order_Num;
@property (strong, nonatomic) IBOutlet UILabel *Detail_Car_Num;
@property (strong, nonatomic) IBOutlet UILabel *Detail_Remark;

//材料明细
@property (strong, nonatomic) IBOutlet UILabel *Detail_CL_Name;

@property (strong, nonatomic) IBOutlet UILabel *Detail_CL_MZ;
@property (strong, nonatomic) IBOutlet UILabel *Detail_CL_PZ;

@property (strong, nonatomic) IBOutlet UILabel *Detail_CL_KZ;

@property (strong, nonatomic) IBOutlet UILabel *Detail_CL_KL;
@property (strong, nonatomic) IBOutlet UILabel *Detail_CL_JZ;
@property (strong, nonatomic) IBOutlet UILabel *Detail_CL_SJZL;


/**
 进出场图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *Detail_Pic;










@end
