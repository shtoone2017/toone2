//
//  HNT_ChuZhi_Controller.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "HNT_ChuZhi_Controller.h"

@interface HNT_ChuZhi_Controller ()
@property (weak, nonatomic) IBOutlet SGTextView *txt;
- (IBAction)commit:(UIButton *)sender;
//指示器MB用
@property (atomic, assign) BOOL canceled;
@end

@implementation HNT_ChuZhi_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"处置";
    self.txt.placeholder = @"必填项，填写处置原因...";
}
- (IBAction)commit:(UIButton *)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    if (self.txt.text.length == 0) {
        hud.label.text = NSLocalizedString(@"您还没有输入处置原因", @"HUD cleanining up title");
        [hud hideAnimated:YES afterDelay:2.0];
        return;
    }
    
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
    
    NSString * urlString = CHUZHI;
    NSDictionary * dict = @{@"xxid":self.SYJID?:@"",@"beizhu":self.txt.text};
    [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dict success:^(id json) {
        if ([json[@"success"] boolValue]) {
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                // Do something useful in the background and update the HUD periodically.
                [self doSomeWorkWithProgress];
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [hud hideAnimated:YES];
                    UIViewController * vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                    [self.navigationController popToViewController:vc animated:YES];
                    [Tools tip:@"数据已经更新 ，请刷新界面"];
                });
            });
        }else{
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"抱歉，提交失败";
        }
        [hud hideAnimated:YES afterDelay:2.0];
    } failure:^(NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络故障，提交失败";
        [hud hideAnimated:YES afterDelay:2.0];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.txt resignFirstResponder];
}
#pragma  mark - 给指示器添加进度状态
- (void)doSomeWorkWithProgress {
    self.canceled = NO;
    // This just increases the progress indicator in a loop.
    float progress = 0.0f;
    while (progress < 1.0f) {
        if (self.canceled) break;
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
        });
        usleep(3000);
    }
}

@end
