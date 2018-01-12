//
//  HNT_XZ_Controller.m
//  toone
//
//  Created by 上海同望 on 2018/1/9.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "HNT_XZ_Controller.h"
#import "AFNetworking.h"
#import "HNT_XZ_HeadCell.h"
#import "HNT_XZ_Cell1.h"
#import "InputController.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
#import "HNT_XZ_SubmitCell.h"

@interface HNT_XZ_Controller ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic, strong) HNT_XZ_HeadCell *headCell;
@property (nonatomic, strong) HNT_XZ_Cell1 *cell1;
@property (nonatomic, strong) HNT_XZ_SubmitCell *submitCell;

@property (nonatomic, copy) NSString *uuid1;
@property (nonatomic, copy) NSString *uuid2;
@property (nonatomic, copy) NSString *uuid3;
@property (nonatomic, copy) NSString *timestampID1;
@property (nonatomic, copy) NSString *timestampID2;
@property (nonatomic, copy) NSString *timestampID3;

@property (nonatomic, copy) NSString *departType;
@property (nonatomic, copy) NSString *biaoshiid;
@property (nonatomic, copy) NSString *userFullName;
@end
@implementation HNT_XZ_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"养护";
    _departType = [UserDefaultsSetting shareSetting].userType;
    _biaoshiid = [UserDefaultsSetting shareSetting].biaoshi;
    _userFullName = [UserDefaultsSetting shareSetting].userFullName;
    [self loadUI];
}

-(void)loadUI{
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.tb registerNib:[UINib nibWithNibName:@"HNT_XZ_HeadCell" bundle:nil] forCellReuseIdentifier:@"HNT_XZ_HeadCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"HNT_XZ_Cell1" bundle:nil] forCellReuseIdentifier:@"HNT_XZ_Cell1"];
    [self.tb registerNib:[UINib nibWithNibName:@"HNT_XZ_SubmitCell" bundle:nil] forCellReuseIdentifier:@"HNT_XZ_SubmitCell"];
}
#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if ([_departType isEqualToString:@"1"]) {
                return 225;
            }else {
                return 190;
            }
        }
        case 1:return 165;
        case 2:return 150;
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 10)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 20)];
        headerLabel.font = [UIFont boldSystemFontOfSize:14.0];
        headerLabel.font = [UIFont fontWithName:@"PingFangTC-Bold" size:10];
        headerLabel.text = @"基本信息";
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, Screen_w, 1)];
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 3, 18)];
        leftLabel.backgroundColor = [UIColor orangeColor];
        lineLabel.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0f];
        [headerView addSubview:headerLabel];
        [headerView addSubview:lineLabel];
        [headerView addSubview:leftLabel];
        return headerView;
    }
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 10)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 20)];
        headerLabel.font = [UIFont fontWithName:@"PingFangTC-Bold" size:10];
        headerLabel.text = @"二维码";
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, Screen_w, 1)];
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 3, 18)];
        leftLabel.backgroundColor = [UIColor orangeColor];
        lineLabel.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0f];
        [headerView addSubview:headerLabel];
        [headerView addSubview:lineLabel];
        [headerView addSubview:leftLabel];
        return headerView;
    }
    if (section == 2) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 10)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 20)];
        headerLabel.font = [UIFont fontWithName:@"PingFangTC-Bold" size:10];
        headerLabel.text = @"上传";
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, Screen_w, 1)];
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 3, 18)];
        leftLabel.backgroundColor = [UIColor orangeColor];
        lineLabel.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0f];
        [headerView addSubview:headerLabel];
        [headerView addSubview:lineLabel];
        [headerView addSubview:leftLabel];
        return headerView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HNT_XZ_HeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_XZ_HeadCell"];
        self.headCell = cell;
        if (![_departType isEqualToString:@"1"]) {
            [cell hiddenView];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }if (indexPath.section == 1) {
        HNT_XZ_Cell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_XZ_Cell1"];
        self.cell1 = cell;
        [self targetCell1];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }if (indexPath.section == 2) {
        HNT_XZ_SubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_XZ_SubmitCell"];
        self.submitCell = cell;
        [cell.submitBut addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark -cell2
-(void)targetCell1 {
    [_cell1.button1 addTarget:self action:@selector(scanningClick:) forControlEvents:UIControlEventTouchUpInside];
    _cell1.button1.tag = 1;
    [_cell1.button2 addTarget:self action:@selector(scanningClick:) forControlEvents:UIControlEventTouchUpInside];
    _cell1.button2.tag = 2;
    [_cell1.button3 addTarget:self action:@selector(scanningClick:) forControlEvents:UIControlEventTouchUpInside];
    _cell1.button3.tag = 3;
    UITapGestureRecognizer *text1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(text1Click)];
    [self.cell1.view1 addGestureRecognizer:text1];
    UITapGestureRecognizer *text2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(text2Click)];
    [self.cell1.view2 addGestureRecognizer:text2];
    UITapGestureRecognizer *text3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(text3Click)];
    [self.cell1.view3 addGestureRecognizer:text3];
}

