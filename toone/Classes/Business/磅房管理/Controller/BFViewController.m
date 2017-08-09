//
//  BFViewController.m
//  toone
//
//  Created by 上海同望 on 2017/8/4.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "BFViewController.h"
#import "MySegmentedControl.h"
#import "ScreenView.h"
#import "HNT_BHZ_SB_Controller.h"



@interface BFViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ScreenView *scView;
    BOOL isShowScreenView;
    UITableView *_tbView;
    NSInteger _currentPage;
}
@end

@implementation BFViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (scView)
    {
        [scView.tbView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    
    
}


-(void)loadUI{
    //    self.containerView.backgroundColor = BLUECOLOR;
    //顶部UISegmentedControl
    NSArray *titles = @[@"进场过磅",@"出场过磅"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titles];
    seg.frame = CGRectMake(0,0,150,20);
    seg.selectedSegmentIndex = 0;
    seg.tintColor = [UIColor whiteColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:12],
                         NSFontAttributeName,nil];
    
    [seg setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:12],
                          NSFontAttributeName,nil];
    
    [seg setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [seg addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    //创建列表
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Screen_w,Screen_h) style:UITableViewStylePlain];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbView.rowHeight = 70.0;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    
    [self createScreenView];
}


- (void)configRefreshControl
{
    __weak typeof(self) weakSelf = self;
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        [_tbView.mj_footer resetNoMoreData];
        [weakSelf loadingDataWithTag:1 showLoading:YES];
    }];
    [_tbView.mj_header beginRefreshing];
    
    _tbView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadingDataWithTag:0 showLoading:YES];
    }];
}


#pragma mark - Data request

- (void)loadingDataWithTag:(NSInteger)tag showLoading:(BOOL)isShowLoading
{
    __weak typeof(self) weakSelf = self;
    NSString *urlString = [NSString stringWithFormat:@"%@AppGB.do?JinChangGB",baseUrl];
//    [NetworkTool sharedNetworkTool]getObjectWithURLString:urlString parmas:nil completeBlock:^(id result) {
//        
//    };
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        
        NSDictionary *dict = (NSDictionary *)result;
        
        NSArray *dictArr = dict[@"data"];
        
//        for (int i = 0; i < dictArr.count; i++) {
//            NSDictionary *modelDic = dictArr[i];
//            weakSelf.node = [[Node alloc] init];
//            if ([[modelDic valueForKey:@"parentnode"] isKindOfClass:[NSNull class]])
//            {
//                weakSelf.node.parentId = @"";
//            }
//            else{
//                weakSelf.node.parentId = (NSString *)[modelDic valueForKey:@"parentnode"] ? :@"";
//            }
//            
//            weakSelf.node.name = (NSString *)[modelDic valueForKey:@"cailiaoname"];
//            weakSelf.node.nodeId = [modelDic valueForKey:@"cailiaono"];
//            [weakSelf.channs addObject:weakSelf.node];
//            
//        }
//        [weakSelf setUpUI];
    }];

    /*
     if (result && result != nil)
     {
     if (tag == 1) {
     [self.tableArray removeAllObjects];
     }
     NSArray *arr = [NewsListModel arrayOfModelsFromDictionaries:result];
     [weakSelf.tableArray addObjectsFromArray:arr];
     if ([arr count] == [kPageSize integerValue])
     {
     _currentPage ++ ;//有下一页  show 加载按钮
     }else
     {
     //没有下一页  hide 加载按钮
     [weakSelf.tableV.mj_footer endRefreshingWithNoMoreData];
     }
     [_tableV reloadData];
     */
}


#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)segmentControlAction:(UISegmentedControl *)seg
{
    NSInteger index = [seg selectedSegmentIndex];
    if (index == 0)
    {
        //进场
    }
    else
    {
        //出场
    }
}

-(void)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 2:
            if (isShowScreenView == YES)
            {
                [self hidenScreenView];
            }
            else
            {
                [self showScreenView];
            }
            isShowScreenView = !isShowScreenView;
            break;
        case 3:
            [super pan];
            break;
            
        default:
            break;
    }
    
}

- (void)createScreenView
{
    NSArray *titleArr = @[@"所属机构:",@"磅房名称:",@"材料名称:",@"进场时间(开始):",@"进场时间(结束):",@"批次:",@"车牌号:"];
    scView = [[ScreenView alloc] initWithFrame: CGRectMake(Screen_w, 60, Screen_w-30, Screen_h) titleArr:titleArr type:ScreenViewTypeBF_JC];
//    scView.backgroundColor = [UIColor cyanColor];
    scView.block = ^(BOOL isShow) {
        isShowScreenView = isShow;
    };
    
    [self.view addSubview:scView];
    [self.view bringSubviewToFront:scView];
}

- (void)showScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(30, 60, Screen_w-30, Screen_h);
    } completion:nil];
}

- (void)hidenScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(Screen_w, 60, Screen_w-30, Screen_h);
    } completion:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[HNT_BHZ_SB_Controller class]]) {
        HNT_BHZ_SB_Controller * controller = vc;
        __weak UIButton * weakBtn = sender;
//        __weak __typeof(self)  weakSelf = self;
        controller.title = @"选择设备";
//        controller.departId = self.departId;
        controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao1){
            [weakBtn setTitle:banhezhanminchen forState:UIControlStateNormal];
//            weakSelf.shebeibianhao = gprsbianhao;
        };
        
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
