//
//  ChooseViewController.m
//  toone
//
//  Created by 上海同望 on 2018/1/26.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "ChooseViewController.h"
#import "MyTabBarController.h"

@interface ChooseViewController ()


@end
@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clickBut:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{//路基
            id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            [[UIApplication sharedApplication].keyWindow.layer addTransitionWithType:@"fade"];
        }
            break;
        case 2:{//路面
            MyTabBarController * vc = (MyTabBarController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyTabBarController"];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            [[UIApplication sharedApplication].keyWindow.layer addTransitionWithType:@"fade"];
        }
            break;
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
