//
//  Exp1_xib_view.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exp2_Xib_View : UIView
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sbButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIButton *sjqdButton;
@property (weak, nonatomic) IBOutlet UIButton *lqButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *okTop;
@property (weak, nonatomic) IBOutlet UIView *lqView;//临期
@property (weak, nonatomic) IBOutlet UIView *sjqdView;//设计强度
@property (weak, nonatomic) IBOutlet UILabel *sjqdLabel;//设计强度

@property (weak, nonatomic) IBOutlet UIButton *zzjgButton;
@property (weak, nonatomic) IBOutlet UIView *zzgjView;

@end
