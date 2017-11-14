//
//  HNT_CBCZ_Detail_ShenPi_Controller.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Detail_ShenPi_Controller.h"

@interface HNT_CBCZ_Detail_ShenPi_Controller ()
@property (weak, nonatomic) IBOutlet SGTextView *txt1;//监理结果
@property (weak, nonatomic) IBOutlet SGTextView *txt2;//监理审批
- (IBAction)commitClick:(UIButton *)sender;
@end

@implementation HNT_CBCZ_Detail_ShenPi_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"监理审批";
    self.txt1.placeholder = @"必填项，填写监理结果...";
    self.txt2.placeholder = @"必填项，填写监理审批...";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.txt1 resignFirstResponder];
    [self.txt2 resignFirstResponder];
}
- (IBAction)commitClick:(UIButton *)sender{
    if (self.txt1.text.length == 0 || self.txt2.text.length == 0 ) {
        [Tools tip:@"必填项不可为空，请填写完整信息"];
        return ;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
    
    NSString * urlString = FormatString(baseUrl, @"appHnt/AppHntChaobiaoShenpi");
    NSDictionary * dic = @{@"jieguobianhao":self.bianhao,
                           @"jianliresult":self.txt1.text,
                           @"jianlishenpi":self.txt2.text,
                           @"shenpiren":[UserDefaultsSetting shareSetting].userFullName,
                           @"shenpidate":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
//                           @"confirmdate":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                           };
    
    [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dic success:^(id json) {
        if ([json[@"success"] boolValue]){
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"提交成功,请刷新数据";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                UIViewController * vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                [self.navigationController popToViewController:vc animated:YES];
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

@end
