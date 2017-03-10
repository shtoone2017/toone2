//
//  ViewController.m
//  Demo-01
//
//  Created by 成研 on 16/11/8.
//  Copyright © 2016年 tw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NoCopyTextField *acountTextField;
@property (weak, nonatomic) IBOutlet NoCopyTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
- (IBAction)loginBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *acountTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *acountLine;
@property (weak, nonatomic) IBOutlet UILabel *passwordTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *passwordLine;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
/**
 *被激活的textField
 */
@property (nonatomic,copy) NSString * nameOfTheActivatedTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _acountLine.backgroundColor = [UIColor pastelBlueColor];
    _passwordLine.backgroundColor = [UIColor pastelBlueColor];
    _loginButton.layer.cornerRadius = 20.0f;
    
   
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
    
    //
    
//    if ([UserDefaultsSetting shareSetting].isLogin) {
//        self.acountTextField.text = [UserDefaultsSetting shareSetting].acount;
//        self.passwordTextField.text = [UserDefaultsSetting shareSetting].password;
    if ([UserDefaultsSetting_SW shareSetting].isLogin) {
        self.acountTextField.text = [UserDefaultsSetting_SW shareSetting].acount;
        self.passwordTextField.text = [UserDefaultsSetting_SW shareSetting].password;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [self loginBtnClick:self.loginButton];
//        });
    }
}
- (void)keyboardWillChange:(NSNotification  *)notification{
//      NSLog(@"键盘弹出 %@", notification);
    // 1.获取键盘的Y值
    NSDictionary *dict  = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    //动画时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 2.计算需要移动的距离
    CGFloat textField_MaxY = 0.0;
    if (EqualToString(self.nameOfTheActivatedTextField, @"acountTextField")) {
        textField_MaxY = CGRectGetMaxY(_acountLine.superview.frame)+(Screen_h-568)*0.5;
    }else if (EqualToString(self.nameOfTheActivatedTextField, @"passwordTextField")){
        textField_MaxY = CGRectGetMaxY(_passwordLine.superview.frame)+(Screen_h-568)*0.5;
    }
    CGFloat translationY = keyboardY > textField_MaxY?0:(keyboardY - textField_MaxY);
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:nil];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _acountTextField) {
        self.nameOfTheActivatedTextField = @"acountTextField";
        _acountTitleLabel.hidden = NO;
        _acountTitleLabel.textColor = [UIColor pinkLipstickColor];
        _acountLine.backgroundColor = [UIColor pinkLipstickColor];
        
    }else if (textField == _passwordTextField){
        self.nameOfTheActivatedTextField = @"passwordTextField";
        _passwordTitleLabel.hidden = NO;
        _passwordTitleLabel.textColor = [UIColor pinkLipstickColor];
        _passwordLine.backgroundColor = [UIColor pinkLipstickColor];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _acountTextField) {
        _acountTitleLabel.hidden = YES;
        _acountLine.backgroundColor = [UIColor pastelBlueColor];
    }else if (textField == _passwordTextField){
        _passwordTitleLabel.hidden = YES;
        _passwordLine.backgroundColor = [UIColor pastelBlueColor];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _acountTextField) {
        [_acountTextField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    }else if (textField == _passwordTextField){
        [_passwordTextField resignFirstResponder];
        [self performSelector:@selector(loginBtnClick:) withObject:nil afterDelay:0.25];
    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_acountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
- (IBAction)loginBtnClick:(id)sender {
    [_acountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"正在登录", @"HUD loading title");
    hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
    if (_acountTextField.text.length == 0 || _passwordTextField.text.length ==0) {
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = NSLocalizedString(@"账户或密码不可为空", @"HUD cleanining up title");
        [hud hideAnimated:YES afterDelay:2.0];
        return;
    }
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.label.text = NSLocalizedString(@"正在登录", @"HUD completed title");
    
    NSString * urlString = [NSString stringWithFormat:AppLogin_2,_acountTextField.text,_passwordTextField.text];
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"success"] boolValue]) {
                //数据存储到本地
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    UserDefaultsSetting  * setting = [UserDefaultsSetting shareSetting] ;
//                    setting.acount = _acountTextField.text;
//                    setting.password = _passwordTextField.text;
//                    setting.departId  = json[@"departId"];
//                    setting.departName  = json[@"departName"];
//                    setting.userPhoneNum = json[@"userPhoneNum"];
//                    setting.userFullName = json[@"userFullName"];
//                    setting.hntchaobiaoReal = json[@"quanxian"][@"hntchaobiaoReal"];
//                    setting.hntchaobiaoSp = json[@"quanxian"][@"hntchaobiaoSp"];
//                    setting.syschaobiaoReal = json[@"quanxian"][@"syschaobiaoReal"];
//                    setting.login = YES;
//                    
//                    
//                    setting.loginDepartId  = json[@"departId"];
//                    setting.userRole  = json[@"userRole"];
//                    [setting saveToSandbox];
                    
                    UserDefaultsSetting_SW  * setting = [UserDefaultsSetting_SW shareSetting] ;
                    setting.acount = _acountTextField.text;
                    setting.password = _passwordTextField.text;
                    
                    
                    setting.login = YES;
                    [setting saveToSandbox];
                });
                
                //界面跳转
                dispatch_async(dispatch_get_main_queue(), ^{
                    id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
                    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
                    [[UIApplication sharedApplication].keyWindow.layer addTransitionWithType:@"rippleEffect"];
                });
            }else{
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"账号或密码错误";
            }
            [hud hideAnimated:YES afterDelay:2.0];
        }
    } failure:^(NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络连接异常";
        [hud hideAnimated:YES afterDelay:2.0];
    }];

}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    FuncLog;
}

@end
