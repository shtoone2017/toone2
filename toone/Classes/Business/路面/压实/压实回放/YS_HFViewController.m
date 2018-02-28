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
#import "YS_DateModel.h"

@interface YS_HFViewController ()<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    //线路上y轴是负方向最小为-1800左右,最大为26,因此我们取最大值,同时绘图要将y取反加负号
    float road_min_x;
    float road_max_y;
    NSInteger currentPickerNum;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorImg_Cons_height;
@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YSRoadView *road;
@property (nonatomic,strong) Exp_Final *expView;
@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) NSArray *pickArr;


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
    
    _pickArr = [NSArray array];
    _pickView = [UIPickerView new];
    _pickView.backgroundColor = [UIColor lightGrayColor];
    _pickView.alpha = 0;
    _pickView.frame = CGRectMake(0, Screen_h-200, Screen_w, 200);
    _pickView.delegate = self;
    _pickView.dataSource = self;
    [self.view addSubview:_pickView];
    
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
//    NSArray *keyArr;
    NSArray *titleArr;
//    NSArray *typeArr;
//    keyArr = @[@"",@"grid_layer",@"date",@"结束时间"];
    titleArr = @[@"面层选择",@"日期",@"起始时间",@"结束时间"];
//    typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_Layer]];
    for (int i = 0; i<titleArr.count; i++)
    {
        Exp_FinalModel *model = [[Exp_FinalModel alloc] init];
        model.title = titleArr[i];
        if (i == 0)
        {
            model.type = YS_Search_Type_Layer;
            model.para_key = @"grid_layer";
        }
        else
        {
            model.type = YS_Search_Type_None;
        }
//        model.para_key = keyArr[i];
        [tempArr addObject:model];
    };
    if (!_expView) {
        _expView = [[[NSBundle mainBundle] loadNibNamed:@"Exp_Final" owner:self options:nil] objectAtIndex:0];
        _expView.dataArr = tempArr;
        _expView.frame = CGRectMake(0, 64, Screen_w, 46*5);
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
                    
                }
            }
            
            //移除之前的界面,重新绘制
            [weakself.road removeFromSuperview];
            weakself.road = nil;
            weakself.road = [[YSRoadView alloc] init];
            [weakself.bgScroll addSubview:weakself.road];
            
        };
        
        _expView.CellBlock = ^(NSInteger cellNum) {
            weakself.pickView.alpha = 1;
            currentPickerNum = cellNum;
            if (cellNum == 1)
            {
                Exp_FinalModel *model = weakself.expView.dataArr[0];
                [weakself.paraDic setObject:model.contentId forKey:model.para_key];
                //日期
                [weakself requestTimeWithDate:nil cellNum:1 layer:[model.contentId integerValue]];
            }
            else if (cellNum == 2)
            {
                //开始时间
                 [weakself requestTimeWithDate:nil cellNum:2 layer:[[weakself.paraDic objectForKey:@"grid_layer"] integerValue]];
            }
            else
            {
                //结束时间
                [weakself requestTimeWithDate:nil cellNum:2 layer:[[weakself.paraDic objectForKey:@"grid_layer"] integerValue]];
            }
        };
    }
    else{
        [self.view addSubview:_expView];
        
    }
    return _expView;
}

- (void)requestTimeWithDate:(NSString *)date cellNum:(NSInteger)cellNum layer:(NSInteger)layer
{
    NSString *url;
    NSDictionary *dic;
    if (cellNum == 1)
    {
        url = YS_Date;
        dic = @{@"road_id":[UserDefaultsSetting shareSetting].road_id,@"grid_layer":@(layer)};
    }
    else
    {
        url = YS_Time;
        dic = @{@"road_id":[UserDefaultsSetting shareSetting].road_id,@"grid_layer":@(layer),@"date":date};
    }
    __weak typeof(self) weakself = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:url parameter:dic success:^(id json) {
        weakself.pickArr = [YS_DateModel arrayOfModelsFromDictionaries:json error:nil];
        [weakself.pickView reloadAllComponents];
    } failure:^(NSError *error) {
        
    }];
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

#pragma mark uipickviewdelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickArr.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lab = [UILabel new];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(Screen_w/2-75, 0, 150, 25);
    YS_DateModel *model = _pickArr[row];
    if (currentPickerNum == 1)
    {
        lab.text = model.date;
    }
    else
    {
        lab.text = [NSString stringWithFormat:@"%ld",(long)model.time];
    }
    return lab;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (currentPickerNum == 1)
    {
        [self.paraDic setObject:[_pickArr objectAtIndex:row] forKey:@"date"];
    }
    else if (currentPickerNum == 2)
    {
        [self.paraDic setObject:[_pickArr objectAtIndex:row] forKey:@"start"];
    }
    else
    {
        [self.paraDic setObject:[_pickArr objectAtIndex:row] forKey:@"end"];
    }
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
