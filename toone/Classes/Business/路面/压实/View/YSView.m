//
//  YSView.m
//  toone
//
//  Created by 上海同望 on 2018/1/26.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSView.h"
#import "YS_HD_Controller.h"
#import "YS_YSCG_Controller.h"

@implementation YSView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"YSView" owner:self options:nil][0];
    }
    return self;
}


- (IBAction)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 101:{
            
        }
            break;
        case 102:{
            
        }
            break;
        case 103:{//成果
            YS_YSCG_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_YSCG_Controller"];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 201:{
            
        }
            break;
        case 202:{//厚度
            YS_HD_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_HD_Controller"];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 301:{
            
        }
            break;
        case 302:{
            
        }
            break;
        case 303:{
            
        }
            break;
        case 401:{
            
        }
            break;
        case 402:{
            
        }
            break;
        default:
            break;
    }
    
}




//头部视图跳转控制器
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
