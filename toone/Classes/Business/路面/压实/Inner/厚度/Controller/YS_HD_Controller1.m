//
//  YS_HD_Controller1.m
//  toone
//
//  Created by 上海同望 on 2018/2/23.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_HD_Controller1.h"
#import "AAChartView.h"
#import "YS_HD_Model.h"
#import "YS_SB_Controller.h"

@interface YS_HD_Controller1 ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSMutableArray * data;
@property (nonatomic,strong) NSMutableArray * name;

@property (nonatomic, copy) NSString *start;//桩号
@property (nonatomic, copy) NSString *end;
@property (nonatomic, copy) NSString *road_id;//路线id
@property (nonatomic, copy) NSString *roadName;

@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UIView *leftBtnView;
@property (nonatomic, strong) UIView *rightBtnView;
@property (nonatomic, strong) UIView *midView;

@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartModel *aaChartModel;

@property (nonatomic,assign,getter=isMoveLeft) BOOL moveLeft;
@property (nonatomic,assign,getter=isMoveRight) BOOL moveRight;

@end
@implementation YS_HD_Controller1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    _moveLeft = NO;
    _moveRight = NO;
    
//    _road_id = [UserDefaultsSetting shareSetting].road_id;
    _road_id = @"f9a816c15f7aa4ca015f7cbf18aa004d";
    _start = @"";
    _end = @"";
    _roadName = @"";
    
    
    [self loadUI];
    [self loadData];
}
-(void)loadUI {
    self.aaChartView1 = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 360)];
    self.aaChartView1.contentHeight = 360;
    [self.view addSubview:self.aaChartView1];
    
    self.chartView = [[UIView alloc] initWithFrame:CGRectMake(10, 400, 300, 120)];
    self.chartView.backgroundColor = [UIColor redColor];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [_chartView addGestureRecognizer:panGes];
    panGes.delegate = self;
    [self.view addSubview:self.chartView];
    
    self.leftBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 120)];
    _leftBtnView.backgroundColor = [UIColor greenColor];
    [self.chartView addSubview:self.leftBtnView];
    
    self.rightBtnView = [[UIView alloc] initWithFrame:CGRectMake(280-150, 0, 20, 120)];
    _rightBtnView.backgroundColor = [UIColor greenColor];
    [self.chartView addSubview:self.rightBtnView];

    CGFloat midX = _leftBtnView.frame.size.width + _leftBtnView.frame.origin.x;
    CGFloat midY = _rightBtnView.frame.origin.x - midX;
    self.midView = [[UIView alloc] initWithFrame:CGRectMake(midX, 0, midY, 120)];
    _midView.backgroundColor = [UIColor yellowColor];
    [self.chartView addSubview:self.midView];
}

-(void)loadData {
    [Tools showActivityToView:self.view];
    NSString *urlString = [NSString stringWithFormat:@"http://112.124.114.47:8088/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetThickness?road_id=%@&start=%@&end=%@",_road_id,_start,_end];
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        
        if ([json isKindOfClass:[NSArray class]]) {
            for (NSDictionary * dict in json) {
                YS_HD_Model * model = [YS_HD_Model modelWithDict:dict];
                [datas addObject:model];
            }
        }

        NSMutableArray * bars1 = [NSMutableArray array];
        NSMutableArray * bars2 = [NSMutableArray array];
        NSMutableArray * bars3 = [NSMutableArray array];
        
        NSMutableArray *name = [NSMutableArray array];
        NSMutableArray *data = [NSMutableArray array];
        
        if (datas.count) {
            for (YS_HD_Model *model in datas) {
                if (model.thickness1) {
                    
                    [bars1 addObject:model.thickness1];
                    [bars2 addObject:model.thickness2];
                    [bars3 addObject:model.thickness3];
                    
                    [name addObject:model.stake_name];
                }
            }
        }
        
        AASeriesElement *mode1 = [[AASeriesElement alloc] init];
        mode1.nameSet(@"上面层");
        mode1.dataSet(bars1);
        
        AASeriesElement *mode2 = [[AASeriesElement alloc] init];
        mode2.nameSet(@"中面层");
        mode2.dataSet(bars2);
        
        AASeriesElement *mode3 = [[AASeriesElement alloc] init];
        mode3.nameSet(@"下面层");
        mode3.dataSet(bars3);
        
        [data addObject:mode1];
        [data addObject:mode2];
        [data addObject:mode3];
        
        weakSelf.name = name;
        weakSelf.data = data;
        [Tools removeActivity];
        [self chartData];
    } failure:^(NSError *error) {
    }];
}
-(void)chartData {
    self.aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeAreaspline)
    .titleSet(@"")//图表标题
    .subtitleSet(@"")
    .categoriesSet(_name)//设置图表横轴的内容
    .yAxisTitleSet(@"")
    .seriesSet(_data);
    self.aaChartModel.dataLabelEnabled = YES;
    [self.aaChartView1 aa_drawChartWithChartModel:_aaChartModel];
}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    NSLog(@"translation == %f", translation.x);
    CGFloat leftMin = _leftBtnView.frame.origin.x;
    CGFloat leftMax = _leftBtnView.frame.size.width + _leftBtnView.frame.origin.x;
    CGFloat rightMin = _rightBtnView.frame.origin.x;
    CGFloat rightMax = _rightBtnView.frame.size.width + _rightBtnView.frame.origin.x;
    
    if (translation.x > leftMin && translation.x < leftMax) {
        _moveLeft = YES;
    }else{
        _moveLeft = NO;
    }
    if (translation.x > rightMin && translation.x < rightMax) {
        _moveRight = YES;
    }else{
        _moveRight = NO;
    }
    
    return YES;
}

