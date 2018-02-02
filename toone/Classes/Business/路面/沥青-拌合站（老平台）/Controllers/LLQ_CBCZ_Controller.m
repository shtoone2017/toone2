//
//  BHZ_CBCZ_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_CBCZ_Controller.h"
#import "LQ_SB_Controller.h"
#import "LLQ_CBCZ_DetailController.h"

#import "LLQ_CBCZ_Model.h"
#import "LLQ_CBCZ_Cell.h"
@interface LLQ_CBCZ_Controller ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
- (IBAction)searchButtonClick:(UIButton *)sender;
//@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContainerWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *title_sc                 ;//标题scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *text_sc                  ;//正文scrollView
@property (weak, nonatomic) IBOutlet UIView *redLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLine_x;
- (IBAction)titleButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button1                      ;//初级
@property (weak, nonatomic) IBOutlet UIButton *button2                      ;//中级
@property (weak, nonatomic) IBOutlet UIButton *button3                      ;//高级



@property (weak, nonatomic) IBOutlet UITableView *tableView1                ;//初级
@property (weak, nonatomic) IBOutlet UITableView *tableView2                ;//中级
@property (weak, nonatomic) IBOutlet UITableView *tableView3                ;//高级

//******************************************************************
@property (nonatomic,strong) NSMutableArray * datas1;
@property (nonatomic,strong) NSMutableArray * datas2;
@property (nonatomic,strong) NSMutableArray * datas3;


//参数
@property (nonatomic,copy) NSString * pageNo                                ;//当前页数
@property (nonatomic,copy) NSString * maxPageItems                          ;//一页最多显示条数
@property (nonatomic,copy) NSString * shebeibianhao                         ;//设备编号
@property (nonatomic,copy) NSString * chaobiaolx;//超标类型 0 全部 1 初级 2 中级 3 高级 dengji
@property (nonatomic,copy) NSString * cllx;//处理类型 0 全部 1 未处理 2 已处理 chuzhileixing
@property (nonatomic, copy) NSString *departId;


@property (nonatomic,copy) NSString * tableViewSigner                       ;//列表标记
//不同页面记录的页码
@property (nonatomic,copy) NSString * pageNo1;
@property (nonatomic,copy) NSString * pageNo2;
@property (nonatomic,copy) NSString * pageNo3;
@end

@implementation LLQ_CBCZ_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    {//设置初始请求条件
        self.pageNo1 = @"1";
        self.pageNo2 = @"1";
        self.pageNo3 = @"1";
        
        self.pageNo = _pageNo1;
        self.maxPageItems = @"30";
        self.chaobiaolx = @"1";//全部
        self.shebeibianhao = @"test1";
        self.cllx = @"0";
        _departId = self.conditonDict[@"departType"];
        self.tableViewSigner = @"1";
        
    }
    
    [self loadUI];
    [self loadData];
    

}

