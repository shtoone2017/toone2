//
//  GCB_JCH_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCH_Controller.h"
#import "GCB_JCH_Model.h"
#import "GCB_JCH_Cell.h"
#import "GCB_JCH_ChartModel.h"
#import "BarModel.h"
#import "NodeViewController.h"
#import "GCB_JCH_1Cell.h"
#import "AAChartView.h"
@interface GCB_JCH_Controller ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;

@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) NSMutableArray * ChartDatas;
@property (nonatomic,copy) NSString * departId;//组织机构id

@property (nonatomic,strong) NSMutableArray * data;
@end
@implementation GCB_JCH_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.departId = @"";
    self.title = @"原材料进耗对比";
    [self loadUI];
    [self loadData];
    
}
-(void)loadUI {
    self.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",super.startTime,super.endTime];
    self.view.backgroundColor = [UIColor snowColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GCB_JCH_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_JCH_Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GCB_JCH_1Cell" bundle:nil] forCellReuseIdentifier:@"GCB_JCH_1Cell"];
}
#pragma mark - 网络请求
-(void)loadData {
    [Tools showActivityToView:self.view];
    
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:AppJCH,self.departId,startTimeStamp,endTimeStamp];
//    NSString *urlString = @"http://121.40.150.65:8083/zt11j5gs3.6.6WZ/AppWZJinChuChangController.do?list&departId=8a8ab0b246dc81120146dc8180ba0017&jinchangshijian1=1498876500&jinchangshijian2=1502073302";
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_JCH_Model * model = [GCB_JCH_Model modelWithDict:dict];
                    [datas addObject:model];
                }
            }
        }
        NSMutableArray * bars1 = [NSMutableArray array];
        NSMutableArray * bars2 = [NSMutableArray array];
        NSMutableArray * bars3 = [NSMutableArray array];
        
        NSMutableArray *name = [NSMutableArray array];
        NSMutableArray *data = [NSMutableArray array];

        if (datas.count) {
            for (GCB_JCH_Model *model in datas) {
                double value1 =  [(NSString*)model.xiaohao doubleValue];
                NSNumber *num1 = [NSNumber numberWithDouble:value1];
                [bars1 addObject:num1];
                
                double value2 =  [(NSString*)model.chuchang doubleValue];
                NSNumber *num2 = [NSNumber numberWithDouble:value2];
                [bars2 addObject:num2];
                
                double value3 =  [(NSString*)model.jinchang doubleValue];
                NSNumber *num3 = [NSNumber numberWithDouble:value3];
                [bars3 addObject:num3];
                
                [name addObject:model.cailiaoName];
            }
        }
        
        AASeriesElement *mode1 = [[AASeriesElement alloc] init];
        mode1.nameSet(@"消耗");
        mode1.dataSet(bars1);
        
        AASeriesElement *mode2 = [[AASeriesElement alloc] init];
        mode2.nameSet(@"出场");
        mode2.dataSet(bars2);
        
        AASeriesElement *mode3 = [[AASeriesElement alloc] init];
        mode3.nameSet(@"进场");
        mode3.dataSet(bars3);
        
        [data addObject:mode1];
        [data addObject:mode2];
        [data addObject:mode3];
        
        weakSelf.ChartDatas = data;
        weakSelf.datas = name;
        weakSelf.data = datas;
        [weakSelf.tableView reloadData];
        
        [Tools removeActivity];
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 468;
    }else{
        return 20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GCB_JCH_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_JCH_Cell" forIndexPath:indexPath];
        [cell setchart:_ChartDatas add:_datas];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        GCB_JCH_1Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_JCH_1Cell"];
        GCB_JCH_Model * data = self.data[indexPath.row-1];
        cell.model = data;
        cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
        return cell;
    }
    return nil;
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
    Exp5View * e = [[Exp5View alloc] init];
    e.sbLabel = @"组织机构";
    e.frame = CGRectMake(0, 64+36, Screen_w, 195);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {
            sender.enabled = YES;
            [backView removeFromSuperview];
            //
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",weakSelf.startTime,weakSelf.endTime];
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        if (type == ExpButtonTypeChoiceSBButton) {//组织机构
            UIButton * btn = (UIButton*)obj1;
            __weak typeof(self) weakSelf = self;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                weakSelf.departId = identifier;
                [btn setTitle:name forState:UIControlStateNormal];
//                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:e];
}


@end
