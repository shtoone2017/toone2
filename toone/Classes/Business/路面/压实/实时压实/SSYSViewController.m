//
//  SSYSViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "SSYSViewController.h"
#import "YSRoadView.h"
#import "Exp_Final.h"
#define road_id @"Road_id"
#define pressLayer_Num @"pressLayer"
#define device_Num @"device_Num"

@interface SSYSViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YSRoadView *road;
@property (nonatomic,strong) Exp_Final *expView;

@end

@implementation SSYSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    [self allRequest];
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (NSMutableDictionary *)paraDic
{
    if (!_paraDic)
    {
        _paraDic = [NSMutableDictionary dictionary];
    }
    return _paraDic;
}

- (void)searchButtonClick
{
    [self get_expView];
}

- (Exp_Final *)get_expView
{
    NSMutableArray *tempArr = [NSMutableArray array];
    NSArray *keyArr = @[road_id,pressLayer_Num,device_Num];
    NSArray *titleArr = @[@"线路选择",@"面层选择",@"设备选择"];
    NSArray *typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_RoadID],[NSNumber numberWithInteger:YS_Search_Type_Layer],[NSNumber numberWithInteger:YS_Search_Type_Divce_YLJ_Zuobiao]];
    for (int i = 0; i<titleArr.count; i++)
    {
        Exp_FinalModel *model = [[Exp_FinalModel alloc] init];
        model.title = titleArr[i];
        model.type = [typeArr[i] integerValue];
        model.para_key = keyArr[i];
        [tempArr addObject:model];
    };
    if (!_expView) {
        _expView = [[[NSBundle mainBundle] loadNibNamed:@"Exp_Final" owner:self options:nil] objectAtIndex:0];
        _expView.dataArr = tempArr;
        _expView.frame = CGRectMake(0, 64, Screen_w, Screen_h-64);
        [self.view addSubview:_expView];
        __weak typeof(self) weakself = self;
        _expView.SearchBlock = ^(NSArray *arr)
        {
            for (Exp_FinalModel *model in arr)
            {
                if (!model.contentId && !model.tempModel)
                {
                    [SVProgressHUD showErrorWithStatus:@"请完善查询条件"];
                    return;
                }
                else
                {
                    //这里做判断因为其他筛选条件都传的是name和id,而设备传的是name和model,获取model中的x,y从而确定设备位置,做出请求
                    if ([model.title isEqualToString:@"设备选择"])
                    {
                        YS_deviceModel *amodel = model.tempModel;
                        //滚动视图做出偏移
                        weakself.bgview.contentOffset = CGPointMake(Formula_x(amodel.Actual_dx-Screen_w/2), Formula_y(amodel.Actual_dy-Screen_h/2));
                        //获取请求需要的真实路面坐标值
                        CGFloat min_x = Formula_min_x(amodel.Actual_dx);
                        CGFloat max_x = Formula_max_x(amodel.Actual_dx);
                        CGFloat min_y = Formula_min_y(amodel.Actual_dy);
                        CGFloat max_y = Formula_max_y(amodel.Actual_dy);
                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",min_x] forKey:@"x_min"];
                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",max_x] forKey:@"x_max"];
                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",min_y] forKey:@"y_min"];
                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",max_y] forKey:@"y_max"];
                    }
                    else
                    {
                        [weakself.paraDic setObject:model.contentId forKey:model.para_key];
                        [weakself.paraDic setObject:@"1" forKey:@"pressLevel"];
                    }
                }
            }
            [weakself requestCarAndBianshu];
        };
    }
    else{
        [self.view addSubview:_expView];
        
    }
    return _expView;
}