-(void)loadUI{
    self.ContainerWidth.constant = Screen_w*3;
    self.title_sc.backgroundColor = [UIColor snowColor];
    //self.searchButton.backgroundColor = [UIColor snowColor];//black75PercentColor
    
    
    [self registerTableView:self.tableView1];
    [self registerTableView:self.tableView2];
    [self registerTableView:self.tableView3];

}
-(void)registerTableView:(UITableView*)tableView{
    tableView.tableFooterView = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    tableView.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        switch ([weakSelf.tableViewSigner intValue]) {
            case 1:
                weakSelf.pageNo1 = @"1";
                break;
            case 2:
                weakSelf.pageNo2 = @"1";
                break;
            case 3:
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
                weakSelf.pageNo1 = FormatInt([weakSelf.pageNo1 intValue]+1);
                weakSelf.pageNo = weakSelf.pageNo1;
                break;
            case 2:
                weakSelf.pageNo2 = FormatInt([weakSelf.pageNo2 intValue]+1);
                weakSelf.pageNo = weakSelf.pageNo2;
                //NSLog(@"_pageNo=%@~~~_pageNo2=%@",weakSelf.pageNo,weakSelf.pageNo2);
                break;
            case 3:
                weakSelf.pageNo3 = FormatInt([weakSelf.pageNo3 intValue]+1);
                weakSelf.pageNo = weakSelf.pageNo3;
                break;
            default:
                break;
        }
        
        [weakSelf loadData];
    }];
    
    
    [tableView registerClass:[LLQ_CBCZ_Cell class] forCellReuseIdentifier:@"LLQ_CBCZ_Cell"];
}
#pragma mark - 顶部title的点击事件
- (IBAction)titleButtonClick:(UIButton *)sender {
    //视图切换
    [self addTitleButtonAnimaiton:sender];
    [self addTextScAnimaiton:sender];
}
-(void)conditionsInt:(int)count{
    
    switch (count) {
        case 1://初级
            self.pageNo = self.pageNo1;
            self.chaobiaolx =@"1";
            if(self.datas1==nil) {
                self.cllx = @"0";
                [self loadData];
            }
            break;
        case 2://中级
            self.pageNo = self.pageNo2;
            self.chaobiaolx =@"2";
            if(self.datas2==nil) {
                [self loadData];
                [self loadData];
            }
            break;
        case 3://高级
            self.pageNo = self.pageNo3;
            self.chaobiaolx =@"3";
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
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button1 .titleLabel.font = [UIFont systemFontOfSize:11.0f];
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
    NSString * urlString = [NSString stringWithFormat:lqchaoBiaoList,_departId,startTimeStamp,endTimeStamp,_shebeibianhao,_chaobiaolx,_cllx,_pageNo,_maxPageItems];
//    NSDictionary * dict = @{@"departType":self.conditonDict[@"departType"],
//                            @"biaoshiid":self.conditonDict[@"biaoshiid"],
//                            @"endTime":endTimeStamp,
//                            @"startTime":startTimeStamp,
//                            @"shebeibianhao":self.shebeibianhao,
//                            @"chaobiaolx":self.chaobiaolx,
//                            @"cllx":self.cllx,
//                            @"pageNo":self.pageNo,
//                            @"maxPageItems":self.maxPageItems,
//                            };
    
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    LLQ_CBCZ_Model * model =  [[LLQ_CBCZ_Model alloc] init];
                    model.dataDict = dict;
                    model.fieldDict = json[@"field"];
                    model.lqisshow = json[@"lqisshow"];
                    
                    model.shenhe = dict[@"shenhe"];
                    model.chuli = dict[@"chuli"];
                    model.zxdwshenhe = dict[@"zxdwshenhe"];
                    model.sbbh = dict[@"sbbh"];
                    model.bianhao = dict[@"bianhao"];
                    
                    [datas addObject:model];
                }
            }
        }
        
        int i = [weakSelf.tableViewSigner intValue];
        
        
        switch (i) {
            case 1:
                //1.
                if ([weakSelf.pageNo1 intValue] == 1) {
                    weakSelf.datas1 = datas;
                }else{
                    [weakSelf.datas1 addObjectsFromArray:datas];
                }
                //2.
                [weakSelf.tableView1 reloadData];
                [weakSelf.tableView1.mj_header endRefreshing];
                [weakSelf.tableView1.mj_footer endRefreshing];
                //3.
                if (weakSelf.datas1.count < ([weakSelf.pageNo1 intValue]* [weakSelf.maxPageItems intValue])) {
                    [weakSelf.tableView1.mj_footer endRefreshingWithNoMoreData];
                }
                break;
            case 2:
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
            case 3:
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
    if (tableView == self.tableView1) {
        return self.datas1.count;
    }
    if (tableView == self.tableView2) {
        return self.datas2.count;
    }
    if (tableView == self.tableView3) {
        return self.datas3.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView1) {
        LLQ_CBCZ_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Cell" forIndexPath:indexPath];
        cell.currentIndexPath = indexPath;
        LLQ_CBCZ_Model * model = self.datas1[indexPath.row];
        cell.model = model;
//        [cell setModel:model indexPath:indexPath];
        return cell;
    }
    if (tableView == self.tableView2) {
        LLQ_CBCZ_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Cell" forIndexPath:indexPath];
        cell.currentIndexPath = indexPath;
        LLQ_CBCZ_Model * model = self.datas2[indexPath.row];
        cell.model = model;
//        [cell setModel:model indexPath:indexPath];
        return cell;
    }
    if (tableView == self.tableView3) {
        LLQ_CBCZ_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Cell" forIndexPath:indexPath];
        cell.currentIndexPath = indexPath;
        LLQ_CBCZ_Model * model = self.datas3[indexPath.row];
        cell.model = model;
//        [cell setModel:model indexPath:indexPath];
        return cell;
    }
    return nil;
}

