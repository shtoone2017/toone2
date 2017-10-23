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
@property (nonatomic,strong) UIImage *filePathImage;
@property (nonatomic,strong) UIImage *jsImage;

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
    NSLog(@"扫码结果 == %@",_result);
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
//    [UserDefaultsSetting_SW shareSetting].loation = [NSString stringWithFormat:@"%zd,%zd",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%zd,%zd",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude] forKey:@"loation"];
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
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
        Car_ScanModel *model = self.Headmodel;
        cell.model = model;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1 ) {
        Car_ResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Car_ResultCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        ResultIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ResultIconCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return nil;
}



@end
