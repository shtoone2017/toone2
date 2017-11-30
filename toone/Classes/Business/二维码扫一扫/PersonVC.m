//
//  PersonVC.m
//  toone
//
//  Created by sg on 2017/4/19.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "PersonVC.h"
#import "SYS_ScanningController.h"

#import "SGGenerateQRCodeVC.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
@interface PersonVC ()
- (IBAction)click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaohao;

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传";
//    self.userLabel.text = self.userFullName;
    self.userLabel.text = [UserDefaultsSetting shareSetting].userFullName;
    self.biaohao.text = self.jump_shebeibianhao;
}


- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 2:{
            break;
        }
        case 3:{//上传
            [self loadData];
            break;
        }
            
        default:
            break;
    }
}
-(void)loadData {
    NSString *urlString = [NSString stringWithFormat:AppQrcod,_jump_shebeibianhao,_userLabel.text];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
    
    [HTTP requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]){
            if (EqualToString(json[@"status"], @"2")) {
                [hud hideAnimated:YES];
                SYS_ScanningController *vc = [[SYS_ScanningController alloc] init];
                NSDictionary *dict = @{@"lq":json[@"data"][@"lq"],
                                       @"startTime":json[@"data"][@"startTime"],
                                       @"userName":json[@"data"][@"userName"],
                                       };
                vc.conditonDict = dict;
                [self presentViewController:vc animated:YES completion:^{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        UIViewController * vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                        [self.navigationController popToViewController:vc animated:YES];
                    });
                }];                
                return ;
            }else if (EqualToString(json[@"status"], @"1")) {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"上传成功，开始养护";
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    UIViewController * vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                    [self.navigationController popToViewController:vc animated:YES];
                });
            }
        }else{
            hud.mode = MBProgressHUDModeText;
            hud.label.text = json[@"description"];
        }
        [hud hideAnimated:YES afterDelay:2.0];
    } failure:^(NSError *error) {
        
    }];
}


@end
