//
//  GCB_JZL_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JZL_Controller.h"
#import "GCB_JZL_Model.h"
#import "NodeViewController.h"
#import "HNT_BHZ_SB_Controller.h"
#import "GCB_WSC_Cell.h"
#import "GCB_YSC_Cell.h"
#import "GCB_JZL_Model.h"
#import "GCB_JZL_DetailController.h"
#import "GCB_JZL_BkView.h"
#import "YBPopupMenu.h"
#define TITLES @[@"新增", @"编辑", @"删除",@"提交"]

@interface GCB_JZL_Controller ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContainerWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *title_sc                 ;//标题scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *text_sc                  ;//正文scrollView
@property (weak, nonatomic) IBOutlet UIView *redLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLine_x;
- (IBAction)titleButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button2                      ;//未生产
@property (weak, nonatomic) IBOutlet UIButton *button3                      ;//

@property (weak, nonatomic) IBOutlet UITableView *tableView2                ;//未生产
@property (weak, nonatomic) IBOutlet UITableView *tableView3                ;//

//******************************************************************
//@property (nonatomic,strong) NSMutableArray * datas1;
@property (nonatomic,strong) NSMutableArray * datas2;
@property (nonatomic,strong) NSMutableArray * datas3;

//参数
@property (nonatomic,copy) NSString *pageNo                                ;//当前页数
@property (nonatomic,copy) NSString *maxPageItems                          ;//一页最多显示条数
@property (nonatomic,copy) NSString *departId                         ;
@property (nonatomic,copy)NSString *sjqd;//设计强度
@property (nonatomic,copy)NSString *renwuno;//任务单号
@property (nonatomic,copy)NSString *ztstate;//未生产：0 生产中及已完工 : 1

@property (nonatomic,copy) NSString * tableViewSigner                       ;//列表标记
//不同页面记录的页码
@property (nonatomic,copy) NSString * pageNo2;
@property (nonatomic,copy) NSString * pageNo3;

@property (nonatomic,copy)NSString *rwdid;//当前cell任务单编号
@property (nonatomic,copy)NSString *dearid;//编辑跳转ID
@property (nonatomic,copy)NSString *zhuant;//当前cell状态

