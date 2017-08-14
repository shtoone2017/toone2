//
//  LCListCell.h
//  toone
//
//  Created by 景晓峰 on 2017/8/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCListCell : UITableViewCell

//列表
@property (weak, nonatomic) IBOutlet UILabel *LC_LIST_SSJG_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_LIST_CLName_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_LIST_KC_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_LIST_XZL_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_LIST_CSL_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_LIST_JJZ_Label;


//详情
//基本信息
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_SSJG_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_CLName_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_KC_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_CLJL_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_LLCL_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_SJCL_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_XZL_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_CSL_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_BJ_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_JJZ_Label;

//修正
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_BZ_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_XZZ_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_XZR_Label;
@property (weak, nonatomic) IBOutlet UILabel *LC_Detail_CZSJ_Label;


@end
