//
//  YS_HFViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/26.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_HFViewController.h"
#import "YSRoadView.h"
#import "Exp_Final.h"

@interface YS_HFViewController ()<UIScrollViewDelegate>
{
    //线路上y轴是负方向最小为-1800左右,最大为26,因此我们取最大值,同时绘图要将y取反加负号
    float road_min_x;
    float road_max_y;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorImg_Cons_height;
@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YSRoadView *road;
@property (nonatomic,strong) Exp_Final *expView;


@end

@implementation YS_HFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgScroll.contentSize = CGSizeMake(Screen_w, Screen_h);
    self.bgScroll.minimumZoomScale = 0.3;
    self.bgScroll.maximumZoomScale = 10;
    self.bgScroll.contentOffset = CGPointMake(0, 0);
    [self.bgScroll setZoomScale:5 animated:NO];
    self.bgScroll.delegate = self;
    self.road = [[YSRoadView alloc] initWithFrame:CGRectMake(0, 0, Screen_w, Screen_h)];
    [self.bgScroll addSubview:_road];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self roadRequest];
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
    NSArray *keyArr;
    NSArray *titleArr;
    NSArray *typeArr;
    keyArr = @[@"",@"",@"",@"结束时间"];
    titleArr = @[@"面层选择",@"日期",@"起始时间",@"结束时间"];
    typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_Layer],];
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
            for (int i = 0;i<arr.count;i++)
            {
                Exp_FinalModel *model = arr[i];
                if (!model.contentId && !model.tempModel)
                {
                    [SVProgressHUD showErrorWithStatus:@"请完善查询条件"];
                    return;
                }
                else
                {
                    //这里做判断因为其他筛选条件都传的是name和id,而设备传的是name和model,获取model中的x,y从而确定设备位置,做出请求
//                    if ([model.title isEqualToString:@"设备选择"])
//                    {
//                        YS_deviceModel *amodel = model.tempModel;
//                        //滚动视图做出偏移
//                        weakself.bgScroll.contentOffset = CGPointMake(Formula_x(amodel.Actual_dx,road_min_x)-Screen_w/2, Formula_y(amodel.Actual_dy,road_max_y)-Screen_h/2);
//                        //获取请求需要的真实路面坐标值
//                        CGFloat min_x = Formula_min_x(amodel.Actual_dx,road_min_x);
//                        CGFloat max_x = Formula_max_x(amodel.Actual_dx,road_min_x);
//                        CGFloat min_y = Formula_min_y(amodel.Actual_dy,road_max_y);
//                        CGFloat max_y = Formula_max_y(amodel.Actual_dy,road_max_y);
//                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",min_x] forKey:@"x_min"];
//                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",max_x] forKey:@"x_max"];
//                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",min_y] forKey:@"y_min"];
//                        [weakself.paraDic setObject:[NSString stringWithFormat:@"%f",max_y] forKey:@"y_max"];
//                    }
//                    else
//                    {
//                        [weakself.paraDic setObject:model.contentId forKey:model.para_key];
//                        [weakself.paraDic setObject:@"1" forKey:@"pressLevel"];
//                    }
                }
            }
            
            //移除之前的界面,重新绘制
            [weakself.road removeFromSuperview];
            weakself.road = nil;
            weakself.road = [[YSRoadView alloc] init];
            [weakself.bgScroll addSubview:weakself.road];
            
            
            
            
        };
    }
    else{
        [self.view addSubview:_expView];
        
    }
    return _expView;
}

- (void)roadRequest
{
    //路线
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:YS_ZhuangHao parameter:@{@"road_id":[UserDefaultsSetting shareSetting].road_id} success:^(id json) {
        NSMutableArray *leftArr = [NSMutableArray array];
        NSMutableArray *rightArr = [NSMutableArray array];
        NSMutableArray *gardenArr = [NSMutableArray array];
        NSMutableArray *bridgeArr = [NSMutableArray array];
        NSArray *datas = [YS_ZhuangHao_Model arrayOfModelsFromDictionaries:json];
        float max_x = 0;
        float min_y = 0;
        road_min_x = 0;
        road_max_y = 0;
        
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
            road_max_y = model.Stake_dy > road_max_y ? model.Stake_dy : road_max_y;
            
            road_min_x = model.Stake_dx < road_min_x ? model.Stake_dx : road_min_x;
            min_y = model.Stake_dy < min_y ? model.Stake_dy : min_y;
        }
        //设置roadview的偏移量,以免溢出屏外,x方向取最小值,  y方向取最大值大概为26左右
        _road.offsetNum_x = road_min_x;
        _road.offsetNum_y = road_max_y;
        CGFloat a_width = (fabsf(max_x)+fabsf(road_min_x))*YS_Scale;
        CGFloat a_height = (fabsf(road_max_y)+fabsf(min_y))*YS_Scale;
        
        self.bgScroll.contentSize = CGSizeMake(a_width, a_height);
        
        self.road.frame = CGRectMake(0, 0, a_width, a_height);
        _road.leftData = leftArr;
        _road.rightData = rightArr;
        _road.gardenData = gardenArr;
        _road.bridgeData = bridgeArr;
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)huifangAction:(id)sender {
    NSString *urlStr = @"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetPlayBackActual?road_id=f9a816c15f7aa4ca015f7cbf18aa004d&grid_layer=2&date=2017-12-04&start=10&end=11";
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlStr parameter:nil success:^(id json) {
        _road.huifangArr = [YS_HFModel arrayOfModelsFromDictionaries:json error:nil];
        
        YS_HFModel *start_model = _road.huifangArr[0];
        CGPoint startPoint = CGPointMake(Formula_x(start_model.Actual_dx, road_min_x), Formula_y(start_model.Actual_dy, road_max_y));
        _bgScroll.contentOffset = startPoint;
    } failure:^(NSError *error) {
    }];
    
}
- (IBAction)stopAction:(id)sender {
    
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