@end
@implementation GCB_JZL_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo2 = @"1";
    self.pageNo3 = @"1";
    
    self.pageNo = @"1";
    self.maxPageItems = @"5";
    self.ztstate = @"";
    self.sjqd = @"";
    self.departId = @"";
    self.renwuno = @"";
    self.tableViewSigner = @"1";
    
    [self loadUI];
    [self loadData];
    
}
-(void)loadUI{
    self.ContainerWidth.constant = Screen_w*2;
    self.title_sc.backgroundColor = [UIColor snowColor];
    //self.searchButton.backgroundColor = [UIColor snowColor];//black75PercentColor
    
    //    [self registerTableView:self.tableView1];
    [self registerTableView:self.tableView2];
    [self registerTableView:self.tableView3];
    
}
-(void)registerTableView:(UITableView*)tableView{
    tableView.tableFooterView = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        switch ([weakSelf.tableViewSigner intValue]) {
            case 1:
                weakSelf.pageNo2 = @"1";
                break;
            case 2:
                weakSelf.pageNo3 = @"1";
                break;
            default:
                break;
        }
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        switch ([weakSelf.tableViewSigner intValue]) {
            case 1:
                weakSelf.pageNo2 = FormatInt([weakSelf.pageNo2 intValue]+1);
                weakSelf.pageNo = weakSelf.pageNo2;
                break;
            case 2:
                weakSelf.pageNo3 = FormatInt([weakSelf.pageNo3 intValue]+1);
                weakSelf.pageNo = weakSelf.pageNo3;
                break;
            default:
                break;
        }
        
        [weakSelf loadData];
    }];
    tableView.rowHeight = 240;
    [tableView registerNib:[UINib nibWithNibName:@"GCB_YSC_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_YSC_Cell"];
    [tableView registerNib:[UINib nibWithNibName:@"GCB_WSC_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_WSC_Cell"];
}
#pragma mark - 顶部title的点击事件
- (IBAction)titleButtonClick:(UIButton *)sender {
    //视图切换
    [self addTitleButtonAnimaiton:sender];
    [self addTextScAnimaiton:sender];
}
-(void)conditionsInt:(int)count{
    
    switch (count) {
        case 1://未生产
            self.pageNo = self.pageNo2;
            self.ztstate = @"0";
            if(self.datas2==nil) {
                [self loadData];
                [self loadData];
            }
            break;
        case 2://
            self.pageNo = self.pageNo3;
            self.ztstate = @"1";
            if(self.datas3==nil) {
                [self loadData];
                [self loadData];
            }
            break;
        default:
            break;
    }
    
}
-(void)addTitleButtonAnimaiton:(UIButton*)sender{
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button2 .titleLabel.font = [UIFont systemFontOfSize:11.0f];
    self.button3 .titleLabel.font = [UIFont systemFontOfSize:11.0f];
    
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    //    CGFloat offset = (420-Screen_w+40)*(sender.tag-1)/3;
    [UIView animateWithDuration:0.2 animations:^{
        //        self.title_sc.contentOffset = CGPointMake(offset, 0);
        self.redLine_x.constant = 70*(sender.tag-1);
        [self.redLine.superview layoutIfNeeded];
    }];
}
-(void)addTextScAnimaiton:(UIButton*)sender{
    [UIView animateWithDuration:0.2 animations:^{
        self.text_sc.contentOffset = CGPointMake(Screen_w*(sender.tag-1), 0);
    }];
}
#pragma mark - sc代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.text_sc) {
        //网络请求添加控制条件
        int  multiple = (int)(scrollView.contentOffset.x / Screen_w)+1;
        self.tableViewSigner = FormatInt(multiple);
        [self conditionsInt:multiple];
        
        //视图切换
        UIButton * btn = [self.title_sc viewWithTag:multiple];
        [self addTitleButtonAnimaiton:btn];
    }
}
#pragma mark - 网络请求
-(void)loadData{
    
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:AppJZL,_departId,_ztstate,startTimeStamp,endTimeStamp,_sjqd,_renwuno,self.pageNo,self.maxPageItems];
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_JZL_Model * model = [GCB_JZL_Model modelWithDict:dict];;
                    model.rwdId = dict[@"id"];
                    [datas addObject:model];
                }
            }
        }
        
        int i = [weakSelf.tableViewSigner intValue];
        
        switch (i) {
            case 1:
                if ([weakSelf.pageNo2 intValue] == 1) {
                    weakSelf.datas2 = datas;
                }else{
                    [weakSelf.datas2 addObjectsFromArray:datas];
                }
                [weakSelf.tableView2 reloadData];
                [weakSelf.tableView2.mj_header endRefreshing];
                [weakSelf.tableView2.mj_footer endRefreshing];
                if (weakSelf.datas2.count < ([weakSelf.pageNo2 intValue]* [weakSelf.maxPageItems intValue])) {
                    [weakSelf.tableView2.mj_footer endRefreshingWithNoMoreData];
                }
                break;
            case 2:
                if ([weakSelf.pageNo3 intValue] == 1) {
                    weakSelf.datas3 = datas;
                }else{
                    [weakSelf.datas3 addObjectsFromArray:datas];
                }
                [weakSelf.tableView3 reloadData];
                [weakSelf.tableView3.mj_header endRefreshing];
                [weakSelf.tableView3.mj_footer endRefreshing];
                if (weakSelf.datas3.count < ([weakSelf.pageNo3 intValue]* [weakSelf.maxPageItems intValue])) {
                    [weakSelf.tableView3.mj_footer endRefreshingWithNoMoreData];
                }
                break;
        }
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView2) {
        return self.datas2.count;
    }
    if (tableView == self.tableView3) {
        return self.datas3.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView2) {
        GCB_WSC_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_WSC_Cell" forIndexPath:indexPath];
        GCB_JZL_Model * model = self.datas2[indexPath.row];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
    if (tableView == self.tableView3) {
        GCB_YSC_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_YSC_Cell" forIndexPath:indexPath];
//        cell.currentIndexPath = indexPath;
        GCB_JZL_Model * model = self.datas3[indexPath.row];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GCB_JZL_Model * model;
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    
    if (tableView == self.tableView2) {//生产中(任务单)
        model = self.datas2[indexPath.row];
        _dearid = model.rwdId;
        _zhuant = model.zhuangtai;
        _rwdid = model.renwuno;
        if ([UserDefaultsSetting shareSetting].wzgcbReal) {
            CGPoint a = CGPointMake(Screen_w*0.5, rect.origin.y+220);
            [YBPopupMenu showAtPoint:a titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
                popupMenu.dismissOnSelected = YES;
                popupMenu.isShowShadow = YES;
                popupMenu.delegate = self;
                popupMenu.offset = 10;
                popupMenu.type = YBPopupMenuTypeDark;
                popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            }];
        }
    }
    if (tableView == self.tableView3) {//完工
        model = self.datas3[indexPath.row];
        _dearid = model.rwdId;
        if ([UserDefaultsSetting shareSetting].wzgcbReal) {
            if ([model.zhuangtai isEqualToString:@"2"]) {//生产中
                [self rwdAlert];
            }else {
                [SVProgressHUD showErrorWithStatus:@"生产中任务单才能结束"];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)rwdAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AlertViewTest"
                                                    message:@"message"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    alert.title = @"提示";
    alert.message = @"是否立即结束任务单";
    //显示AlertView
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self scDeleting];
    }
}
-(void)scDeleting {
    NSString * urlString = [NSString stringWithFormat:AppJSRWD,_dearid,[UserDefaultsSetting shareSetting].userFullName];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            [SVProgressHUD showSuccessWithStatus:@"任务单结束成功"];
            [self loadData];
        }if(![json[@"success"] boolValue]) {
            [SVProgressHUD showErrorWithStatus:@"任务单结束失败"];
        }
    } failure:^(NSError *error) {
        [Tools tip:@"服务器异常"];
    }];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    if ([TITLES[index] isEqualToString:@"新增"]) {
        GCB_JZL_DetailController *vc = [[GCB_JZL_DetailController alloc] init];
        vc.detailId = _dearid;
        vc.jzlName = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([TITLES[index] isEqualToString:@"编辑"]) {
        GCB_JZL_DetailController *vc = [[GCB_JZL_DetailController alloc] init];
        vc.detailId = _dearid;
        vc.jzlName = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([TITLES[index] isEqualToString:@"删除"]) {
        if ([_zhuant isEqualToString:@"-1"]) {
            [self loadDeleting];
        }else {
            [SVProgressHUD showErrorWithStatus:@"任务单已提交，无法删除"];
        }
    }
    if ([TITLES[index] isEqualToString:@"提交"]) {
        if ([_zhuant isEqualToString:@"-1"]) {
            [self loadSubmit];
        }else {
            [SVProgressHUD showErrorWithStatus:@"任务单已提交，无法再次提交"];
        }
    }
}
-(void)loadSubmit {//提交
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString * urlString = [NSString stringWithFormat:AppJZL_Tj,_dearid,[UserDefaultsSetting shareSetting].userFullName];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"任务单提交成功";
            [hud hideAnimated:YES afterDelay:2.0];
            [self loadData];
        }if(![json[@"success"] boolValue]) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"任务单提交失败";
            [hud hideAnimated:YES afterDelay:2.0];
        }
    } failure:^(NSError *error) {
        [Tools tip:@"服务器异常"];
    }];
}
-(void)loadDeleting {//删除
    NSString * urlString = [NSString stringWithFormat:AppJZL_Dele,_dearid];
    [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            [self loadData];
            [SVProgressHUD showSuccessWithStatus:@"任务单删除成功"];
        }
    } failure:^(NSError *error) {
        [Tools tip:@"服务器异常"];
    }];
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
    Exp51View * e = [[Exp51View alloc] init];
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
            //            weakSelf.pageNo = @"1";
            //            weakSelf.cllx = @"0";
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        if (type == ExpButtonTypeRwdText) {
            UITextField *text  = (UITextField*)obj1;
            _renwuno = text.text;
            [self loadData];
        }
        if (type == ExpButtonTypeUsePosition) {//组织
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
//            controller.departId = self.departId;
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.sjqd = gprsbianhao;
                [self loadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
    };
    [self.view addSubview:e];
}
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
