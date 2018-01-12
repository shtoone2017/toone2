//
//  Exp1_xib_view.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exp51_Xib_View : UIView
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UITextField *rwdhText;//龄期
@property (weak, nonatomic) IBOutlet UITextField *jzbwText;//浇筑部位


@property (weak, nonatomic) IBOutlet UIButton *usePositionButton;//组织机构
@property (weak, nonatomic) IBOutlet UILabel *useLabel;//机构

@property (weak, nonatomic) IBOutlet UIButton *earthworkButton;//设计强度
@property (weak, nonatomic) IBOutlet UILabel *sjqdLabel;

@end
