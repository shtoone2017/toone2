//
//  SSYSViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "SSYSViewController.h"
#import "YSRoadView.h"

@interface SSYSViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) YSRoadView *road;

@end

@implementation SSYSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
        
        
        CGFloat a_width = (max_x+fabsf(min_x))*YS_Scale+100;
        CGFloat a_height = (max_y+fabsf(min_y))*YS_Scale+100;
        
        
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
    
    NSString *url = [NSString stringWithFormat:@"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetGrid?Road_id=f9a816c15f7aa4ca015f7cbf18aa004d&pressLevel=1&pressLayer=2&x_min=%f&x_max=%f&y_max=%f&y_min=%f",Formula_GetPoint(self.view.frame.origin.x),Formula_GetPoint(self.view.frame.size.width),Formula_GetPoint(self.view.frame.origin.y),Formula_GetPoint(-self.view.frame.size.height)];
    
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:url parameter:nil success:^(id json) {
        NSArray *datas = [YS_BianshuModel arrayOfModelsFromDictionaries:json];
        _road.bianshuData = datas;
        
    } failure:^(NSError *error) {
        
    }];
    
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
