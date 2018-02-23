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
#define RoadID @"Road_id"
#define pressLayer_Num @"pressLayer"
#define device_Num @"device_Num"

@interface SSYSViewController ()<UIScrollViewDelegate>
{
    float road_min_x;
    float road_min_y;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorImg_Cons_height;
@property (nonatomic,strong) NSMutableDictionary *paraDic;
@property (nonatomic,strong) YSRoadView *road;
@property (nonatomic,strong) Exp_Final *expView;


@end

@implementation SSYSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgScroll.contentSize = CGSizeMake(Screen_w, Screen_h);
    self.bgScroll.minimumZoomScale = 0.3;
    self.bgScroll.maximumZoomScale = 10;
    self.bgScroll.contentOffset = CGPointMake(0, 0);
    [self.bgScroll setZoomScale:5 animated:NO];
    self.bgScroll.delegate = self;
    self.road = [[YSRoadView alloc] initWithFrame:CGRectMake(0, 0, Screen_w, Screen_h)];
    self.road.type = _type;
    [self.bgScroll addSubview:_road];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    if (_type == 1)
    {
        //遍数
        _label1.text = [NSString stringWithFormat:@"当前路线 :%@",[UserDefaultsSetting shareSetting].road_name];
        _label2.text = [NSString stringWithFormat:@"当前面层 :上面层"];
        _label3.text = [NSString stringWithFormat:@"当前设备 : "];
        self.colorImg.image = [UIImage imageNamed:@"色条"];
        [self bianshuTypeRequest];
    }
    else
    {
        //压实度
        self.colorImg.image = [UIImage imageNamed:@"压实度色条"];
        _label2.text = [NSString stringWithFormat:@"当前路线 :%@",[UserDefaultsSetting shareSetting].road_name];
        _label3.text = [NSString stringWithFormat:@"当前面层 :上面层"];
        _colorImg_Cons_height.constant = 60;
        [self biaozhunRequest];
    }
    
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
    NSArray *keyArr;
    NSArray *titleArr;
    NSArray *typeArr;
    if (_type == 1) //遍数
    {
        keyArr = @[RoadID,pressLayer_Num,device_Num];
        titleArr = @[@"线路选择",@"面层选择",@"设备选择"];
        typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_RoadID],[NSNumber numberWithInteger:YS_Search_Type_Layer],[NSNumber numberWithInteger:YS_Search_Type_Divce_YLJ_Zuobiao]];
    }
    else
    {
        //压实度
        keyArr = @[RoadID,pressLayer_Num];
        titleArr = @[@"线路选择",@"面层选择"];
        typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_RoadID],[NSNumber numberWithInteger:YS_Search_Type_Layer]];
        
    }
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
        NSArray *labels;
        if (_type == 1)
        {
            labels = @[_label1,_label2,_label3];
        }
        else
        {
            labels = @[_label2,_label3];
        }
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
                    //界面改变
                    UILabel *lab = labels[i];
                    if (weakself.type == 1)
                    {
                        switch (i)
                        {
                            case 0:
                                lab.text = [NSString stringWithFormat:@"当前路线 :%@",model.contentName];
                                break;
                            case 1:
                                lab.text = [NSString stringWithFormat:@"当前面层 :%@",model.contentName];
                                break;
                            case 2:
                                lab.text = [NSString stringWithFormat:@"当前设备 :%@",model.contentName];
                                break;
                            default:
                                break;
                        }
                    }
                    else
                    {
                        switch (i)
                        {
                            case 0:
                                lab.text = [NSString stringWithFormat:@"当前路线 :%@",model.contentName];
                                break;
                            case 1:
                                lab.text = [NSString stringWithFormat:@"当前面层 :%@",model.contentName];
                                break;
                                
                            default:
                                break;
                        }
                        
                    }
                    
                    //这里做判断因为其他筛选条件都传的是name和id,而设备传的是name和model,获取model中的x,y从而确定设备位置,做出请求
                    if ([model.title isEqualToString:@"设备选择"])
                    {
                        YS_deviceModel *amodel = model.tempModel;
                        //滚动视图做出偏移
                        weakself.bgScroll.contentOffset = CGPointMake(Formula_x(amodel.Actual_dx-Screen_w/2,road_min_x), Formula_y(amodel.Actual_dy-Screen_h/2,road_min_y));
                        //获取请求需要的真实路面坐标值
                        CGFloat min_x = Formula_min_x(amodel.Actual_dx,road_min_x);
                        CGFloat max_x = Formula_max_x(amodel.Actual_dx,road_min_x);
                        CGFloat min_y = Formula_min_y(amodel.Actual_dy,road_min_y);
                        CGFloat max_y = Formula_max_y(amodel.Actual_dy,road_min_y);
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
            
            //移除之前的界面,重新绘制
            [weakself.road removeFromSuperview];
            weakself.road = nil;
            weakself.road = [[YSRoadView alloc] init];
            [weakself.bgScroll addSubview:weakself.road];
            
            
            
            if (_type == 1)
            {
                //遍数
                [weakself bianshuTypeRequest];
                
            }
            else
            {
                //压实度
                [weakself yashiduTypeRequest];
            }
        };
    }
    else{
        [self.view addSubview:_expView];
        
    }
    return _expView;
}