-(void)move:(UIPanGestureRecognizer *)sender {
    CGPoint pt = [sender locationInView:sender.view];
    NSLog(@"translation == %f", pt.x);
    if (_moveLeft) {
//        sender.view.center = CGPointMake(sender.view.center.x +pt.x , sender.view.center.y);
        _leftBtnView.center = CGPointMake(pt.x , 100);
    }
    if (_moveRight) {
        _rightBtnView.center = CGPointMake(pt.x , 100);
    }
    
    CGFloat midX = _leftBtnView.frame.size.width + _leftBtnView.frame.origin.x;
    CGFloat midY = _rightBtnView.frame.origin.x - midX;
    self.midView.frame = CGRectMake(midX, 0, midY, 120);
    
    CGFloat leftNum = (_midView.frame.origin.x *10 / _chartView.frame.size.width);
    CGFloat rightNum = ((midX+midY) *10 / _chartView.frame.size.width);
    
    
    NSMutableArray *arry1 = [NSMutableArray array];
    NSMutableArray *arry2 = [NSMutableArray array];
    NSMutableArray *arry3 = [NSMutableArray array];
    NSMutableArray *data = [NSMutableArray array];
    for (int i = leftNum; i < rightNum; i++) {
        AASeriesElement *mode1 = [[AASeriesElement alloc] init];
        mode1 = _data[0];
        [arry1 addObject:mode1.data[i]];
//        mode1.nameSet(@"上面层");
//        mode1.dataSet(arry1);
        
        AASeriesElement *mode2 = [[AASeriesElement alloc] init];
        mode2 = _data[1];
        [arry2 addObject:mode2.data[i]];
//        mode2.nameSet(@"中面层");
//        mode2.dataSet(arry2);
        
        AASeriesElement *mode3 = [[AASeriesElement alloc] init];
        mode3 = _data[2];
        [arry3 addObject:mode3.data[i]];
//        mode3.nameSet(@"下面层");
//        mode3.dataSet(arry3);
        
    }
    AASeriesElement *mode1 = [[AASeriesElement alloc] init];
//    mode1.nameSet(@"上面层");
    mode1.dataSet(arry1);
    
    AASeriesElement *mode2 = [[AASeriesElement alloc] init];
    mode2 = _data[1];
//    mode2.nameSet(@"中面层");
    mode2.dataSet(arry2);
    
    AASeriesElement *mode3 = [[AASeriesElement alloc] init];
//    mode3.nameSet(@"下面层");
    mode3.dataSet(arry3);
    
    [data addObject:mode1];
    [data addObject:mode2];
    [data addObject:mode3];
    
    AAChartModel *dataModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeAreaspline)
    .titleSet(@"")//图表标题
    .subtitleSet(@"")
    .categoriesSet(_name)//设置图表横轴的内容
    .yAxisTitleSet(@"")
    .seriesSet(data);
    self.aaChartModel.dataLabelEnabled = YES;
    [self.aaChartView1 aa_drawChartWithChartModel:dataModel];
    
//    [self.aaChartView1 aa_refreshChartWithChartModel:data];
//    [self.aaChartView1 aa_onlyRefreshTheChartDataWithOptionsSeries:arry];//@[@{@"data":arry}]
}

@end
