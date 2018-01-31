//
//  Exp1_xib_view.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpYS1_Xib_View : UIView
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;

@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *sbButton;
@property (weak, nonatomic) IBOutlet UILabel *sbLabel;

@property (weak, nonatomic) IBOutlet UIView *mcView;
@property (weak, nonatomic) IBOutlet UIButton *mcButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@end
