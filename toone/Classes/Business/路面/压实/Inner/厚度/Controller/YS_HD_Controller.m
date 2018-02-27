//
//  YS_HD_Controller.m
//  toone
//
//  Created by 上海同望 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_HD_Controller.h"
#import "AAChartView.h"
#import "YS_HD_Model.h"
#import "YS_HD_Cell.h"
#import "YS_SB_Controller.h"

@interface YS_HD_Controller ()
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * data;
@property (nonatomic,strong) NSMutableArray * name;

@property (nonatomic, copy) NSString *start;//桩号
@property (nonatomic, copy) NSString *end;
@property (nonatomic, copy) NSString *road_id;//路线id
@property (nonatomic, copy) NSString *roadName;

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView1;
@property (nonatomic, strong) AAChartView  *aaChartView2;
@end
@implementation YS_HD_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    _road_id = [UserDefaultsSetting shareSetting].road_id?:@"";
    _start = @"";
    _end = @"";
    _roadName = [UserDefaultsSetting shareSetting].road_name?:@"";
    
    
    [self loadUI];
    [self loadData];
}
-(void)loadUI {
    self.sjLabel.text = [NSString stringWithFormat:@"当前路线： %@",_roadName];
    self.view.backgroundColor = [UIColor snowColor];
    self.title = @"路面厚度";
    self.tableView.rowHeight = 468;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YS_HD_Cell" bundle:nil] forCellReuseIdentifier:@"YS_HD_Cell"];
}

-(void)loadData {
    [Tools showActivityToView:self.view];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetThickness?road_id=%@&start=%@&end=%@",_road_id,_start,_end];
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
//        if ([json[@"success"] boolValue]) {
            if ([json isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json) {
                    YS_HD_Model * model = [YS_HD_Model modelWithDict:dict];
                    [datas addObject:model];
                }
            }
//        }
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
        [weakSelf.tableView reloadData];
        
        [Tools removeActivity];
    } failure:^(NSError *error) {
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YS_HD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"YS_HD_Cell" forIndexPath:indexPath];
    [cell setchart:_name add:_data];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)searchButtonClick:(UIButton *)sender {
    sender.enabled = NO;
    //1.
    UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(0, 64+36, Screen_w, Screen_h  -64-36);
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    backView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        backView.hidden = NO;
    });
    [self.view addSubview:backView];
    
    //2.
    ExpYS1View * e = [[ExpYS1View alloc] init];
//    [e setLabel1:nil Label2:@"开始桩号" Label3:@"结束桩号"];
    e.frame = CGRectMake(0, 64+36, Screen_w, 195);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        //        NSLog(@"ExpButtonType~~~ %d",type);
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {
            sender.enabled = YES;
            [backView removeFromSuperview];

            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton) {//路线
            UIButton * btn = (UIButton*)obj1;
            YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
            sbVc.type = SBListTypeYSLX;
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.YScallBlock = ^(NSString *name, id num) {
                [btn setTitle:name forState:UIControlStateNormal];
                _roadName = name;
                _road_id = num;
            };
        }
        if (type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
            sbVc.type = SBListTypeYSZH;
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.YScallBlock = ^(NSString *name, NSString *num) {
                [btn setTitle:name forState:UIControlStateNormal];
                _start = num;
            };
        }
        if (type == ExpButtonTypeChoiceSBButton) {
            UIButton * btn = (UIButton*)obj1;
            YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
            sbVc.type = SBListTypeYSZH;
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.YScallBlock = ^(NSString *name, NSString *num) {
                [btn setTitle:name forState:UIControlStateNormal];
                _end = num;
            };
        }
    };
    [self.view addSubview:e];
}

@end
