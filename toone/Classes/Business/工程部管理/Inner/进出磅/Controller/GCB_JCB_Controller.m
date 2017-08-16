//
//  GCB_JCB_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCB_Controller.h"
#import "GCB_JC_Model.h"

@interface GCB_JCB_Controller ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContainerWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *title_sc                 ;//标题scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *text_sc                  ;//正文scrollView
@property (weak, nonatomic) IBOutlet UIView *redLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLine_x;
- (IBAction)titleButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button2                      ;//进场
@property (weak, nonatomic) IBOutlet UIButton *button3                      ;//

@property (weak, nonatomic) IBOutlet UITableView *tableView2                ;//进场
@property (weak, nonatomic) IBOutlet UITableView *tableView3;

/**********************/
@property (nonatomic,strong) NSMutableArray * datas2;
@property (nonatomic,strong) NSMutableArray * datas3;
//参数
@property (nonatomic,copy) NSString *pageNo                                ;//当前页数
@property (nonatomic,copy) NSString *maxPageItems                          ;//一页最多显示条数
@property (nonatomic,copy) NSString *departId                         ;
@property (nonatomic,copy)NSString *cailiaomingcheng;//材料名称id
@property (nonatomic,copy)NSString *tongjitype;//统计类型（0,1,2）季度、月、周
@property (nonatomic,copy)NSString *gprsbianhao;//过磅设备

@property (nonatomic,copy) NSString * tableViewSigner                       ;//列表标记
//不同页面记录的页码
@property (nonatomic,copy) NSString * pageNo2;
@property (nonatomic,copy) NSString * pageNo3;



@end
@implementation GCB_JCB_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo2 = @"1";
    self.pageNo3 = @"1";
    
    self.pageNo = @"1";
    self.maxPageItems = @"5";
    self.cailiaomingcheng = @"";
    self.departId = @"";
    self.tongjitype = @"";
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
    
    //    tableView.rowHeight = 120;
    //    [tableView registerNib:[UINib nibWithNibName:@"LLQ_ZR_Cell" bundle:nil] forCellReuseIdentifier:@"LLQ_ZR_Cell"];
    //    [tableView registerClass:[LLQ_CBCZ_Cell class] forCellReuseIdentifier:@"LLQ_CBCZ_Cell"];
}
#pragma mark - 顶部title的点击事件
- (IBAction)titleButtonClick:(UIButton *)sender {
    //视图切换
    [self addTitleButtonAnimaiton:sender];
    [self addTextScAnimaiton:sender];
}
-(void)conditionsInt:(int)count{
    
    switch (count) {
        case 1://进场
            self.pageNo = self.pageNo2;
//            self.ztstate = @"0";
            if(self.datas2==nil) {
                [self loadData];
                [self loadData];
            }
            break;
        case 2://
            self.pageNo = self.pageNo3;
//            self.ztstate = @"1";
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
    return;
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:AppJCB,_departId,_cailiaomingcheng,_gprsbianhao,_tongjitype,startTimeStamp,endTimeStamp,self.pageNo,self.maxPageItems];
    NSDictionary * dict = @{@"departType":_departId,
                            @"endTime":endTimeStamp,
                            @"startTime":startTimeStamp,
                            @"pageNo":self.pageNo,
                            @"maxPageItems":self.maxPageItems,
                            };
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_JC_Model * model = [GCB_JC_Model modelWithDict:dict];
                    
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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView == self.tableView2) {
//        LLQ_ZR_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_ZR_Cell" forIndexPath:indexPath];
//        cell.currentIndexPath = indexPath;
//        LLQ_YD_Model * model = self.datas2[indexPath.row];
//        cell.models = model;
//
//        return cell;
//    }
//    if (tableView == self.tableView3) {
//        LLQ_ZR_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_ZR_Cell" forIndexPath:indexPath];
//        cell.currentIndexPath = indexPath;
//        LLQ_YD_Model * model = self.datas3[indexPath.row];
//        cell.models = model;
//        return cell;
//    }
//    return nil;
//}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LLQ_YD_Model * model;
//    //    if (tableView == self.tableView1) {
//    //        model = self.datas1[indexPath.row];
//    //    }
//    if (tableView == self.tableView2) {
//        model = self.datas2[indexPath.row];
//    }
//    if (tableView == self.tableView3) {
//        model = self.datas3[indexPath.row];
//    }
//    NSDictionary * dic=@{@"F_GUID":model.f_GUID,
//                         //                         @"shebeibianhao":model.sbbh,
//                         //                         @"chuli":model.chuli,
//                         //                         @"shenhe":model.shenhe,
//                         //                         @"zxdwshenhe":model.zxdwshenhe
//                         };
//    LLQ_YD_DetailController *mxeDetaVc = [[LLQ_YD_DetailController alloc] init];
//    mxeDetaVc.f_GUID = model.f_GUID;
//    [self.navigationController pushViewController:mxeDetaVc animated:YES];
//
//    //    [self performSegueWithIdentifier:@"LLQ_CBCZ_DetailController" sender:dic];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
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
            //            weakSelf.pageNo = @"1";
            //            weakSelf.cllx = @"0";
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {//组织机构
            UIButton * btn = (UIButton*)obj1;
            [weakSelf performSegueWithIdentifier:@"GCB_RWD_Controller" sender:btn];
        }
        if (type == ExpButtonTypeUsePosition) {//状态
            UIButton * btn = (UIButton*)obj1;
            [weakSelf performSegueWithIdentifier:@"LQ_UsePosition_Controller" sender:btn];
        }
        if (type == ExpButtonTypeEarthwork) {//设计
            
        }
    };
    [self.view addSubview:e];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id vc = segue.destinationViewController;
    
}






@end
