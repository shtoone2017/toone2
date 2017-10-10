//
//  GCB_RWD_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_RWD_Controller.h"
#import "GCB_RWD_Model.h"
#import "NodeViewController.h"
#import "HNT_BHZ_SB_Controller.h"
#import "GCB_RWD_Cell.h"

@interface GCB_RWD_Controller ()
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString * maxPageItems;//一页最多显示条数
@property (nonatomic,copy) NSString * departId;//组织机构id
@property (nonatomic,copy)NSString *sjwork;//设计强度
@property (nonatomic,copy)NSString *rwzt;//任务状态

@end
@implementation GCB_RWD_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务单执行情况";
    self.pageNo = @"1";
    self.maxPageItems = @"5";
    self.departId = @"";
    self.rwzt = @"";
    self.sjwork = @"";
    [self loadUI];
    [self loadData];
}

-(void)loadUI {
    self.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",super.startTime,super.endTime];
    
    self.view.backgroundColor = [UIColor snowColor];
    self.tb.tableFooterView = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    self.tb.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];
    
    self.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        [weakSelf loadData];
    }];
    self.tb.rowHeight = 240;
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_RWD_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_RWD_Cell"];
}
#pragma mark - 网络请求
-(void)loadData {
    
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString *depard = @"";
    if (![self.departId isEqualToString:@""]) {
        depard = self.departId;
    }else {
        depard = [UserDefaultsSetting shareSetting].departId;
    }
    NSString * urlString = [NSString stringWithFormat:AppRWD,depard,startTimeStamp,endTimeStamp,self.pageNo,self.maxPageItems,_rwzt,_sjwork];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_RWD_Model * model = [GCB_RWD_Model modelWithDict:dict];
                    model.detailId = dict[@"id"];
                    [datas addObject:model];
                }
            }
        }
        
        //1.
        if ([weakSelf.pageNo intValue] == 1) {
            weakSelf.datas = datas;
        }else{
            [weakSelf.datas addObjectsFromArray:datas];
        }
        //2.
        [weakSelf.tb reloadData];
        [weakSelf.tb.mj_header endRefreshing];
        [weakSelf.tb.mj_footer endRefreshing];
        //3.
        if (weakSelf.datas.count < ([weakSelf.pageNo intValue]* [weakSelf.maxPageItems intValue])) {
            [weakSelf.tb.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCB_RWD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_RWD_Cell" forIndexPath:indexPath];
    GCB_RWD_Model * model = self.datas[indexPath.row];
    cell.model = model;
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
    Exp52View * e = [[Exp52View alloc] init];
    e.frame = CGRectMake(0, 64+36, Screen_w, 275);
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
            //重新切换titleButton ， 搜索页码应该回归第一页码
            weakSelf.pageNo = @"1";
            weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",weakSelf.startTime,weakSelf.endTime];
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        if (type == ExpButtonTypeChoiceSBButton) {//状态
            UIButton * btn = (UIButton*)obj1;
            __weak typeof(self) weakSelf = self;
            HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
            vc.type = SBListTypeRWDZT;
            vc.callBlock = ^(NSString *banhezhanminchen, NSString *departid) {
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.rwzt = departid;
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (type == ExpButtonTypeUsePosition) {//组织机构
            UIButton * btn = (UIButton*)obj1;
            __weak typeof(self) weakSelf = self;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                weakSelf.departId = identifier;
                [btn setTitle:name forState:UIControlStateNormal];
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];

        }
        if (type == ExpButtonTypeEarthwork) {//设计
            UIButton * btn = (UIButton*)obj1;
            HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
            controller.type = SBListTypeSJQD;
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.sjwork = gprsbianhao;
                [self loadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
    };
    [self.view addSubview:e];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
