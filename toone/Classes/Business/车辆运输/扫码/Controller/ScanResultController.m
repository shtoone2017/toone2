//
//  ScanResultController.m
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ScanResultController.h"
#import "YYModel.h"
#import "Car_ScanModel.h"
#import <CoreLocation/CoreLocation.h>
#import "ScanResultCell.h"
#import "Car_ResultCell.h"

#import "ResultIconCell.h"


@interface ScanResultController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic, strong) Car_ScanModel *Headmodel;
@property (nonatomic, strong) Car_ResultCell *cell1;
@property (nonatomic, strong) ScanResultCell *submitCell;
@property (nonatomic, strong) ResultIconCell *cell2;
//@property (nonatomic,strong) UIImage *filePathImage;
//@property (nonatomic,strong) UIImage *jsImage;
@property (nonatomic, copy) NSString *loation;//坐标
//@property (nonatomic, strong) NSDictionary *dict;

@end
@implementation ScanResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运输单编辑";
    [self loadData];
    [self loadUI];
    [self getLocation];//定位
}

-(void)loadUI{
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    [self.tb registerNib:[UINib nibWithNibName:@"ScanResultCell" bundle:nil] forCellReuseIdentifier:@"ScanResultCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"Car_ResultCell" bundle:nil] forCellReuseIdentifier:@"Car_ResultCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"ResultIconCell" bundle:nil] forCellReuseIdentifier:@"ResultIconCell"];
}

-(void)loadData {
//    NSLog(@"扫码结果 == %@",_result);
    NSData* data = [self.result dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        _Headmodel = [Car_ScanModel modelWithDict:dic];
    }
}

