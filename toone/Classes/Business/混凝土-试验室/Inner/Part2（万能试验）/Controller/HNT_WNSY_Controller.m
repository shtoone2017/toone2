






//
//  HNT_WNSY_Controller.m
//  toone
//
//  Created by 十国 on 16/12/2.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_WNSY_Controller.h"
#import "HNT_WNSY_Cell.h"
#import "HNT_WNSY_Model.h"
#import "HNT_SYS_typeAndSB_Controller.h"
#import "HNT_WNSY_DetailController.h"
@interface HNT_WNSY_Controller ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContainerWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *title_sc;//标题scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *text_sc;//正文scrollView
@property (weak, nonatomic) IBOutlet UIView *redLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLine_x;
- (IBAction)titleButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button1;//不合格
@property (weak, nonatomic) IBOutlet UIButton *button2;//合格
@property (weak, nonatomic) IBOutlet UIButton *button3;//未处置
@property (weak, nonatomic) IBOutlet UIButton *button4;//已处置


@property (weak, nonatomic) IBOutlet UITableView *tableView1;//不合格
@property (weak, nonatomic) IBOutlet UITableView *tableView2;//合格
@property (weak, nonatomic) IBOutlet UITableView *tableView3;//未处置
@property (weak, nonatomic) IBOutlet UITableView *tableView4;//已处置
//******************************************************************
@property (nonatomic,strong) NSMutableArray * datas1;
@property (nonatomic,strong) NSMutableArray * datas2;
@property (nonatomic,strong) NSMutableArray * datas3;
@property (nonatomic,strong) NSMutableArray * datas4;

//参数
@property (nonatomic,copy) NSString * isQualified;//0.不合格 1.合格
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString * maxPageItems;//一页最多显示条数
@property (nonatomic,copy) NSString * shebeibianhao;//设备编号
@property (nonatomic,copy) NSString * isReal;//0全部 1未处理 2已处理 可以为空
@property (nonatomic,copy) NSString * testId;//试验id
@property (nonatomic,copy) NSString * tableViewSigner;//列表标记
//不同页面记录的页码
@property (nonatomic,copy) NSString * pageNo1;
@property (nonatomic,copy) NSString * pageNo2;
@property (nonatomic,copy) NSString * pageNo3;
@property (nonatomic,copy) NSString * pageNo4;
@end

@implementation HNT_WNSY_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    {//设置初始请求条件
        self.pageNo1 = @"1";
        self.pageNo2 = @"1";
        self.pageNo3 = @"1";
        self.pageNo4 = @"1";

        self.isQualified  = @"0";
        self.pageNo = _pageNo1;
        self.maxPageItems = @"30";
        self.isReal = @"";//全部
        self.shebeibianhao = @"";
        self.testId = @"";
        self.tableViewSigner = @"1";
        
    }
    
    [self loadUI];
    [self loadData];
}

