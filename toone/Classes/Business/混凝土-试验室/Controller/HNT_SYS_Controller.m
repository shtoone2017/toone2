//
//  HNT_sysController.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//
#import "Exp1View.h"
#import "HNT_SYS_Controller.h"
#import "HNT_SYS_Model.h"
#import "HNT_SYS_FrameModel.h"
#import "HNT_SYS_Cell.h"
#import "HNT_SYS_InnerController.h"
#import "SW_ZZJG_Controller.h"
#import "SYS_MAIN_Cell.h"
#import "HNT_YLSY_Controller.h"
#import "HNT_WNSY_Controller.h"
#import "HNT_TJFX_Controller.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
@interface HNT_SYS_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HNT_SYS_Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addPanGestureRecognizer];
    [self loadUI];
}
-(void)dealloc{
    FuncLog;
}
-(void)loadUI{
//    self.containerView.backgroundColor = BLUECOLOR;
//    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
//    btn.tag  = 2;
//    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HNT_SYS_Cell class] forCellReuseIdentifier:@"HNT_SYS_Cell"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArr = @[@"压力试验",@"万能试验",@"统计分析",@"扫一扫"];
    NSArray *imgArr = @[@"SYS_YL",@"SYS_WN",@"SYS_TJ",@"SYS_sys"];
    static NSString *cellId = @"CELLID";
    SYS_MAIN_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SYS_MAIN_Cell" owner:self options:nil] firstObject];
    }
    cell.title.text = titleArr[indexPath.row];
    cell.img.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row){
        case 0:{
            //压力
            HNT_YLSY_Controller *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_YLSY_Controller"];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:{
            //万能
            HNT_WNSY_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_WNSY_Controller"];
            [self.navigationController pushViewController:ylVC animated:YES];
        }
            break;
        case 2:{
            //统计分析
            HNT_TJFX_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_TJFX_Controller"];
            [self.navigationController pushViewController:ylVC animated:YES];
        }
            break;
        case 3:{
            [self loadScan];
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *headerImg = [UIImageView new];
    headerImg.image = [UIImage imageNamed:@"SYS_Header_IMG2.jpg"];
    return headerImg;
}
-(void)loadScan {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                        [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
                        NSLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
            [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
}

@end
