//
//  SYS_TZDViewController.m
//  toone
//
//  Created by 景晓峰 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SYS_TZDViewController.h"
#import "ScreenView.h"
#import "TZD_ListCell.h"
#import "TZD_ListModel.h"
#import "SJ_PHB_ViewController.h"
#import "TZD_DetailViewController.h"
#import "GCB_RWD_DetailController.h"
#import "SYS_TZD_DetailViewController.h"


@interface SYS_TZDViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tbView;
    NSInteger _currentPage;
    ScreenView *scView;
    BOOL isShowScreenView;
}
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableDictionary *paraDic;

@end
@implementation SYS_TZDViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (scView)
    {
        [scView.tbView reloadData];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
    [self tableViewAddMJRefresh];
}


- (void)loadUI
{
    UIView *navigationView = [UIView new];
    navigationView.frame = CGRectMake(0, 60, Screen_w, 30);
    navigationView.backgroundColor = BLUECOLOR;
    [self.view addSubview:navigationView];
    
    UIButton * navigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    navigationBtn.backgroundColor = [UIColor blackColor];
    navigationBtn.frame = CGRectMake(Screen_w-80, 0, 80, 30);
    [navigationBtn setImage:[UIImage imageNamed:@"ic_format_list_numbered_white_24dp"] forState:UIControlStateNormal];
    [navigationBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 45, 5, 15)];
    [navigationBtn addTarget:self action:@selector(controlScreenView) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:navigationBtn];
    
    //创建列表
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0,90,Screen_w,Screen_h-90) style:UITableViewStylePlain];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tbView.estimatedRowHeight = 30.0;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    [self.view sendSubviewToBack:_tbView];
    [self createScreenView];
}

- (void)createScreenView
{
    NSArray *titleArr = @[@"组织机构:",@"开始时间:",@"结束时间:"];
    scView = [[ScreenView alloc] initWithFrame: CGRectMake(Screen_w, 90, Screen_w, Screen_h) titleArr:titleArr type:ScreenViewTypeTZD];
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
- (void)controlScreenView
{
    if (isShowScreenView == YES)
    {
        [self hidenScreenView];
    }
    else
    {
        [self showScreenView];
    }
}

- (void)showScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(0, 90, Screen_w, Screen_h);
    } completion:nil];
    isShowScreenView = !isShowScreenView;
    
}

- (void)hidenScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        scView.frame = CGRectMake(Screen_w, 90, Screen_w, Screen_h);
    } completion:nil];
    isShowScreenView = !isShowScreenView;
    
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
    NSArray *keys = @[TZD_PARA_TIME1,TZD_PARA_TIME2,TZD_PARA_ZZJG];
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
    __weak typeof(self) weakSelf = self;
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@appWZSys.do?AppPeibiTongzhidanCX",baseUrl];
    NSMutableDictionary *tempDic = [self checkParaDic];
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString parmas:tempDic completeBlock:^(id result) {
        [_tbView.mj_header endRefreshing];
        [_tbView.mj_footer endRefreshing];
        if (result && result != nil)
        {
            if (tag == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = (NSDictionary *)result;
            NSArray *arr =dict[@"data"];
            NSArray *tempArr = [TZD_ListModel arrayOfModelsFromDictionaries:arr];
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
    //WS(weakSelf);
    static NSString *cellID = @"TZD_ListCell1";
    TZD_ListModel *model = [self.dataArr objectAtIndex:indexPath.row];
    TZD_ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TZD_ListCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.TZD_List_ZZJG.text = model.departname;
    [cell.TZD_List_TZD_NUM setTitle:model.sgphbNo forState:UIControlStateNormal];
    [cell.TZD_List_RWD_NUM setTitle:model.renwuNo forState:UIControlStateNormal];
    [cell.TZD_List_SJ_NUM setTitle:model.llphbNo forState:UIControlStateNormal];
    cell.TZD_List_SY_Date.text = model.createDateTime;
    cell.TZD_List_JZBW.text = model.jzbw;
//    cell.block = ^(NSInteger tag)
//    {
//        if (tag == 100)
//        {
//            //通知单
//            TZD_DetailViewController *vc = [[TZD_DetailViewController alloc] init];
//            vc.detailNum = model.sgphbNo;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }
//        else if (tag == 101)
//        {
//            //设计
//            SJ_PHB_ViewController *vc = [[SJ_PHB_ViewController alloc] init];
//            vc.detailNum = model.llphbNo;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }
//        else
//        {
////            //任务
//            GCB_RWD_DetailController *vc = [[GCB_RWD_DetailController alloc] init];
//            vc.detailId = model.renwuNo;
//            vc.biaoshi = @"1";
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TZD_ListModel *model = _dataArr[indexPath.row];
    SYS_TZD_DetailViewController *vc = [[SYS_TZD_DetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
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
