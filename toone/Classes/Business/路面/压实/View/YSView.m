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
#import "YSMJViewController.h"
#import "YS_JLViewController.h"
#import "YS_YLJViewController.h"
#import "YS_TPWDViewController.h"
#import "SSYSViewController.h"
#import "YS_HFViewController.h"

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
            //压实度
            SSYSViewController *vc = [[SSYSViewController alloc] init];
            vc.type =2;
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 102:{
            //遍数
            SSYSViewController *vc = [[SSYSViewController alloc] init];
            vc.type =1;
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 103:{//成果
            YS_YSCG_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_YSCG_Controller"];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 201:{
            //压实回放
            YS_HFViewController *vc = [YS_HFViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 202:{//厚度
            YS_HD_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_HD_Controller"];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 301:{
            //面积统计
            YSMJViewController *vc = [YSMJViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 302:{
            //距离
            YS_JLViewController *vc = [YS_JLViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 303:{
            //压路机
            YS_YLJViewController *vc = [YS_YLJViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 401:{
            //摊铺机
            YS_TPWDViewController *vc = [YS_TPWDViewController new];
            [self.viewController.navigationController pushViewController:vc animated:YES];
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
