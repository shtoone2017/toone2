//
//  HNT_SCCX_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "SW_LSSJ_Controller.h"
#import "SW_LSSJ_Model.h"
#import "SW_LSSJ_Cell.h"
#import "SW_LSSJ_Cell1.h"
#import "LQ_SB_Controller.h"
//#import "LQ_UsePosition_Controller.h"
#import "SW_LSSJ_DetailController.h"
#import "NodeViewController.h"
@interface SW_LSSJ_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (nonatomic,strong) NSMutableArray * datas;


// ****************************
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString * maxPageItems;//一页最多显示条数
@property (nonatomic,copy) NSString * shebeibianhao;//设备编号
@property (nonatomic,copy) NSString * usePosition;//使用部位
@property (nonatomic, copy) NSString *departId;
@end

@implementation SW_LSSJ_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = @"1";
    self.maxPageItems = @"30";
    self.shebeibianhao = @"";
    self.usePosition = @"";
    _departId = self.conditonDict[@"departType"];
    [self loadUI];
    [self loadData];
}
-(void)loadUI{
    self.sjLabel.textColor = [UIColor blackColor];
    self.sjLabel.numberOfLines = 2;
    self.sjLabel.text = [NSString stringWithFormat:@"%@开始~%@结束",self.startTime,self.endTime];
    
    self.view.backgroundColor = [UIColor snowColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        [weakSelf loadData];
    }];

//    [self.tableView registerClass:[SW_LSSJ_Cell class] forCellReuseIdentifier:@"SW_LSSJ_Cell"];
    self.tableView.rowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"SW_LSSJ_Cell1" bundle:nil] forCellReuseIdentifier:@"SW_LSSJ_Cell1"];
}
#pragma mark - 网络请求
-(void)loadData{
    
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:appSwcllist,startTimeStamp,endTimeStamp,_departId,_shebeibianhao,_pageNo,_maxPageItems];
    
//    NSDictionary * dict = @{@"departType":self.conditonDict[@"departType"],
//                            @"biaoshiid":self.conditonDict[@"biaoshiid"],
//                            @"endTime":endTimeStamp,
//                            @"startTime":startTimeStamp,
//                            @"shebeibianhao":self.shebeibianhao,
//                            @"usePosition":self.usePosition,
//                            @"pageNo":self.pageNo,
//                            @"maxPageItems":self.maxPageItems,
//                            };
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    SW_LSSJ_Model * model =  [SW_LSSJ_Model modelWithDict:dict];
//                    model.dataDict = dict;
//                    model.fieldDict = dict;
//                    model.isShow    = dict;
                    
//                    model.shebeibianhao = dict[@"sbbh"];
                    model.bianhao = dict[@"id"];
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
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        //3.
        if (weakSelf.datas.count < ([weakSelf.pageNo intValue]* [weakSelf.maxPageItems intValue])) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 4*15.0;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SW_LSSJ_Cell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"SW_LSSJ_Cell1" forIndexPath:indexPath];
    SW_LSSJ_Model * model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SW_LSSJ_Model * model = self.datas[indexPath.row];
//    self.usePosition=[model.dataDict  objectForKey:@"usePosition"];
    NSDictionary * dic=@{@"bianhao":model.bianhao,
                         @"shebeibianhao":model.shebeibianhao};
    [self performSegueWithIdentifier:@"SW_LSSJ_DetailController" sender:dic];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    e.sbLabel = @"选择设备";
    [e hiddEarthView];
    e.frame = CGRectMake(0, 64+35, Screen_w, 240);
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
            //
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            //重新切换titleButton ， 搜索页码应该回归第一页码
            weakSelf.pageNo = @"1";
            weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@开始～%@结束",weakSelf.startTime,weakSelf.endTime];
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        if (type == ExpButtonTypeChoiceSBButton) {//设备
            UIButton * btn = (UIButton*)obj1;
            LQ_SB_Controller *controller = [[LQ_SB_Controller alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            controller.title = @"选择设备";
            controller.conditonDict = @{@"userGroupId":_departId,
                                        @"bhjtype":@"5",
                                        };
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                self.shebeibianhao = gprsbianhao;
            };
            
        }
        if (type == ExpButtonTypeUsePosition) {//组织
            UIButton * btn = (UIButton*)obj1;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                [btn setTitle:name forState:UIControlStateNormal];
                weakSelf.departId = identifier;
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    };
    [self.view addSubview:e];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[SW_LSSJ_DetailController class]]) {
        SW_LSSJ_DetailController * controller = vc;
        /**
         NSDictionary * dic=@{@"bianhao":model.bianhao,
         @"shebeibianhao":model.sbbh,
         @"chuli":model.chuli,
         @"shenhe":model.shenhe};
         */
        //        NSDictionary * dict = (NSDictionary*)sender;
        controller.bianhao = [sender objectForKey:@"bianhao"];
        controller.shebeibianhao = [sender objectForKey:@"shebeibianhao"];
//        controller.position = self.usePosition;
        controller.title = @"详情";
    }
}

-(void)dealloc{
    FuncLog;
}

@end
