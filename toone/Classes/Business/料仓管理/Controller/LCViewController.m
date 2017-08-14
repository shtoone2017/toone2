//
//  LCViewController.m
//  toone
//
//  Created by 上海同望 on 2017/8/4.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LCViewController.h"
#import "LCListModel.h"
#import "LCListCell.h"
#import "LCDetailViewController.h"

@interface LCViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tbView;
    NSInteger _currentPage;
}
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;

@end
@implementation LCViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)loadView
{
    [super loadView];
    self.screenViewTitleArr = @[@"所属机构:",@"材料名称:"];
    self.screenViewType = ScreenViewTypeLC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _containerView.hidden = YES;
    [self loadUI];
    _currentPage = 1;
    [self refreshDataWithParaDic:[self getParaDic]];
    WS(weakSelf);
    self.scView.paraBlock = ^(NSDictionary *paraDic)
    {
        NSMutableDictionary *tempDic = [weakSelf getParaDic];
        [tempDic setValuesForKeysWithDictionary:paraDic];
        [weakSelf refreshDataWithParaDic:tempDic];
    };
}


- (void)loadUI
{
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    //创建列表
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Screen_w,Screen_h) style:UITableViewStylePlain];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tbView.estimatedRowHeight = 30.0;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    [self.view sendSubviewToBack:_tbView];
}

- (NSMutableDictionary *)getParaDic
{
    NSDictionary *dic = @{@"maxPageItems":[NSString stringWithFormat:@"%d",kPageSize],@"pageNo":[NSString stringWithFormat:@"%ld",(long)_currentPage]};
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [paraDic setObject:[UserDefaultsSetting shareSetting].departId forKey:LC_PARA_ZZJG];
    
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
    urlString = [NSString stringWithFormat:@"%@AppKuCunInterfaceController.do?AppkuCunList",baseUrl];
    
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
            NSArray *tempArr = [LCListModel arrayOfModelsFromDictionaries:arr];
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
    LCListModel *model = [self.dataArr objectAtIndex:indexPath.row];
    NSString *cellId = [NSString stringWithFormat:@"cellID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    LCListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCListCell" owner:self options:nil] objectAtIndex:0];
        cell.LC_LIST_SSJG_Label.text = model.departname;
        cell.LC_LIST_CLName_Label.text = model.cailiaoname;
        cell.LC_LIST_KC_Label.text = [NSString stringWithFormat:@"%.2f",[model.result floatValue]];
        cell.LC_LIST_CSL_Label.text = model.chushiliang;
        cell.LC_LIST_XZL_Label.text = model.xiuzhengliang;
        cell.LC_LIST_JJZ_Label.text = model.jingjiezhi;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCListModel *model = _dataArr[indexPath.row];
    LCDetailViewController *vc = [[LCDetailViewController alloc] init];
    vc.identifier = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
