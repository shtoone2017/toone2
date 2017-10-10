//
//  SeView.m
//  Dduo
//
//  Created by 上海同望 on 2017/7/19.
//  Copyright © 2017年 FCB. All rights reserved.
//

#import "SeView.h"
#import "GCB_JCH_Controller.h"
#import "GCB_JZL_DetailController.h"
#import "GCB_Controller.h"
#import "GCB_WPLController.h"
#import "GCB_WC_Controller.h"
#import "GCB_RWD_Controller.h"
#import "GCB_JCB_NewController.h"
#import "GCB_Model.h"

@interface SeView ()



@end
@implementation SeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SeView" owner:self options:nil][0];
    }
    return self;
}
-(void)setModel:(GCB_Model *)model {
    _model = model;
    _wplLabel.text = model.notijiaoCount;
    _yplLabel.text = model.nsrCount;
    _wtjLabel.text = model.isrCount;
    _sczLabel.text = model.shengchaningCount;
    _wcLabel.text = model.isshengchancount;
}

- (IBAction)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 101:{//新增
            GCB_JZL_DetailController *vc = [[GCB_JZL_DetailController alloc] init];
            vc.jzlName = 2;
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 103:{//未配料
            GCB_WPLController *vc = [[GCB_WPLController alloc] init];
            vc.zt = @"0";
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 201:{//已配料
            GCB_WPLController *vc = [[GCB_WPLController alloc] init];
            vc.zt = @"1";
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 102:{//未提交
            GCB_WPLController *vc = [[GCB_WPLController alloc] init];
            vc.zt = @"-1";
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 202:{//生产中
            GCB_WC_Controller *vc = [[GCB_WC_Controller alloc] init];
            vc.zt = @"2";
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 203:{//已完成
            GCB_WC_Controller *vc = [[GCB_WC_Controller alloc] init];
            vc.zt = @"3";
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 301:{//任务单执行情况
            GCB_RWD_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_RWD_Controller"];
//            [self.navigationController pushViewController:ylVC animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 302:{//进出耗
            GCB_JCH_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_JCH_Controller"];
//            [self.navigationController pushViewController:ylVC animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 303:{//工程进度
            GCB_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_Controller"];
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 401:{//进场
            GCB_JCB_NewController *vc = [[GCB_JCB_NewController alloc] init];
            vc.zt = @"1";
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 402:{//出场
            GCB_JCB_NewController *vc = [[GCB_JCB_NewController alloc] init];
            vc.zt = @"2";
//            [self.navigationController pushViewController:vc animated:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            break;
        }
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
