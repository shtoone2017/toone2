//
//  TZD_DetailCell.h
//  toone
//
//  Created by 景晓峰 on 2017/8/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZD_DetailCell : UITableViewCell

//任务单
@property (weak, nonatomic) IBOutlet UILabel *RWD_Label_BH;

@property (weak, nonatomic) IBOutlet UILabel *RWD_Label_GCMC;

@property (weak, nonatomic) IBOutlet UILabel *RWD_Label_JZFS;

@property (weak, nonatomic) IBOutlet UILabel *RWD_Label_JHFL;

@property (weak, nonatomic) IBOutlet UILabel *RWD_Label_JZBW;

@property (weak, nonatomic) IBOutlet UILabel *RWD_Label_KPRQ;

//基本信息
@property (weak, nonatomic) IBOutlet UIButton *JCXX_Btn_PHBBH;
@property (weak, nonatomic) IBOutlet UIButton *JCXX_Btn_ZZJG;
@property (weak, nonatomic) IBOutlet UIButton *JCXX_Btn_SJQD;
@property (weak, nonatomic) IBOutlet UIButton *JCXX_Btn_TLD;
@property (weak, nonatomic) IBOutlet UITextField *JCXX_TF_KSDJ;
@property (weak, nonatomic) IBOutlet UITextField *JCXX_TF_KSD;
@property (weak, nonatomic) IBOutlet UITextField *JCXX_TF_TZDBH;

//原材设置
@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_SN;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_SN;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_SN;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_FM;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_FM;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_FM;


@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_XG;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_XG;
@property (weak, nonatomic) IBOutlet UITextField *YC_HS_XG;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_XG;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_CG1;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_CG1;
@property (weak, nonatomic) IBOutlet UITextField *YC_HS_CG1;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_CG1;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_CG2;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_CG2;
@property (weak, nonatomic) IBOutlet UITextField *YC_HS_CG2;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_CG2;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_CG3;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_CG3;
@property (weak, nonatomic) IBOutlet UITextField *YC_HS_CG3;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_CG3;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_KF;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_KF;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_KF;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_WJJ1;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_WJJ1;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_WJJ1;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_WJJ2;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_WJJ2;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_WJJ2;

@property (weak, nonatomic) IBOutlet UITextField *YC_NAME_Shui;
@property (weak, nonatomic) IBOutlet UITextField *YC_PB_Shui;
@property (weak, nonatomic) IBOutlet UITextField *YC_SG_Shui;

//掺量信息
@property (weak, nonatomic) IBOutlet UITextField *CL_XS;
@property (weak, nonatomic) IBOutlet UITextField *CL_JG3;
@property (weak, nonatomic) IBOutlet UITextField *CL_HS;
@property (weak, nonatomic) IBOutlet UITextField *CL_SHB;
@property (weak, nonatomic) IBOutlet UITextField *CL_BGMD;
@property (weak, nonatomic) IBOutlet UITextField *CL_RL;
@property (weak, nonatomic) IBOutlet UITextField *CL_JSSCL;
@property (weak, nonatomic) IBOutlet UITextField *CL_SL;
@property (weak, nonatomic) IBOutlet UITextField *CL_BZ;

@end
