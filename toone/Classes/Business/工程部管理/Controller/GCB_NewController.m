//
//  GCB_NewController.m
//  toone
//
//  Created by 上海同望 on 2017/10/9.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_NewController.h"
#import "GCB_JCH_Controller.h"
#import "GCB_JZL_DetailController.h"
#import "GCB_Controller.h"
#import "GCB_WPLController.h"
#import "GCB_WC_Controller.h"

@interface GCB_NewController ()

@end
@implementation GCB_NewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self addPanGestureRecognizer];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:244/255.f alpha:1];
    
}
-(void)loadUI{
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
}

- (IBAction)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 101:{//新增
            GCB_JZL_DetailController *vc = [[GCB_JZL_DetailController alloc] init];
            vc.jzlName = 2;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 102:{//未配料
            GCB_WPLController *vc = [[GCB_WPLController alloc] init];
            vc.zt = @"0";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 103:{//已配料
            GCB_WPLController *vc = [[GCB_WPLController alloc] init];
            vc.zt = @"1";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 201:{//未提交
            GCB_WPLController *vc = [[GCB_WPLController alloc] init];
            vc.zt = @"-1";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 202:{//生产中
            GCB_WC_Controller *vc = [[GCB_WC_Controller alloc] init];
            vc.zt = @"2";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 203:{//已完成
            GCB_WC_Controller *vc = [[GCB_WC_Controller alloc] init];
            vc.zt = @"3";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 301:{//进出耗
            GCB_JCH_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_JCH_Controller"];
            [self.navigationController pushViewController:ylVC animated:YES];
            break;
        }
        case 302:{//工程进度
            GCB_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GCB_Controller"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 303:{//进场
            
            break;
        }
        case 304:{//出场
            
            break;
        }
        case 3:{
            [super pan];
            break;
        }
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
