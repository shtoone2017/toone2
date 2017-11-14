//
//  HNT_bhzController.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//
#import "HNT_BHZ_InnerController.h"
#import "Exp1View.h"
#import "HNT_BHZ_Controller.h"
#import "HNT_BHZ_Model.h"
#import "HNT_BHZ_Cell.h"
#import "SW_ZZJG_Controller.h"
@interface HNT_BHZ_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * datas;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic,strong)  SW_ZZJG_Data * condition;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;
@end

@implementation HNT_BHZ_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPanGestureRecognizer];
    [self loadUI];
    [self loadData];
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
    
    self.tableView.rowHeight = 140;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"HNT_BHZ_Cell" bundle:nil] forCellReuseIdentifier:@"HNT_BHZ_Cell"];
    
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}


-(void)loadData{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = AppHntMain;
    if (!self.condition|| [self.condition.name isEqualToString:@"组织机构"]) {
        SW_ZZJG_Data * condition = [[SW_ZZJG_Data alloc] init];
        condition.departType = [UserDefaultsSetting shareSetting].userType;
        condition.biaoshiid = [UserDefaultsSetting shareSetting].biaoshi;
        condition.shebeibianhao = @"";
        self.condition = condition;
    }
    if (!self.condition.shebeibianhao) {
        self.condition.shebeibianhao = @"";
    }
    NSDictionary * dict = @{@"departType":self.condition.departType,
                            @"biaoshiid":self.condition.biaoshiid,
                            @"startTime":startTimeStamp,
                            @"endTime":endTimeStamp,
                            @"shebeibianhao":self.condition.shebeibianhao
                            };
    __weak typeof(self)  weakSelf = self;
    if(self.datas){
        self.datas = nil;
        [self.tableView reloadData];
    }
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:dict success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    HNT_BHZ_Model * model = [HNT_BHZ_Model modelWithDict:dict];
                    [datas addObject:model];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNT_BHZ_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_BHZ_Cell" forIndexPath:indexPath];
    HNT_BHZ_Model * model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * departType;
    switch ([self.condition.departType intValue]) {
        case 1:
            departType = @"2";
            break;
        case 2:
            departType = @"3";
            break;
        case 3:
        case 5:
            departType = @"5";
            break;
        default:
            departType =@"1";
            break;
    }
    
    HNT_BHZ_Model * model = self.datas[indexPath.row];
    NSDictionary * dict =@{@"biaoshiid":model.bsId,
                           @"departType":departType
                           };
    [self performSegueWithIdentifier:@"HNT_BHZ_InnerController" sender:dict];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//     HNT_BHZ_Model * model = self.datas[indexPath.row];
//    [self performSegueWithIdentifier:@"HNT_BHZ_InnerController" sender:model.departId];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[HNT_BHZ_InnerController class]]) {
        HNT_BHZ_InnerController * controller = vc;
        controller.conditonDict = (NSDictionary*)sender;
    }
    
    if ([vc isKindOfClass:[SW_ZZJG_Controller class]]) {
        SW_ZZJG_Controller * controller = vc;
        __weak typeof(self) weakSelf = self;
        controller.modelType = @"1";
        controller.zzjgCallBackBlock = ^(SW_ZZJG_Data * data){
            weakSelf.condition = data;
            NSString * zjjg = FormatString(@"组织机构 : ", data.name);
            weakSelf.departName_Label.text = FormatString(zjjg, @"\t\t\t\t\t\t\t\t\t\t");
            weakSelf.departName_Label.textColor = [UIColor whiteColor];
            weakSelf.departName_Label.font = [UIFont systemFontOfSize:12.0];
            weakSelf.departName_Label.speed = BBFlashCtntSpeedSlow;
            
            [weakSelf loadData];
        };
    }
}

-(IBAction)searchButtonClick:(UIButton*)sender{
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
                    self.startTime = (NSString*)obj1;
                    self.endTime = (NSString*)obj2;
                    [weakSelf loadData];
                    FuncLog;
                }
                if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
                    UIButton * btn = (UIButton*)obj1;
                    [self calendarWithTimeString:btn.currentTitle obj:btn];
                }
                weakSelf.tableView.userInteractionEnabled = YES;
            };
            [self.view addSubview:e];
            break;
        }
        case 3:{
            [super pan];
            break;
        }
        default:
            FuncLog;
            //组织机构代码块
            [self performSegueWithIdentifier:@"SW_ZZJG_Controller" sender:nil];
            break;
    }
}
@end