-(void)loadUI{
    self.ContainerWidth.constant = Screen_w*4;
    self.title_sc.backgroundColor = [UIColor snowColor];
    self.searchButton.backgroundColor = [UIColor snowColor];//black75PercentColor

    
    [self registerTableView:self.tableView1];
    [self registerTableView:self.tableView2];
    [self registerTableView:self.tableView3];
    [self registerTableView:self.tableView4];

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
            case 4:
                weakSelf.pageNo4 = @"1";
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
                NSLog(@"_pageNo=%@~~~_pageNo2=%@",weakSelf.pageNo,weakSelf.pageNo2);
                break;
            case 3:
                weakSelf.pageNo3 = FormatInt([weakSelf.pageNo3 intValue]+1);
                weakSelf.pageNo = weakSelf.pageNo3;
                break;
            case 4:
                weakSelf.pageNo4 = FormatInt([weakSelf.pageNo4 intValue]+1);
                weakSelf.pageNo = weakSelf.pageNo4;
                break;
            default:
                break;
        }
        
        [weakSelf loadData];
    }];
    
    
    tableView.rowHeight = 150;
    [tableView registerNib:[UINib nibWithNibName:@"HNT_WNSY_Cell" bundle:nil] forCellReuseIdentifier:@"HNT_WNSY_Cell"];
}
#pragma mark - 顶部title的点击事件
- (IBAction)titleButtonClick:(UIButton *)sender {
    //视图切换
    [self addTitleButtonAnimaiton:sender];
    [self addTextScAnimaiton:sender];
}
-(void)conditionsInt:(int)count{
    switch (count) {
        case 1://不合格
            self.pageNo = self.pageNo1;
            self.isQualified = @"0";
            self.isReal =@"";
            if(self.datas1==nil) [self loadData];
            break;
        case 2://合格
            self.pageNo = self.pageNo2;
            self.isQualified = @"1";
            self.isReal =@"";
            if(self.datas2==nil) [self loadData];
            break;
        case 3://未处理
            self.pageNo = self.pageNo3;
            self.isQualified = @"0";
            self.isReal =@"1";
            if(self.datas3==nil) [self loadData];
            break;
        case 4://已处理
            self.pageNo = self.pageNo4;
            self.isQualified = @"";
            self.isReal =@"2";
            if(self.datas4==nil) [self loadData];
            break;
        default:
            break;
    }
}
-(void)addTitleButtonAnimaiton:(UIButton*)sender{
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button1 .titleLabel.font = [UIFont systemFontOfSize:11.0f];
    self.button2 .titleLabel.font = [UIFont systemFontOfSize:11.0f];
    self.button3 .titleLabel.font = [UIFont systemFontOfSize:11.0f];
    self.button4 .titleLabel.font = [UIFont systemFontOfSize:11.0f];
    
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
    
    NSString * userGroupId = self.userGroupId;
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:gangjin_9,userGroupId,_isQualified,startTimeStamp,endTimeStamp,_pageNo,_shebeibianhao,_isReal,_maxPageItems,_testId];
//        NSLog(@"urlString = %@",urlString);
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary * dict in json[@"data"]) {
                    HNT_WNSY_Model * model = [HNT_WNSY_Model modelWithDict:dict];
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
            case 4:
                if ([weakSelf.pageNo4 intValue] == 1) {
                    weakSelf.datas4 = datas;
                }else{
                    [weakSelf.datas4 addObjectsFromArray:datas];
                }
                [weakSelf.tableView4 reloadData];
                [weakSelf.tableView4.mj_header endRefreshing];
                [weakSelf.tableView4.mj_footer endRefreshing];
                if (weakSelf.datas4.count < ([weakSelf.pageNo4 intValue]* [weakSelf.maxPageItems intValue])) {
                    [weakSelf.tableView4.mj_footer endRefreshingWithNoMoreData];
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
    if (tableView == self.tableView4) {
        return self.datas4.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView1) {
        HNT_WNSY_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_WNSY_Cell" forIndexPath:indexPath];
        HNT_WNSY_Model * model = self.datas1[indexPath.row];
        cell.model = model;
        return cell;
    }
    if (tableView == self.tableView2) {
        HNT_WNSY_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_WNSY_Cell" forIndexPath:indexPath];
        HNT_WNSY_Model * model = self.datas2[indexPath.row];
        cell.model = model;
        return cell;
    }
    if (tableView == self.tableView3) {
        HNT_WNSY_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_WNSY_Cell" forIndexPath:indexPath];
        HNT_WNSY_Model * model = self.datas3[indexPath.row];
        cell.model = model;
        return cell;
    }
    if (tableView == self.tableView4) {
        HNT_WNSY_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_WNSY_Cell" forIndexPath:indexPath];
        HNT_WNSY_Model * model = self.datas4[indexPath.row];
        cell.model = model;
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HNT_WNSY_Model * model;
    if (tableView == self.tableView1) {
        model = self.datas1[indexPath.row];
    }
    if (tableView == self.tableView2) {
        model = self.datas2[indexPath.row];
    }
    if (tableView == self.tableView3) {
        model = self.datas3[indexPath.row];
    }
    if (tableView == self.tableView4) {
        model = self.datas4[indexPath.row];
    }
    [self performSegueWithIdentifier:@"HNT_WNSY_DetailController" sender:@{@"SYJID":model.SYJID,@"tableViewSigner":self.tableViewSigner}];
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
    Exp2View * e = [[Exp2View alloc] init];
    e.frame = CGRectMake(0, 64+36, Screen_w, 240);
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
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf performSegueWithIdentifier:@"HNT_WNSY_Controller" sender:btn];
        }
        if (type == ExpButtonTypeChoiceTypeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf performSegueWithIdentifier:@"HNT_WNSY_Controller" sender:btn];
        }
    };
    [self.view addSubview:e];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[HNT_SYS_typeAndSB_Controller class]]) {
        HNT_SYS_typeAndSB_Controller * controller = vc;
        __weak UIButton * weakBtn = sender;
        __weak __typeof(self)  weakSelf = self;
        switch (weakBtn.tag) {
            case 3:{
                controller.title = @"选择设备";
                controller.typeAndSB  = HNT_SYS_WNJ_SB;
                controller.typeSBBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
                    [weakBtn setTitle:banhezhanminchen forState:UIControlStateNormal];
                    weakSelf.shebeibianhao = gprsbianhao;
                };
                break;
            }
            case 4:{
                controller.title = @"选择试验类型";
                controller.typeAndSB  = HNT_SYS_WNJ_SY;
                controller.typeSBBlock = ^(NSString * testName,NSString*testId){
                    [weakBtn setTitle:testName forState:UIControlStateNormal];
                    weakSelf.testId = testId;
                };
                break;
            }
            default:
                break;
        }
    }
    
    if ([vc isKindOfClass:[HNT_WNSY_DetailController class]]) {
        HNT_WNSY_DetailController * controller = vc;
        controller.SYJID = ((NSDictionary*)sender)[@"SYJID"];
        controller.tableViewSigner = ((NSDictionary*)sender)[@"tableViewSigner"];
        controller.title = @"详情";
    }
}
-(void)dealloc{
    FuncLog;
}

@end
