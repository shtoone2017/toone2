
//
//  LQ_SW_Controller.m
//  toone
//
//  Created by sg on 2017/3/10.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_SW_Controller.h"
#import "SW_ZZJG_Controller.h"
#import "LQ_SW_Model.h"
#import "LQ_SW_Cell.h"
#import "LQ_SW_InnerController.h"
#import "NodeViewController.h"
@interface LQ_SW_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;
@property (nonatomic,strong)  SW_ZZJG_Data * condition;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray * datas;

@property (nonatomic, copy) NSString *departId;
@property (nonatomic, copy) NSString *shebeibianhao;
@property (nonatomic, copy) NSString *fzlx;//类型：0，全局；1，下属部门；3，拌合机
@end
@implementation LQ_SW_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPanGestureRecognizer];
    _departId = [UserDefaultsSetting shareSetting].departId;
    _fzlx = @"";
    _shebeibianhao = @"";

    [self loadUI];
    [self loadData];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"LQ_SW_Cell" bundle:nil] forCellReuseIdentifier:@"LQ_SW_Cell"];
    
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}
-(void)loadData{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:warningStatistics,startTimeStamp,endTimeStamp,_departId,_shebeibianhao,_fzlx];
    
//    if (!self.condition || [self.condition.name isEqualToString:@"组织机构"]) {
//        SW_ZZJG_Data * condition = [[SW_ZZJG_Data alloc] init];
//        condition.departType = [UserDefaultsSetting shareSetting].userType;
//        condition.biaoshiid = [UserDefaultsSetting shareSetting].biaoshi;
//        condition.shebeibianhao = @"";
//        self.condition = condition;
//    }
//    if (!self.condition.shebeibianhao) {
//        self.condition.shebeibianhao = @"";
//    }
//    NSDictionary * dict = @{@"departType":self.condition.departType,
//                            @"biaoshiid":self.condition.biaoshiid,
//                            @"startTime":startTimeStamp,
//                            @"endTime":endTimeStamp,
//                            @"shebeibianhao":self.condition.shebeibianhao
//                            };
    __weak typeof(self)  weakSelf = self;
    
//    if(self.datas){
//        self.datas = nil;
//        [self.tableView reloadData];
//    }
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    LQ_SW_Model * model = [LQ_SW_Model modelWithDict:dict];
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
    LQ_SW_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_SW_Cell" forIndexPath:indexPath];
    LQ_SW_Model * model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LQ_SW_Model * model = self.datas[indexPath.row];
    NSDictionary * dict =@{//@"biaoshiid":model.bsId,
                           @"departType":_departId
                           };
    [self performSegueWithIdentifier:@"LQ_SW_InnerController" sender:dict];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)searchButtonClick:(UIButton *)sender {
    __weak __typeof(self)  weakSelf = self;
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
//            [self performSegueWithIdentifier:@"SW_ZZJG_Controller" sender:nil];
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                NSString * zjjg = FormatString(@"组织机构 : ", name);
                weakSelf.departName_Label.text = FormatString(zjjg, @"\t\t\t\t\t\t\t\t\t\t");
                weakSelf.departName_Label.textColor = [UIColor whiteColor];
                weakSelf.departName_Label.font = [UIFont systemFontOfSize:12.0];
                weakSelf.departName_Label.speed = BBFlashCtntSpeedSlow;
                
                weakSelf.departId = identifier;
//                weakSelf.depName = name;
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[LQ_SW_InnerController class]]) {
        LQ_SW_InnerController * controller = vc;
        controller.conditonDict = (NSDictionary*)sender;
    }
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [[UserDefaultsSetting shareSetting] addObserver:self forKeyPath:@"departId" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //    NSLog(@"change~~%@",change);
    if (!EqualToString((NSString*)change[@"new"], (NSString*)change[@"old"])) {
        [self loadData];
    }
}
-(void)dealloc{
    FuncLog;
    [[UserDefaultsSetting shareSetting] removeObserver:self forKeyPath:@"departId"];
}
@end
