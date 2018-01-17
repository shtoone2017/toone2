//
//  GCB_NewController.m
//  toone
//
//  Created by 上海同望 on 2017/10/9.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_NewController.h"
#import "GCB_JCH_Controller.h"
#import "GCB_JZL_DetailController.h"
#import "GCB_Controller.h"
#import "GCB_WPLController.h"
#import "GCB_WC_Controller.h"
#import "GCB_RWD_Controller.h"
#import "GCB_JCB_NewController.h"
#import "GCB_Model.h"
#import "SeView.h"

@interface GCB_NewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic, strong) SeView *seView;

@end
@implementation GCB_NewController
//-(void)viewDidAppear:(BOOL)animated {
//    self.seView = [[SeView alloc] init];
//    self.tb.tableHeaderView = _seView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.seView = [[SeView alloc] init];
    self.tb.tableHeaderView = _seView;
    [self loadUI];
    [self loadData];
    [self addPanGestureRecognizer];
}
-(void)loadData{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * userGroupId;
    userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString * urlString = [NSString stringWithFormat:GCB_Home,userGroupId,startTimeStamp,endTimeStamp];

    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_Model * model = [GCB_Model modelWithDict:dict];
                    [datas addObject:model];
//                    _seView.wplLabel.text = dict[@"notijiaoCount"];
//                    _seView.yplLabel.text = dict[@"nsrCount"];
//                    _seView.wtjLabel.text = dict[@"isrCount"];
//                    _seView.sczLabel.text = dict[@"shengchaningCount"];
//                    _seView.wcLabel.text = dict[@"isshengchancount"];
                }
            }
        }
        
        self.datas = datas;
        [self.tb reloadData];
        [self.tb.mj_header endRefreshing];
    } failure:^(NSError *error) {
    }];
}

-(void)loadUI{
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb.separatorStyle = NO;
    self.tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tb.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:244/255.f alpha:1];
    self.tb.mj_header = [MJDIYHeader2 headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tb.mj_header beginRefreshing];
}
#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCB_Model * model;
    if (self.datas.count) {
        model = self.datas[0];
        _seView.model = model;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"";
    cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:244/255.f alpha:1];
    return cell;
}
- (IBAction)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 3:{
            [super pan];
            break;
        }
        case 2:{
            sender.enabled = NO;
            //1.
            UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
            backView.frame = CGRectMake(0, 64+35, Screen_w, Screen_h - 49 -64-35);
            backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            backView.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                backView.hidden = NO;
            });
            [self.view addSubview:backView];
            
            //2.
            Exp1View * e = [[Exp1View alloc] init];
            if (kDevice_Is_iPhoneX) {
                e.frame = CGRectMake(0, 88, Screen_w, 150);
            }else {
                e.frame = CGRectMake(0, 64, Screen_w, 150);
            }
            e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
                NSLog(@"%d",type);
                if (type == ExpButtonTypeCancel) {
                    sender.enabled = YES;
                    [backView removeFromSuperview];
                }
                if (type == ExpButtonTypeOk) {
                    sender.enabled = YES;
                    [backView removeFromSuperview];
                    //
                    self.startTime = (NSString*)obj1;
                    self.endTime = (NSString*)obj2;
                    [self loadData];
                    FuncLog;
                }
                if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
                    UIButton * btn = (UIButton*)obj1;
                    [self calendarWithTimeString:btn.currentTitle obj:btn];
                }
//                self.tableView.userInteractionEnabled = YES;
            };
            [self.view addSubview:e];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 删除提交刷新
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [[UserDefaultsSetting shareSetting] addObserver:self forKeyPath:@"GCBSeed" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self loadData];
}
-(void)dealloc{
    [[UserDefaultsSetting shareSetting] removeObserver:self forKeyPath:@"GCBSeed"];
    FuncLog;
}

@end
