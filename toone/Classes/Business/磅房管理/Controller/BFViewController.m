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
#import "BFListModel.h"
#import "BFListCell.h"
#import "BFDetailViewController.h"
#import "HNT_SYS_InnerController.h"


@interface BFViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ScreenView *scView;
    BOOL isShowScreenView;
    UITableView *_tbView;
    NSInteger _currentPage;
    NSInteger _currentSegIndex;
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableDictionary *paraDic;

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableDictionary *)paraDic
{
    if (!_paraDic)
    {
        _paraDic = [NSMutableDictionary dictionary];
    }
    return _paraDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self tableViewAddMJRefresh];
    
    
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
    
    [self createTableView];
    
    [self createScreenView];
}

- (void)createTableView
{
    //创建列表
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Screen_w,Screen_h-55) style:UITableViewStylePlain];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tbView.estimatedRowHeight = 30.0;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    [self.view bringSubviewToFront:scView];
}

- (void)createScreenView
{
    NSArray *titleArr = @[@"所属机构:",@"磅房名称:",@"材料名称:",@"进场时间:",@"出场时间:"];
    scView = [[ScreenView alloc] initWithFrame: CGRectMake(Screen_w, 60, Screen_w, Screen_h) titleArr:titleArr type:ScreenViewTypeBF_JC];
    scView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    scView.block = ^(BOOL isShow) {
        isShowScreenView = isShow;
    };
    
    WS(weakSelf);
    scView.paraBlock = ^(NSDictionary *dic) {
        weakSelf.paraDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [weakSelf tableViewAddMJRefresh];
    };
    [self.view addSubview:scView];
    [self.view bringSubviewToFront:scView];
}

- (BOOL)isExistKey:(NSString *)key inDic:(NSDictionary *)dic
{
    BOOL isExist = NO;
    for (NSString *oneKey in [dic allKeys])
    {
        if ([oneKey isEqualToString:key])
        {
            return YES;
        }
    }
    return isExist;
}

- (void)paraDicAddKeys:(NSString *)key AndValues:(NSString *)value
{
    if ([self isExistKey:key inDic:self.paraDic] == YES)
    {
        NSString *valueStr =self.paraDic[key];
        if (valueStr && valueStr.length > 0)
        {
        }
        else
        {
            [self.paraDic setObject:value forKey:key];
        }
    }
    else
    {
        [self.paraDic setObject:value forKey:key];
    }

}

/**
 检测当前必传参数是否齐全
 */
- (NSMutableDictionary *)checkParaDic
{
    NSArray *keys = @[jinchangshijian1,chuchangshijian1,orgcode];
    for (int i = 0; i<keys.count; i++)
    {
        if (i == 0)
        {
            [self paraDicAddKeys:keys[i] AndValues:[TimeTools timeStampWithTimeString:self.startTime]];
        }
        else if (i==1)
        {
            [self paraDicAddKeys:keys[i] AndValues:[TimeTools timeStampWithTimeString:self.endTime]];
        }
        else
        {
            [self paraDicAddKeys:keys[i] AndValues:[UserDefaultsSetting shareSetting].departId];
        }
    }
    
    [self.paraDic setObject:[NSString stringWithFormat:@"%d",kPageSize] forKey:@"maxPageItems"];
    [self.paraDic setObject:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"pageNo"];
    return self.paraDic;
}

- (void)tableViewAddMJRefresh
{
    WS(weakSelf);
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        [weakSelf requestDataWithUpOrDown:1];
    }];
    [_tbView.mj_header beginRefreshing];

    _tbView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataWithUpOrDown:0];
    }];
}


/**
 请求数据

 @param tag 下拉刷新:1  上拉加载:0
 */
- (void)requestDataWithUpOrDown:(NSInteger)tag
{
    WS(weakSelf);
    NSString *urlString;
    if (_currentSegIndex == 0)
    {
        urlString = [NSString stringWithFormat:@"%@AppGB.do?JinChangGB",baseUrl];
    }
    else
    {
        urlString = [NSString stringWithFormat:@"%@AppGB.do?ChuChangGB",baseUrl];
    }
    
    NSMutableDictionary *tempDic = [self checkParaDic];
    
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString parmas:tempDic completeBlock:^(id result) {
        [_tbView.mj_header endRefreshing];
        [_tbView.mj_footer endRefreshing];
        if (result && result != nil)
        {
            if (tag == 1)
            {
                [weakSelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = (NSDictionary *)result;
            NSArray *arr =dict[@"data"];
            NSArray *tempArr = [BFListModel arrayOfModelsFromDictionaries:arr];
            [weakSelf.dataArr addObjectsFromArray:tempArr];
            if ([tempArr count] == kPageSize)
            {
                _currentPage ++ ;
                //有下一页 显示加载按钮
                [_tbView.mj_footer resetNoMoreData];
            }else
            {
                //没有下一页   隐藏加载按钮
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }
        
    }];

}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFListModel *model = [self.dataArr objectAtIndex:indexPath.row];
    NSString *cellId = [NSString stringWithFormat:@"cellID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    BFListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        if (_currentSegIndex == 0)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BFListCell" owner:self options:nil] firstObject];
            cell.JC_BF_Name.text = model.banhezhanminchen;
            cell.JC_SJ.text = model.jinchangshijian;
            cell.JC_CL_Name.text = model.cailiaoname;
            cell.JC_GYS_Name.text = model.gongyingshangname;
            cell.JC_JZ.text = model.jingzhong;
        }
        else
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BFListCell" owner:self options:nil] objectAtIndex:1];
            cell.CC_BF_Name.text = model.banhezhanminchen;
            cell.CC_SJ.text = model.jinchangshijian;
            cell.CC_CL_Name.text = model.cailiaoname;
            cell.CC_GYS_Name.text = model.gongyingshangname;
            cell.CC_TYPE.text = model.remark;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BFListModel *model = self.dataArr[indexPath.row];
    BFDetailViewController *vc = [[BFDetailViewController alloc] init];
    vc.identifier = [NSString stringWithFormat:@"%@",model.id];
    if (_currentSegIndex == 0)
    {
        vc.urlStr = [NSString stringWithFormat:@"%@AppGB.do?JinChangGBDetail",baseUrl];
    }
    else
    {
        vc.urlStr = [NSString stringWithFormat:@"%@AppGB.do?ChuChangGBDetail",baseUrl];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)segmentControlAction:(UISegmentedControl *)seg
{
    _currentPage = 1;

    if(_tbView)
    {
        [_tbView removeFromSuperview];
        _tbView = nil;
    }
        
    [self createTableView];
    _currentSegIndex = [seg selectedSegmentIndex];
    [self tableViewAddMJRefresh];
    _tbView.frame = CGRectMake(0,60,Screen_w,Screen_h-55);
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
            break;
        case 3:
            [super pan];
            break;
            
        default:
            break;
    }
    
}


- (void)showScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(0, 60, Screen_w, Screen_h);
    } completion:nil];
    isShowScreenView = !isShowScreenView;

}

- (void)hidenScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(Screen_w, 60, Screen_w, Screen_h);
    } completion:nil];
    isShowScreenView = !isShowScreenView;

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
