//
//  ViewController2.m
//  GDMapTest
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 十国. All rights reserved.
//

#import "TP_DW_Controller.h"
#import "TP_SBDW_Model.h"
#import "TP_SB_Controller.h"
#import "MyNavigationController.h"


#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface TP_DW_Controller ()<MAMapViewDelegate>
- (IBAction)click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *backButtonView;
@property (weak, nonatomic) IBOutlet UIView *sbbhBackView;
@property (weak, nonatomic) IBOutlet UILabel *sbbh_Label;
@property (nonatomic,strong) NSArray * annotations;
@property (nonatomic) MAMapView * mapView;
@property (nonatomic,assign) CGFloat  mid_JD;
@property (nonatomic,assign) CGFloat  mid_WD;


@property (nonatomic,copy) NSString *  shebeibianhao ;
@end

@implementation TP_DW_Controller
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((MyNavigationController*)self.navigationController).myColor = [UIColor clearColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.shebeibianhao = @"";
    [self loadMap];
    [self loadData];
}

-(void)loadMap{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    mapView.delegate = self;
    [self.view insertSubview:mapView belowSubview:self.backButtonView];
    NSLog(@"地图中心点——————%f~~~%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    self.mapView = mapView;
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

//-------
-(void)loadData{
//    NSString *  userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *  shebeibianhao = self.shebeibianhao;
    NSString *  pageNo = @"1";
    NSString *  maxPageItems = @"15";
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * departType = [UserDefaultsSetting_SW shareSetting].userType;//组织机构类型
    NSString * biaoshiid = [UserDefaultsSetting_SW shareSetting].biaoshi;//标识id
    NSString * shebeileixing = @"";//设备类型
    NSString * urlString =  [NSString stringWithFormat:YM_DW,shebeibianhao,pageNo,maxPageItems,startTimeStamp,endTimeStamp,departType,biaoshiid,shebeileixing];
    
    if (self.annotations) {
       
        [self.mapView removeAnnotations:self.annotations];
//        [self.mapView showAnnotations:self.annotations animated:YES];
        self.annotations = nil;
    }
    
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        
        
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                NSMutableArray * annotations = [NSMutableArray array];
                CGFloat total_JD = 0.000000;
                CGFloat total_WD = 0.000000;
                int count = 0;
                for (NSDictionary * dict in json[@"data"]) {
                    TP_SBDW_Model * model = [TP_SBDW_Model modelWithDict:dict];
                    
                    // map center
                    total_JD = total_JD+ [model.donjin floatValue];
                    total_WD = total_WD+ [model.beiwei floatValue];
                    count = count + 1;
                    
                    //计算设备坐标点
                    //纬度
                    CGFloat baidu_WD = [model.beiwei floatValue];
                    //经度
                    CGFloat baidu_JD = [model.donjin floatValue];
                    
                    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                    CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(baidu_WD,baidu_JD), AMapCoordinateTypeBaidu);
                    pointAnnotation.coordinate = amapcoord;
                    pointAnnotation.title = model.banhezhanminchen;
                    pointAnnotation.subtitle = model.dongjinbeiwei;
                    
                    [annotations addObject:pointAnnotation];
                    
                }
                self.annotations = annotations;
                
                //计算地图中心点
                if (count > 0) {
                    self.mid_JD = total_JD / count;
                    self.mid_WD = total_WD / count;
                    NSLog(@"%f~~~%f",self.mid_WD,self.mid_JD);
                    [self moveToMapCenter];
                    [self drawPoint];
                }
                
                
            }
        }else{
            [Tools tip:@"success～～0"];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)moveToMapCenter{
    CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(self.mid_JD,self.mid_WD), AMapCoordinateTypeBaidu);
    CLLocationCoordinate2D center = amapcoord;
    MACoordinateSpan span;
    span.latitudeDelta =1;
    span.longitudeDelta = 1;
    MACoordinateRegion region = MACoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
}
-(void)drawPoint{
    [self.mapView addAnnotations:self.annotations];
    [self.mapView showAnnotations:self.annotations animated:YES];
}
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case 2:{
            TP_SB_Controller * sb = [[TP_SB_Controller alloc] init];
            __weak typeof(self)  weakSelf = self;
            sb.callBack = ^(NSString* shebeibianhao,NSString * name){
                weakSelf.shebeibianhao = shebeibianhao;
                weakSelf.sbbh_Label.text = name;
                [weakSelf loadData];
            };
            [self.navigationController pushViewController:sb animated:YES];
            break;
        }
    }
}
@end
