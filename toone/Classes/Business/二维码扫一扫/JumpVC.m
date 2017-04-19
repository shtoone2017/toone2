
//
//  JumpVC.m
//  二维码扫描
//
//  Created by sg on 2017/4/19.
//  Copyright © 2017年 十国. All rights reserved.
//

#import "JumpVC.h"
#import "DataVC.h"
@interface JumpVC ()
- (IBAction)click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *shebeibianhaoLabel;
@property (weak, nonatomic) IBOutlet UISwitch *sw;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *cengmianLabel;
//指示器MB用
@property (atomic, assign) BOOL canceled;
@end

@implementation JumpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [UIButton img_20_leftWithName:@"ic_keyboard_arrow_left_white_24dp"];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.shebeibianhaoLabel.text = self.jump_shebeibianhao;
    
}
-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            DataVC * vc = [[DataVC alloc] init];
            vc.datas = @[@"普通",@"改性"] ;
            vc.title = @"沥青类型";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            DataVC * vc = [[DataVC alloc] init];
            vc.datas = @[@"上面",@"中间" ,@"下面"] ;
            vc.title = @"层面";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            [self upData];
            break;
        }
            
            
        default:
            break;
    }
}

-(void)upData{
    NSString * urlString = LqClassUpdata;
    NSString * createtime = [TimeTools timeStampWithTimeString:[TimeTools currentTime]];
    NSString * type = self.typeLabel.text ? self.typeLabel.text :@"";
    NSString * layer = self.cengmianLabel.text ? self.cengmianLabel.text :@"";
    NSString * shebeibianhao = self.jump_shebeibianhao ? self.jump_shebeibianhao :@"";
    NSString * biaoshi = self.sw.on ? @"1" :@"0";
    NSDictionary * dict = @{@"shebeibianhao":shebeibianhao,
                            @"type":type,
                            @"layer":layer,
                            @"createtime":createtime,
                            @"biaoshi":biaoshi
                            };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    if (self.typeLabel.text.length == 0 || self.cengmianLabel.text.length == 0 || self.shebeibianhaoLabel.text.length == 0) {
        hud.label.text = NSLocalizedString(@"信息不完整无法提交", @"HUD cleanining up title");
        [hud hideAnimated:YES afterDelay:2.0];
        return;
    }
    
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
    
    [HTTP requestMethod:GET urlString:urlString parameter:dict success:^(id json) {
        if ([json[@"success"] boolValue]) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                // Do something useful in the background and update the HUD periodically.
                [self doSomeWorkWithProgress];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                    [Tools tip:@"数据上传成功！"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            });
        }
    } failure:^(NSError *error) {
        
    }];
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
