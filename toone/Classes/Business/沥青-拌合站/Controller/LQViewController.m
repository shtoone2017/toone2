//
//  LQViewController.m
//  toone
//
//  Created by shtoone on 16/12/17.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LQViewController.h"
#import "ManageViewController.h"
#import "LqNodeViewController.h"
#import "LQ_CellModel.h"
#import "LQ_Model.h"
#import "LQ_SGModel.h"
#import "LQ_ZJM_Cell.h"
#import "LQ_ZJM_Cell2.h"
@interface LQViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *flashLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *senchBut;
@property (weak, nonatomic) IBOutlet UIView *ContreView;

@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) LQ_SGModel * model;
@end
@implementation LQViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString * zjjg = FormatString(@"组织机构 : ", [UserDefaultsSetting shareSetting].departName);
    self.flashLabel.text = FormatString(zjjg, @"\t\t\t\t\t\t\t\t\t\t");
    self.flashLabel.textColor = [UIColor whiteColor];
    self.flashLabel.font = [UIFont systemFontOfSize:12.0];
    self.flashLabel.speed = BBFlashCtntSpeedSlow;
}
static NSString * type = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    type = [UserDefaultsSetting shareSetting].type;
    [self LodaUI];
//    [self loadData];
    [self setRightBut];
}

#pragma mark - 网络请求

-(void)loadData{
    NSDictionary * dic;
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *urlString;
    if (EqualToString(type, @"GL")) {
        urlString = [NSString stringWithFormat:LQHome,userGroupId,startTimeStamp,endTimeStamp];
    }else if(EqualToString(type, @"SG")){
        urlString = [NSString stringWithFormat:LQHome2,userGroupId,startTimeStamp,endTimeStamp];
    }else{
        [Tools tip:@"无法识别的身份，不能获取数据"];
        return;
    }
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:dic success:^(id json) {
        if ([json[@"success"] boolValue]) {
            if(EqualToString(type, @"SG")){
                LQ_SGModel * model = [LQ_SGModel modelWithDict:json[@"data"]];
                self.model = model;
            }else{
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    NSMutableArray * datas=[NSMutableArray array];
                    for (NSArray * subArray in json[@"data"]) {
                        LQ_CellModel * cellModel=[[LQ_CellModel alloc] init];
                        int i=0;
                        for (NSDictionary * dic in subArray) {
                            LQ_Model * model = [LQ_Model modelWithDict:dic];
                            switch (i) {
                                case 0:
                                    cellModel.totalModel = model;
                                    break;
                                case 1:
                                    cellModel.chujiModel = model;
                                    break;
                                case 2:
                                    cellModel.zhongjiModel = model;
                                    break;
                                case 3:
                                    cellModel.gaojiModel = model;
                                    break;
                                default:
                                    break;
                            }
                            i++;
                        }
                        [datas addObject:cellModel];
                    }
                    weakSelf.datas = datas;
                }
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:nil];
}

#pragma mark - 组织机构
-(void) setRightBut {
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void) searchButtonClick:(id)sender {
    LqNodeViewController  * c=[[LqNodeViewController alloc] init] ;
//    id __weak weakSelf = self;
    __weak typeof(self) weakSelf = self;
    c.callBlock = ^(){
        [weakSelf.datas removeAllObjects];
        [weakSelf.tableView reloadData];
        [weakSelf loadData];
    };
    [self.navigationController pushViewController:c animated:YES];
    NSNumber *number = [NSNumber numberWithInt:2];
    [UserDefaultsSetting shareSetting].funtype = number;
}

#pragma mark - 查询
- (IBAction)senchClick:(UIButton *)sender {
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
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
    };
    [self.view addSubview:e];
}

#pragma mark - 一次性设置
-(void)LodaUI {
    
    self.ContreView.backgroundColor = BLUECOLOR;
    if (EqualToString(type, @"GL")) {
        self.tableView.rowHeight = 155;
    }else{
        self.tableView.rowHeight = 120;
    }
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor oldLaceColor];
    self.tableView.mj_header = [MJDIYHeader2 headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LQ_ZJM_Cell2" bundle:nil]  forCellReuseIdentifier:@"LQ_ZJM_Cell2"];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (EqualToString(type, @"GL")) {
         return _datas.count;
    }else if(EqualToString(type, @"SG")){
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (EqualToString(type, @"GL")) {
        static NSString *CellIdentifier = @"LQ_ZJM_Cell";
        UINib *nib = [UINib nibWithNibName:@"LQ_ZJM_Cell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        LQ_ZJM_Cell *cell = (LQ_ZJM_Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        LQ_CellModel * cellModel = self.datas[indexPath.row];
        cell.cellModel = cellModel;
        
        //取消选中cell背景颜色
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else if(EqualToString(type, @"SG")){
        LQ_ZJM_Cell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_ZJM_Cell2"];
        cell.model = self.model;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    
        return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ManageViewController *manageVc = [[ManageViewController alloc] init];
    [self.navigationController pushViewController:manageVc animated:YES];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
