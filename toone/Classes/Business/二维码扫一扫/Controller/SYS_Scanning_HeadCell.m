//
//  SYS_Scanning_HeadCell.m
//  toone
//
//  Created by 上海同望 on 2017/11/30.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SYS_Scanning_HeadCell.h"

@implementation SYS_Scanning_HeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)dissClick:(UIButton *)sender {
    [self.viewController dismissViewControllerAnimated:YES completion:^{
    }];
}


- (UIViewController *)viewController {
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}
@end
