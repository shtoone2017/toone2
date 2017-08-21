//
//  Exp1_xib_view.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exp71_Xib_View : UIView
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sbButton;//任务单
@property (weak, nonatomic) IBOutlet UILabel *sbLabel;

@property (weak, nonatomic) IBOutlet UIButton *usePositionButton;//组织机构
@property (weak, nonatomic) IBOutlet UILabel *useLabel;//机构

@property (weak, nonatomic) IBOutlet UIButton *earthworkButton;//设计强度
@property (weak, nonatomic) IBOutlet UILabel *earthLabel;

//统计类型
@property (weak, nonatomic) IBOutlet UIButton *tjlxBut;
@property (weak, nonatomic) IBOutlet UILabel *tjlxLabel;

//出场类型
@property (weak, nonatomic) IBOutlet UIButton *cclxBut;
@property (weak, nonatomic) IBOutlet UILabel *cclxLabel;


@end
