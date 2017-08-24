//
//  GCB_JZL_BkView.m
//  toone
//
//  Created by 上海同望 on 2017/8/23.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JZL_BkView.h"

@interface GCB_JZL_BkView ()



@end
@implementation GCB_JZL_BkView

- (IBAction)editClick:(UIButton *)sender {
}



//删除
- (IBAction)deletingClick:(UIButton *)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self.viewController presentViewController:alert animated:YES completion:nil];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"GCB_JZL_BkView" owner:self options:nil][0];
    }
    return self;
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