-(CGFloat)rowHeightWithModel:(LLQ_CBCZ_Model*)model{
    int index = 0;
    for (NSString * key in model.dataDict.allKeys) {
        NSString *results = [model.dataDict objectForKey:key];
        if (![results  isKindOfClass:[NSNull class]]) {//判断不为空
            if ([key hasPrefix:@"bhzName"] ||
                [key hasPrefix:@"clTime"] ||
                [key hasPrefix:@"clwd"] ||
                [key hasPrefix:@"lqwd"] ||
                [key hasPrefix:@"glwd"] ||
                [key hasPrefix:@"sjtjj"] ||
                [key hasPrefix:@"sjysb"] ||
                [key hasPrefix:@"sjlq"] ||
                (([key hasPrefix:@"sjf"] || [key hasPrefix:@"sjg"]) && [[model.dataDict objectForKey:key] intValue]>=1)) {
                index++;
            }
        }
    }
    return index*15.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView1) {
        return [self rowHeightWithModel:self.datas1[indexPath.row]];
    }
    if (tableView == self.tableView2) {
        return [self rowHeightWithModel:self.datas2[indexPath.row]];
    }
    if (tableView == self.tableView3) {
        return [self rowHeightWithModel:self.datas3[indexPath.row]];
    }
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLQ_CBCZ_Model * model;
    if (tableView == self.tableView1) {
        model = self.datas1[indexPath.row];
    }
    if (tableView == self.tableView2) {
        model = self.datas2[indexPath.row];
    }
    if (tableView == self.tableView3) {
        model = self.datas3[indexPath.row];
    }
    NSDictionary * dic=@{@"bianhao":model.bianhao?:@"",
//                         @"shebeibianhao":model.sbbh,
                         @"chuli":model.chuli?:@"",
                         @"shenhe":model.shenhe?:@"",
                         @"zxdwshenhe":model.zxdwshenhe?:@""
                         };
    
    
    [self performSegueWithIdentifier:@"LLQ_CBCZ_DetailController" sender:dic];
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
    Exp6View * e = [[Exp6View alloc] init];
    e.frame = CGRectMake(0, 64+36, Screen_w, 294);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2, int buttonTag){
        NSLog(@"ExpButtonType~~~ %d buttonTag~~~~%d",type,buttonTag);
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
            weakSelf.cllx = @"0";
            switch (buttonTag) {
                case 10:
                    weakSelf.cllx = @"0";
                    break;
                case 20:
                    weakSelf.cllx = @"1";
                    break;
                case 30:
                case 40:
                    weakSelf.cllx = @"2";
                    break;
                case 50:
                    weakSelf.cllx = @"3";
                    break;
                case 60:
                    weakSelf.cllx = @"4";
                    break;
            }
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {
            UIButton * btn = (UIButton*)obj1;
            LQ_SB_Controller *controller = [[LQ_SB_Controller alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            controller.title = @"选择设备";
            controller.conditonDict = @{@"userGroupId":_departId,
                                        @"bhjtype":@"2",
                                        };
            controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                self.shebeibianhao = gprsbianhao;
            };
        }
    };
    [self.view addSubview:e];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
//    if ([vc isKindOfClass:[LQ_SB_Controller class]]) {
//        LQ_SB_Controller * controller = vc;
//        __weak UIButton * weakBtn = sender;
//        __weak __typeof(self)  weakSelf = self;
//        controller.title = @"选择设备";
//        
//        controller.conditonDict = @{@"departType":self.conditonDict[@"departType"],
//                                    @"biaoshiid":self.conditonDict[@"biaoshiid"],
//                                    @"machineType":@"2",
//                                    };
//        controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
//            [weakBtn setTitle:banhezhanminchen forState:UIControlStateNormal];
//            weakSelf.shebeibianhao = gprsbianhao;
//        };
//        
//    }
    if ([vc isKindOfClass:[LLQ_CBCZ_DetailController class]]) {
        LLQ_CBCZ_DetailController * controller = vc;
        /**
         NSDictionary * dic=@{@"bianhao":model.bianhao,
         @"shebeibianhao":model.sbbh,
         @"chuli":model.chuli,
         @"shenhe":model.shenhe};
         */
        //        NSDictionary * dict = (NSDictionary*)sender;
        controller.chuli = [sender objectForKey:@"chuli"];
        controller.shenpi = [sender objectForKey:@"shenhe"];
        controller.zxdwshenhe = [sender objectForKey:@"zxdwshenhe"];
        controller.bianhao = [sender objectForKey:@"bianhao"];
//        controller.shebeibianhao = [sender objectForKey:@"shebeibianhao"];
        controller.title = @"详情";
    }

}
-(void)dealloc{
    FuncLog;
    [[UserDefaultsSetting shareSetting] removeObserver:self forKeyPath:@"randomSeed"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [[UserDefaultsSetting shareSetting] addObserver:self forKeyPath:@"randomSeed" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self loadData];
}

@end
