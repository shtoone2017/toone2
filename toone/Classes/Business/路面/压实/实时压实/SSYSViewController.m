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
    self.bgview.minimumZoomScale = 0.1;
    self.bgview.maximumZoomScale = 10;
    self.bgview.zoomScale = 0.5;
    self.bgview.delegate = self;
    
    self.road = [YSRoadView new];
    _road.frame = CGRectMake(0, 0, 6000, 2000);
    [self.bgview addSubview:_road];
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
        
        _road.leftData = leftArr;
        _road.rightData = rightArr;
        _road.gardenData = gardenArr;
        _road.bridgeData = bridgeArr;
        CGFloat a_width = (max_x+fabsf(min_x)) * YS_Scale+100;
        CGFloat a_height = (max_y+fabsf(min_y)) * YS_Scale+100;
        _road.frame = CGRectMake(0, 0, a_width, a_height);
        _bgview.contentSize = CGSizeMake(a_width, a_height);
        self.bgview.contentOffset = CGPointMake(0, _bgview.contentSize.height);

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
