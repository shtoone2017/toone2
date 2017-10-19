//
//  ResultIconCell.m
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ResultIconCell.h"

@interface ResultIconCell ()
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ButTop;



@end
@implementation ResultIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)butClick:(UIButton *)sender {
  [UserDefaultsSetting_SW shareSetting].carSubmit = [NSString stringWithFormat:@"%d",arc4random()%1000];
}

@end