#pragma mark request

//压实度需要的所有请求
- (void)yashiduTypeRequest
{
    [self roadRequest];
    [self bianshuOrYashiduRequest];
}

- (void)bianshuTypeRequest
{
    [self roadRequest];
    [self bianshuOrYashiduRequest];
    [self deviceRequest];
}

//是否合格的标准
- (void)biaozhunRequest
{
    __weak typeof(self) weakself = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:YS_Biaozhun parameter:@{@"road_id":[UserDefaultsSetting shareSetting].road_id} success:^(id json)
    {
        weakself.road.baojingModel = [[YS_BaojingModel alloc] initWithDictionary:json error:nil];
        [self yashiduTypeRequest];
        
    }failure:^(NSError *error) {
        
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
        float max_y = 0;
        
        
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
            
            road_min_x = model.Stake_dx < road_min_x ? model.Stake_dx : road_min_x;
            road_min_y = model.Stake_dy < road_min_y ? model.Stake_dy : road_min_y;
            
            _road.offsetNum_x = road_min_x;
            _road.offsetNum_y = road_min_y;            
        }
        
        CGFloat a_width = (max_x+fabsf(road_min_x))*YS_Scale;
        CGFloat a_height = (max_y+fabsf(road_min_y))*YS_Scale;
        
        self.bgScroll.contentSize = CGSizeMake(a_width, a_height);

        self.road.frame = CGRectMake(0, 0, a_width, a_height);
        _road.leftData = leftArr;
        _road.rightData = rightArr;
        _road.gardenData = gardenArr;
        _road.bridgeData = bridgeArr;
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)bianshuOrYashiduRequest
{
    //遍数描点
    //第一次进入界面 没有选择设备,给个默认位置显示
    if (!_paraDic)
    {
        NSString *url;
        if (_type == 1)
        {
            //遍数
            url = [NSString stringWithFormat:@"%@?Road_id=%@&pressLevel=1&pressLayer=2&x_min=%f&x_max=%f&y_max=%f&y_min=%f",YS_Bianshu,[UserDefaultsSetting shareSetting].road_id,Formula_GetPoint(self.view.frame.origin.x),Formula_GetPoint(self.view.frame.size.width),Formula_GetPoint(self.view.frame.origin.y),Formula_GetPoint(-self.view.frame.size.height)];        }
        else
        {
            //压实度
            url = [NSString stringWithFormat:@"%@?Road_id=%@&pressLevel=1&pressLayer=2&x_min=%f&x_max=%f&y_max=%f&y_min=%f",YS_Yashidu,[UserDefaultsSetting shareSetting].road_id,Formula_GetPoint(self.view.frame.origin.x),Formula_GetPoint(self.view.frame.size.width),Formula_GetPoint(self.view.frame.origin.y),Formula_GetPoint(-self.view.frame.size.height)];
        }
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:url parameter:nil success:^(id json) {
            NSArray *datas = [YS_BianshuModel arrayOfModelsFromDictionaries:json];
            _road.bianshuData = datas;
            
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        NSString *url;
        if (_type == 1)
        {
            //遍数
            url = YS_Bianshu;
        }
        else
        {
            //压实度
            url = YS_Yashidu;

        }
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:url parameter:self.paraDic success:^(id json) {
            NSArray *datas = [YS_BianshuModel arrayOfModelsFromDictionaries:json];
            _road.bianshuData = datas;
            
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)deviceRequest
{
    //设备列表
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[_paraDic valueForKey:@"Road_id"] forKey:@"Road_id"];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:YS_Device_Zuobiao parameter:dic success:^(id json) {
        NSArray *arr = [json valueForKey:@"data"];
        NSArray *datas = [YS_deviceModel arrayOfModelsFromDictionaries:arr];
        _road.deviceData = datas;
        
    } failure:^(NSError *error) {
        
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.road;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGRect frame = self.road.frame;
    
    frame.origin.y = (self.bgScroll.frame.size.height - self.road.frame.size.height) > 0 ? (self.bgScroll.frame.size.height - self.road.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.bgScroll.frame.size.width - self.road.frame.size.width) > 0 ? (self.bgScroll.frame.size.width - self.road.frame.size.width) * 0.5 : 0;
    self.road.frame = frame;
    
    self.bgScroll.contentSize = CGSizeMake(self.road.frame.size.width + 30, self.road.frame.size.height + 30);
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
