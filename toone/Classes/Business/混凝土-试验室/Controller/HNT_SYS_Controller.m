//
//  HNT_sysController.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//
#import "Exp1View.h"
#import "HNT_SYS_Controller.h"
#import "HNT_SYS_Model.h"
#import "HNT_SYS_FrameModel.h"
#import "HNT_SYS_Cell.h"
#import "HNT_SYS_InnerController.h"
#import "NodeViewController.h"
@interface HNT_SYS_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * datas;
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;

@property (strong, nonatomic)  BBFlashCtntLabel *departName_Label2;
@end

@implementation HNT_SYS_Controller
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString * zjjg = FormatString(@"组织机构 : ", [UserDefaultsSetting shareSetting].departName);
    self.departName_Label.text = FormatString(zjjg, @"\t\t\t\t\t\t\t\t\t\t");
    self.departName_Label.textColor = [UIColor whiteColor];
    self.departName_Label.font = [UIFont systemFontOfSize:12.0];
    self.departName_Label.speed = BBFlashCtntSpeedSlow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addPanGestureRecognizer];
    [self loadUI];
//    [self loadData];
}
-(void)dealloc{
    FuncLog;
}
-(void)loadUI{
    self.containerView.backgroundColor = BLUECOLOR;
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HNT_SYS_Cell class] forCellReuseIdentifier:@"HNT_SYS_Cell"];
    
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}
-(void)loadData{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString * urlString = [NSString stringWithFormat:sysHome_3,userGroupId,startTimeStamp,endTimeStamp];
//    NSLog(@"GET 地址 \n %@",urlString);
    __weak __typeof(self)  weakSelf = self;
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSArray * subArray in json[@"data"]) {
                    HNT_SYS_FrameModel * frameModel = [[HNT_SYS_FrameModel alloc] init];
                    NSMutableArray * models = [NSMutableArray array];
                    for (NSDictionary * dict in subArray) {
                        HNT_SYS_Model * model = [HNT_SYS_Model modelWithDict:dict];
                        [models addObject:model];
                    }
                    frameModel.models = models;
                    [datas addObject:frameModel];
                }
                
            }
        }
        weakSelf.datas = datas;
        [weakSelf.tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNT_SYS_FrameModel * frameModel = self.datas[indexPath.row];
    return frameModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNT_SYS_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SYS_Cell" forIndexPath:indexPath];
    HNT_SYS_FrameModel * frameModel = self.datas[indexPath.row];
    cell.frameModel = frameModel;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HNT_SYS_FrameModel * frameModel = self.datas[indexPath.row];
    HNT_SYS_Model * model = frameModel.models.firstObject;
    [self performSegueWithIdentifier:@"HNT_SYS_InnerController" sender:model.userGroupId];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[HNT_SYS_InnerController class]]) {
        HNT_SYS_InnerController * controller = vc;
        controller.userGroupId = (NSString*)sender;
    }
    __weak typeof(self) weakSelf = self;
    if ([vc isKindOfClass:[NodeViewController class]]) {
        NodeViewController * controller = vc;
        controller.ZZJGBlock = ^(NSString *name, NSString *identifier) {
            [weakSelf.datas removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf loadData];
        };
    }
}

- (IBAction)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
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
            e.frame = CGRectMake(0, 64+35, Screen_w, 150);
            __weak __typeof(self)  weakSelf = self;
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
                    weakSelf.startTime = (NSString*)obj1;
                    weakSelf.endTime = (NSString*)obj2;
                    [weakSelf loadData];
                    FuncLog;
                }
                if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
                    UIButton * btn = (UIButton*)obj1;
                    [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
                }
            };
            [self.view addSubview:e];
            
            
            
            break;
        }
        case 3:{
            [super pan];
            break;
        }
        default:
            FuncLog;//组织机构代码块
            [self performSegueWithIdentifier:@"HNT_SYS_Controller2" sender:nil];
            
            NSNumber *number = [NSNumber numberWithInt:3];
            [UserDefaultsSetting shareSetting].funtype = number;
            break;
    }
}
@end
