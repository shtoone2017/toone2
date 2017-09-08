//
//  SYS_PHBViewController.m
//  toone
//
//  Created by 景晓峰 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SYS_PHBViewController.h"
#import "SYS_PHBListModel.h"
#import "PHBListCell.h"
#import "SJ_PHB_ViewController.h"
#import "ScreenView.h"

@interface SYS_PHBViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tbView;
    NSInteger _currentPage;
    ScreenView *scView;
    BOOL isShowScreenView;
}
@property (nonatomic,strong) NSMutableArray *dataArr;

@end
@implementation SYS_PHBViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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
    _currentPage = 1;
    [self refreshDataWithParaDic:[self getParaDic]];
    
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
    NSArray *titleArr = @[@"组织机构:",@"设计强度:",@"开始时间:",@"结束时间:"];
    scView = [[ScreenView alloc] initWithFrame: CGRectMake(Screen_w, 90, Screen_w, Screen_h) titleArr:titleArr type:ScreenViewTypePHB];
    scView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    scView.block = ^(BOOL isShow) {
        isShowScreenView = isShow;
    };
    
    WS(weakSelf);
    scView.paraBlock = ^(NSDictionary *paraDic) {
        NSMutableDictionary *tempDic = [weakSelf getParaDic];
        [tempDic setValuesForKeysWithDictionary:paraDic];
        [tempDic setObject:@"1463557140" forKey:PHB_PARA_TIME1];
        [tempDic setObject:@"1503041940" forKey:PHB_PARA_TIME2];
        [weakSelf refreshDataWithParaDic:tempDic];
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

- (NSMutableDictionary *)getParaDic
{
    NSDictionary *dic = @{@"maxPageItems":[NSString stringWithFormat:@"%d",kPageSize],@"pageNo":[NSString stringWithFormat:@"%ld",(long)_currentPage]};
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [paraDic setObject:[UserDefaultsSetting shareSetting].departId forKey:PHB_PARA_ZZJG];
    [paraDic setObject:[TimeTools timeStampWithTimeString:self.startTime] forKey:PHB_PARA_TIME1];
    [paraDic setObject:[TimeTools timeStampWithTimeString:self.endTime] forKey:PHB_PARA_TIME2];
    
    return paraDic;
}

- (void)refreshDataWithParaDic:(NSDictionary *)paraDic
{
    __weak typeof(self) weakSelf = self;
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_tbView.mj_footer resetNoMoreData];
        [weakSelf loadingDataWithTag:1 paraDic:paraDic];
    }];
    [_tbView.mj_header beginRefreshing];
    
    _tbView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadingDataWithTag:0 paraDic:paraDic];
    }];
}


#pragma mark - Data request

- (void)loadingDataWithTag:(NSInteger)tag paraDic:(NSDictionary *)paraDic
{
    __weak typeof(self) weakSelf = self;
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@appWZSys.do?AppsjphbList",baseUrl];
    
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString parmas:paraDic completeBlock:^(id result) {
        [_tbView.mj_header endRefreshing];
        [_tbView.mj_footer endRefreshing];
        if (result && result != nil)
        {
            if (tag == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = (NSDictionary *)result;
            NSArray *arr =dict[@"data"];
            NSArray *tempArr = [SYS_PHBListModel arrayOfModelsFromDictionaries:arr];
            [weakSelf.dataArr addObjectsFromArray:tempArr];
            if ([tempArr count] == kPageSize)
            {
                _currentPage ++ ;//有下一页  show 加载按钮
            }else
            {
                //没有下一页  hide 加载按钮
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
    SYS_PHBListModel *model = [self.dataArr objectAtIndex:indexPath.row];
    NSString *cellId = [NSString stringWithFormat:@"cellID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    PHBListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PHBListCell" owner:self options:nil] objectAtIndex:0];
        cell.PHB_ZZJG_Label.text = model.departname;
        cell.PHB_BH_Label.text = model.llphbno;
        cell.PHB_SJB_Label.text = model.shuijiaobi;
        cell.PHB_SJQD_Label.text = model.sjqd;
        cell.PHB_TIME_Label.text = model.createdatetime;
        cell.PHB_STATE_Label.text = model.zhuangtai;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYS_PHBListModel *model = _dataArr[indexPath.row];
    SJ_PHB_ViewController *vc = [[SJ_PHB_ViewController alloc] init];
    vc.detailNum = model.llphbno;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