-(void)text1Click {
    [self setInput:_cell1.strText1];
}
-(void)text2Click {
    [self setInput:_cell1.strText2];
}
-(void)text3Click {
    [self setInput:_cell1.strText3];
}
-(void)setInput:(UITextField *)text {
    InputController *vc = [[InputController alloc] init];
    vc.oldString = text.text;
    vc.title = @"请输入编号";
    vc.callBlock = ^(NSString * banhezhanminchen){
        text.text = banhezhanminchen;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scanningClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            [self loadScan:sender];
        }
            break;
        case 2:{
            [self loadScan:sender];
        }
            break;
        case 3:{
            [self loadScan:sender];
        }
            break;
        default:
            break;
    }
}
-(void)loadScan:(UIButton *)sender {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                        scanningQRCodeVC.callBlock = ^(NSString *string) {
//                            NSLog(@"扫描结果 === %@",string);
                            sender.selected = !sender.selected;
                            [sender setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
                        };
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
            scanningQRCodeVC.callBlock = ^(NSString *string) {
                switch (sender.tag) {
                    case 1:{
                        _uuid1 = string;
                    }
                        break;
                    case 2:{
                        _uuid2 = string;
                    }
                        break;
                    case 3:{
                        _uuid3 = string;
                    }
                        break;
                    default:
                        break;
                }
                sender.selected = !sender.selected;
                [sender setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
            };
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

#pragma mark - 上传
-(void)submitClick {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSLog(@"====%@=====%@",_headCell.biaoshi,_headCell.departType);
    if (_headCell.lqLabel.text.length == 0 || _headCell.gcmcLabel.text.length == 0 || _headCell.sgbwLabel.text.length == 0 || _headCell.qddjLabel.text.length == 0 || _headCell.startTimeLabel.text.length == 0 || _cell1.strText1.text.length == 0 || _cell1.strText2.text.length == 0 || _cell1.strText3.text.length == 0 || _uuid1.length == 0 || _uuid2.length == 0 || _uuid3.length == 0 || _headCell.zzjgLabel.text.length == 0) {
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请填写完整信息";
        [hud hideAnimated:YES afterDelay:2.0];
        return;
    }
    NSString *startTime = [TimeTools timeStampWithTimeString:_headCell.startTimeLabel.text];
    NSInteger num = _headCell.lqLabel.text.integerValue;
    NSString *endTime = [TimeTools timeStampWithTimeString:[TimeTools time_1_dayAgo:num]];
    
    if (!(_headCell.biaoshiid.length == 0) || !(_headCell.departType.length == 0)) {//业主选为主
        _departType = _headCell.departType;
        _biaoshiid = _headCell.biaoshiid;
    }
    
    NSString *urlString = FormatString(baseUrl, @"appSys/QrcodeUpload");
    NSDictionary *dic = @{
                          @"uuid":_uuid1?:@"",
                          @"userName":_userFullName?:@"",
                          @"timestampID":_cell1.strText1.text?:@"",
                          @"lq":_headCell.lqLabel.text?:@"",
                          @"gcmc":_headCell.gcmcLabel.text?:@"",
                          @"sjqd":_headCell.qddjLabel.text?:@"",
                          @"sgbw":_headCell.sgbwLabel.text?:@"",
                          @"startTime":startTime?:@"",
                          @"endTime":endTime?:@"",
                          @"departType":_departType?:@"",
                          @"biaoshiid":_biaoshiid?:@"",
            };
    NSDictionary *dic1 = @{
                           @"uuid":_uuid2?:@"",
                           @"timestampID":_cell1.strText2.text?:@"",
                           @"userName":_userFullName?:@"",
                           @"startTime":startTime?:@"",
                           };
    NSDictionary *dic2 = @{
                           @"uuid":_uuid3?:@"",
                           @"timestampID":_cell1.strText3.text?:@"",
                           @"userName":_userFullName?:@"",
                           @"startTime":startTime?:@"",
                           };
    NSMutableArray *arry = [NSMutableArray array];
    [arry addObject:dic];
    [arry addObject:dic1];
    [arry addObject:dic2];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arry options:0 error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if ([responseObject[0][@"success"] boolValue]) {//不知是否给值
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"上传成功";
                [hud hideAnimated:YES afterDelay:2.0];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    UIViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
                    [self.navigationController popToViewController:vc animated:YES];
                });
            }else {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = responseObject[0][@"description"];
                [hud hideAnimated:YES afterDelay:2.0];
            }
        }else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
        
    }] resume];
    
}



@end
