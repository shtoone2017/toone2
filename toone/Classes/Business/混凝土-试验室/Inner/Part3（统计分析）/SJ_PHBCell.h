//
//  SJ_PHBCell.h
//  toone
//
//  Created by 景晓峰 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^senderBlock)(NSInteger senderTag,UIButton *sender);

@interface SJ_PHBCell : UITableViewCell

@property (nonatomic,copy) senderBlock block;

//基本信息
@property (weak, nonatomic) IBOutlet UITextField *SJ_BH_TF;
@property (weak, nonatomic) IBOutlet UIButton *SJ_ZZJG_Btn;
@property (weak, nonatomic) IBOutlet UIButton *SJ_SJQD_Btn;
@property (weak, nonatomic) IBOutlet UIButton *SJ_TLD_Btn;
@property (weak, nonatomic) IBOutlet UITextField *SJ_KSDJ_TF;
@property (weak, nonatomic) IBOutlet UITextField *SJ_KZD_TF;

//原材设置
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_SN_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_SN_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_FM_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_FM_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_XG_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_XG_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_CG1_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_CG1_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_CG2_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_CG2_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_CG3_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_CG3_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_KF_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_KF_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_WJJ_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_WJJ_PB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_Shui_NAME;
@property (weak, nonatomic) IBOutlet UITextField *SJ_YC_Shui_PB;

//掺量信息
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_XS;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_JG3;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_HS;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_SHB;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_BGMD;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_RL;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_JSSCL;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_SL;
@property (weak, nonatomic) IBOutlet UITextField *SJ_CL_BZ;





@end
