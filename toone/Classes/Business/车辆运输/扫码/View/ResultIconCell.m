//
//  ResultIconCell.m
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ResultIconCell.h"

@interface ResultIconCell ()


@end
@implementation ResultIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)butClick:(UIButton *)sender {
    
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
