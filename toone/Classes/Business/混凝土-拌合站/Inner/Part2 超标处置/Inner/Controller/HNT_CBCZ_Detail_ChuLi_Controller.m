//
//  HNT_CBCZ_Detail_ChuLi_Controller.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Detail_ChuLi_Controller.h"

@interface HNT_CBCZ_Detail_ChuLi_Controller ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet SGTextView *txt1;//原因
@property (weak, nonatomic) IBOutlet SGTextView *txt2;//方式
@property (weak, nonatomic) IBOutlet SGTextView *txt3;//结果
- (IBAction)commitClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (nonatomic,strong) UIImage * filePathImage;
@end

@implementation HNT_CBCZ_Detail_ChuLi_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"超标处置";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"photo193"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(choosePhoto)];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(choosePhoto)];
    
    self.txt1.placeholder = @"必填项，填写处置原因...";
    self.txt2.placeholder = @"必填项，填写处置方式...";
    self.txt3.placeholder = @"必填项，填写处置结果...";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.txt1 resignFirstResponder];
    [self.txt2 resignFirstResponder];
    [self.txt3 resignFirstResponder];
}
-(void)choosePhoto{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"打开一个图片源" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    // 图片选择器
    UIImagePickerController *imgPC = [[UIImagePickerController alloc] init];
    
    //设置代理
    imgPC.delegate = self;
    
    //允许编辑图片
    imgPC.allowsEditing = YES;
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imgPC.sourceType =  UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPC animated:YES completion:nil];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPC animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
#pragma mark 图片选择器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //    NSLog(@"%@",info);
    
    //获取修改后的图片
    self.filePathImage = info[UIImagePickerControllerEditedImage];
    
    //更改button里的图片
    self.imgv.image = self.filePathImage;
    
    //移除图片选择的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)commitClick:(UIButton *)sender {
    if (self.txt1.text.length == 0 || self.txt2.text.length == 0 || self.txt3.text.length == 0) {
        [Tools tip:@"必填项不可为空，请填写完整信息"];
        return ;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
    
    NSString * urlString = FormatString(baseUrl, @"app.do?AppHntChaobiaoChuzhi");
    NSDictionary * dic = @{@"jieguobianhao":self.SId,
                           @"chaobiaoyuanyin":self.txt1.text,
                           @"chuzhifangshi":self.txt2.text,
                           @"chuzhiren":[UserDefaultsSetting shareSetting].userFullName,
                           @"chuzhishijian":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                           @"chuzhijieguo":self.txt3.text,
                           @"isIos":@"1"
                           };
    
    
    NSData *  data =[Tools compressOriginalImage:self.filePathImage toMaxDataSizeKBytes:200];
    
    
    
    [[HTTP shareAFNNetworking] uploadWithUrlstring:urlString parameter:dic data:data success:^(id json) {
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
