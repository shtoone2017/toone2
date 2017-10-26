//
//  Car_ResultCell.m
//  toone
//
//  Created by 上海同望 on 2017/10/19.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_ResultCell.h"

@interface Car_ResultCell ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIImage *Img;

@end
@implementation Car_ResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)qsBut:(UIButton *)sender {
    [self choosePhoto];
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
        [self.viewController presentViewController:imgPC animated:YES completion:nil];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.viewController presentViewController:imgPC animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self.viewController presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark 图片选择器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取修改后的图片
    self.Img = info[UIImagePickerControllerEditedImage];
    
    _qsImg.image = info[UIImagePickerControllerEditedImage];
    
//    图片上传
    NSData *  data =[Tools compressOriginalImage:self.Img toMaxDataSizeKBytes:200];
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [[NSUserDefaults standardUserDefaults] setObject:encodedImageStr forKey:@"qsImg"];
//    [self loadIcon:data];
    
    //移除图片选择的控制器
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}



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