- (void)allRequest
{
    //路线
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:[NSString stringWithFormat:@"%@?road_id=f9a816c15f7aa4ca015f7cbf18aa004d",YS_ZhuangHao] parameter:nil success:^(id json) {
        NSMutableArray *leftArr = [NSMutableArray array];
        NSMutableArray *rightArr = [NSMutableArray array];
        NSMutableArray *gardenArr = [NSMutableArray array];
        NSMutableArray *bridgeArr = [NSMutableArray array];
        NSArray *datas = [YS_ZhuangHao_Model arrayOfModelsFromDictionaries:json];
        float max_x = 0;
        float max_y = 0;
        float min_x = 0;
        float min_y = 0;
        
        for (YS_ZhuangHao_Model *model in datas)
        {
            //数据分组type
            if (model.stake_type == 1)
            {
                [leftArr addObject:model];
            }
            else if (model.stake_type == 2)
            {
                [rightArr addObject:model];
            }
            else if (model.stake_type == 3)
            {
                [gardenArr addObject:model];
            }
            else
            {
                [bridgeArr addObject:model];
            }
            
            //筛选出最大x轴值,y轴值
            max_x = model.Stake_dx > max_x ? model.Stake_dx : max_x;
            max_y = model.Stake_dy > max_y ? model.Stake_dy : max_y;
            
            min_x = model.Stake_dx < min_x ? model.Stake_dx : min_x;
            min_y = model.Stake_dy < min_y ? model.Stake_dy : min_y;
            
        }
        
        CGFloat a_width = (max_x+fabsf(min_x))*YS_Scale;
        CGFloat a_height = (max_y+fabsf(min_y))*YS_Scale;
        
        self.bgview = [UIScrollView new];
        _bgview.frame = CGRectMake(0, 0, Screen_w, Screen_h);
        _bgview.bounces = YES;
        self.bgview.contentSize = CGSizeMake(a_width, a_height);
        self.bgview.minimumZoomScale = 0.3;
        self.bgview.maximumZoomScale = 10;
        self.bgview.contentOffset = CGPointMake(0, 0);
        [self.bgview setZoomScale:5 animated:NO];
        //        [self.bgview zoomToRect:CGRectMake(0, 0, 50000, 2000) animated:NO];
        self.bgview.delegate = self;
        [self.view addSubview:_bgview];
        
        self.road = [[YSRoadView alloc] initWithFrame:CGRectMake(0, 0, a_width, a_height)];
        _road.leftData = leftArr;
        _road.rightData = rightArr;
        _road.gardenData = gardenArr;
        _road.bridgeData = bridgeArr;
        [self.bgview addSubview:_road];
        
    } failure:^(NSError *error) {
        
    }];
    
    [self requestCarAndBianshu];
}

- (void)requestCarAndBianshu
{
    //遍数描点
    if (!_paraDic)
    {
        NSString *url = [NSString stringWithFormat:@"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetGrid?Road_id=f9a816c15f7aa4ca015f7cbf18aa004d&pressLevel=1&pressLayer=2&x_min=%f&x_max=%f&y_max=%f&y_min=%f",Formula_GetPoint(self.view.frame.origin.x),Formula_GetPoint(self.view.frame.size.width),Formula_GetPoint(self.view.frame.origin.y),Formula_GetPoint(-self.view.frame.size.height)];
        
        
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:url parameter:nil success:^(id json) {
            NSArray *datas = [YS_BianshuModel arrayOfModelsFromDictionaries:json];
            _road.bianshuData = datas;
            
        } failure:^(NSError *error) {
            
        }];
        
        //设备列表
        NSString *deviceUrl = @"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_StakeController/getAPByRoad?Road_id=f9a816c15f7aa4ca015f7cbf18aa004d";
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:deviceUrl parameter:nil success:^(id json) {
            NSArray *arr = [json valueForKey:@"data"];
            NSArray *datas = [YS_deviceModel arrayOfModelsFromDictionaries:arr];
            _road.deviceData = datas;
            
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        NSString *url = @"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetGrid";
        
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:url parameter:self.paraDic success:^(id json) {
            NSArray *datas = [YS_BianshuModel arrayOfModelsFromDictionaries:json];
            _road.bianshuData = datas;
            
        } failure:^(NSError *error) {
            
        }];
        
        //设备列表
        NSString *deviceUrl = @"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_StakeController/getAPByRoad";
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[_paraDic valueForKey:@"Road_id"] forKey:@"Road_id"];
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:deviceUrl parameter:dic success:^(id json) {
            NSArray *arr = [json valueForKey:@"data"];
            NSArray *datas = [YS_deviceModel arrayOfModelsFromDictionaries:arr];
            _road.deviceData = datas;
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.road;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGRect frame = self.road.frame;
    
    frame.origin.y = (self.bgview.frame.size.height - self.road.frame.size.height) > 0 ? (self.bgview.frame.size.height - self.road.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.bgview.frame.size.width - self.road.frame.size.width) > 0 ? (self.bgview.frame.size.width - self.road.frame.size.width) * 0.5 : 0;
    self.road.frame = frame;
    
    self.bgview.contentSize = CGSizeMake(self.road.frame.size.width + 30, self.road.frame.size.height + 30);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"--------------x:%f --------------  y:%f -----------",targetContentOffset->x,targetContentOffset->y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