#pragma mark - 定位
-(void)getLocation {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        currentCity = [NSString new];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}
#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    _loation = [NSString stringWithFormat:@"%zd,%zd",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude];
//    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    //    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //    //反地理编码
    //    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    //        if (placemarks.count > 0) {
    //            CLPlacemark *placeMark = placemarks[0];
    //            currentCity = placeMark.locality;
    //            if (!currentCity) {
    //                currentCity = @"无法定位当前城市";
    //            }
    //            NSLog(@"----%@",placeMark.country);//当前国家
    //            NSLog(@"%@",currentCity);//当前的城市
    //            NSLog(@"%@",placeMark.subLocality);//当前的位置
    //            //            NSLog(@"%@",placeMark.thoroughfare);//当前街道
    //            //            NSLog(@"%@",placeMark.name);//具体地址
    //            
    //        }
    //    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:return 340;
        case 1:return 190;
        case 2:return 230;
    }
    return 0.0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"提交照片";
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScanResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ScanResultCell"];
        self.submitCell = cell;
        Car_ScanModel *model = self.Headmodel;
        cell.model = model;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1 ) {
        Car_ResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Car_ResultCell"];
        self.cell1 = cell;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        ResultIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ResultIconCell"];
        self.cell2 = cell;
        [cell.submitBut addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark - 上传图片
-(void)chop:(UIImage *)img add:(NSString *)str :(MBProgressHUD *)hud{
    __block NSDictionary *dic;
    NSString *urlString = @"http://61.237.239.105:18190/FCDService/FilesUpload.asmx/FileUpload";
    NSData *data =[Tools compressOriginalImage:img toMaxDataSizeKBytes:100];
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *dict = @{@"filestr":encodedImageStr?:@"",
                           @"filename":[NSString stringWithFormat:@"%@%zd.jpg",str,[TimeTools timeStampWithTimeString:[TimeTools currentTime]]],
                           };
    
    [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dict success:^(id json) {
        if ([json[@"code"] integerValue] == 1) {
            dic = json[@"data"];
            if (_imgBlock) {
                _imgBlock(dic);
            }
        }else {
            [SVProgressHUD showImage:nil status:@"请重新提交照片"];
        }
    } failure:^(NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请求超时";
        [hud hideAnimated:YES afterDelay:2.0];
//        NSLog(@"%@",error);
    }];
}

//提交
-(void)loadIcon:(NSData *)imgData {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self)  weakSelf = self;
    __block NSDictionary *dicQs;
//    __block NSDictionary *dicJs;
    if (_submitCell.status.length == 0 || _submitCell.qsflTf.text.length == 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"必填项不可为空，请填写完整信息";
        [hud hideAnimated:YES afterDelay:2.0];
        return;
    }
    if ([_submitCell.status isEqualToString:@"签收"]) {
        if (_cell1.qsImg.image==nil) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"请上传图片";
            [hud hideAnimated:YES afterDelay:2.0];
            return;
        }else {
            //
            Car_ScanModel *model = [[Car_ScanModel alloc] init];
            model = _Headmodel;
            model.QSFL = _submitCell.qsflTf.text;
            model.loation = _loation;
            model.orderStatus = _submitCell.status;
            NSData *data = UIImageJPEGRepresentation(_cell1.qsImg.image, 1.0f);
            NSString *imgStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            model.QS_img = imgStr;
            model.orderStatus = @"签收";
            model.outsideStatus = @"未提交";
            [[Singleton shareSingleton] insertData:model];
            
            hud.mode = MBProgressHUDModeDeterminate;
            hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
            hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
//            [weakSelf chop:_cell1.qsImg.image add:@"qsImg"];
            [weakSelf chop:_cell1.qsImg.image add:@"qsImg" :hud];
            self.imgBlock = ^(NSDictionary *iconDic) {
                dicQs = iconDic;
                NSString *urlSting = @"http://61.237.239.105:18190/FCDService/FCDService.asmx/UploadQSXX";
                NSDictionary *dict = @{@"token":[UserDefaultsSetting_SW shareSetting].Token,
                                       @"fcdbh":weakSelf.Headmodel.FCDBH?:@"",
                                       @"bhzbh":weakSelf.Headmodel.BHZBH?:@"",
                                       @"qsfl":weakSelf.submitCell.qsflTf.text?:@"",
                                       @"qsr":weakSelf.Headmodel.QSR?:@"",
                                       @"xlwzmc":weakSelf.Headmodel.XLWZ?:@"",
                                       @"xlwzcode":@"1",
                                       @"xlwzzb":weakSelf.loation?:@"",
                                       @"qszp":iconDic?:@"",
                                       @"qssj":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                                       };
                
                [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlSting parameter:dict success:^(id json) {
                    if ([json isKindOfClass:[NSDictionary class]]) {
                        if ([json[@"code"] integerValue] == 1) {
                            [[Singleton shareSingleton] deleteData:model];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                UIViewController * vc = weakSelf.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                                [weakSelf.navigationController popToViewController:vc animated:YES];
                            });
                        }else {
//                            model.orderStatus = @"签收";
//                            model.outsideStatus = @"未提交";
                            [[Singleton shareSingleton] insertData:model];
                            hud.mode = MBProgressHUDModeText;
                            hud.label.text = json[@"message"];
                        }
                        [hud hideAnimated:YES afterDelay:2.0];
                    }
                } failure:^(NSError *error) {
//                    model.orderStatus = @"签收";
//                    model.outsideStatus = @"未提交";
                    [[Singleton shareSingleton] insertData:model];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"网络连接异常";
                    [hud hideAnimated:YES afterDelay:2.0];
                }];
            };
   
        }
    }
    if ([_submitCell.status isEqualToString:@"拒收"]) {
        if (([_submitCell.jsyylx isEqualToString:@"5"] && _submitCell.bzTf.text.length ==0 ) || _submitCell.jsyy.length == 0) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"必填项不可为空，请填写完整信息";
            [hud hideAnimated:YES afterDelay:2.0];
            return;
        }
        if (_cell1.qsImg.image==nil || _cell2.jsimageView.image==nil) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"请上传两张图片";
            [hud hideAnimated:YES afterDelay:2.0];
            return;
        }else {
            //
            Car_ScanModel *model = [[Car_ScanModel alloc] init];
            model = _Headmodel;
            model.QSFL = _submitCell.qsflTf.text;
            model.loation = _loation;
            model.JSYY = _submitCell.jsyy;
            model.JSYYLX = _submitCell.jsyylx;
            model.JSBZ = _submitCell.bzTf.text;
            model.orderStatus = _submitCell.status;
            NSData *data = UIImageJPEGRepresentation(_cell1.qsImg.image, 0.5f);
            NSString *imgStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            model.QS_img = imgStr;
            NSData *data2 = UIImageJPEGRepresentation(_cell2.jsimageView.image, 0.5f);
            NSString *imgStr2 = [data2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            model.JS_img = imgStr2;
            model.orderStatus = @"拒收";
            model.outsideStatus = @"未提交";
            [[Singleton shareSingleton] insertData:model];
            
            hud.mode = MBProgressHUDModeDeterminate;
            hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
            hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
//            [weakSelf chop:_cell1.qsImg.image add:@"qsImg"];
//                        [weakSelf chop:_cell2.jsimageView.image add:@"jsImg"];
            [weakSelf chop:_cell1.qsImg.image add:@"qsImg" :hud];//第一张
            self.imgBlock = ^(NSDictionary *img) {
                __block NSDictionary *dicIcon;
                NSString *urlString = @"http://61.237.239.105:18190/FCDService/FilesUpload.asmx/FileUpload";
                NSData *data =[Tools compressOriginalImage:weakSelf.cell2.jsimageView.image toMaxDataSizeKBytes:100];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                
                NSDictionary *dic = @{@"filestr":encodedImageStr?:@"",
                                       @"filename":[NSString stringWithFormat:@"jsImg%zd.jpg",[TimeTools timeStampWithTimeString:[TimeTools currentTime]]],
                                       };
                
                [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dic success:^(id json) {
                    if ([json[@"code"] integerValue] == 1) {
                        dicIcon = json[@"data"];
                        NSString *urlSting = @"http://61.237.239.105:18190/FCDService/FCDService.asmx/UploadJSXX";
                        NSDictionary *dict = @{@"token":[UserDefaultsSetting_SW shareSetting].Token,
                                               @"fcdbh":weakSelf.Headmodel.FCDBH?:@"",
                                               @"bhzbh":weakSelf.Headmodel.BHZBH?:@"",
                                               @"qsfl":weakSelf.submitCell.qsflTf.text?:@"",
                                               @"qsr":weakSelf.Headmodel.QSR?:@"",
                                               @"xlwzmc":weakSelf.Headmodel.XLWZ?:@"",
                                               @"xlwzcode":@"1",
                                               @"xlwzzb":weakSelf.loation?:@"",
                                               @"qszp":img?:@"",//签收
                                               @"qssj":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                                               @"jsyylx":weakSelf.submitCell.jsyylx?:@"",
                                               @"jsyy":weakSelf.submitCell.jsyy?:@"",
                                               @"jspz":dicIcon?:@"",//拒收
                                               };
                        
                        [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlSting parameter:dict success:^(id json) {
                            if ([json isKindOfClass:[NSDictionary class]]) {
                                if ([json[@"code"] integerValue] == 1) {
                                    [[Singleton shareSingleton] deleteData:model];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                        UIViewController * vc = weakSelf.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                                        [weakSelf.navigationController popToViewController:vc animated:YES];
                                    });
                                }else {
//                                    model.orderStatus = @"拒收";
//                                    model.outsideStatus = @"未提交";
                                    [[Singleton shareSingleton] insertData:model];
                                    hud.mode = MBProgressHUDModeText;
                                    hud.label.text = json[@"message"];
                                }
                                [hud hideAnimated:YES afterDelay:2.0];
                            }
                        } failure:^(NSError *error) {
//                            model.orderStatus = @"拒收";
//                            model.outsideStatus = @"未提交";
                            [[Singleton shareSingleton] insertData:model];
                            hud.mode = MBProgressHUDModeText;
                            hud.label.text = @"网络连接异常";
                            [hud hideAnimated:YES afterDelay:2.0];
                        }];
                    }else {
//                        model.outsideStatus = @"未提交";
                        [[Singleton shareSingleton] insertData:model];
                        [SVProgressHUD showImage:nil status:@"请重新提交照片"];
                    }
                } failure:^(NSError *error) {
//                    model.outsideStatus = @"未提交";
                    [[Singleton shareSingleton] insertData:model];
                    NSLog(@"%@",error);
                }];

            };
            
        }
    }
    
}

-(void)submitClick {
    [self loadIcon:nil];
}




@end
