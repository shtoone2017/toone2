//
//  XXCXViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/1/11.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "XXCXViewController.h"
#import "XXCXCell.h"
#import "XXCXModel.h"
#import "NetworkTool.h"
#import "SW_ZZJG_Controller.h"
static NSString *cellId = @"XXCX_Cell";
static NSString *pageNum = @"20";
@interface XXCXViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabview;

@property (nonatomic,strong) NSMutableArray *tabArr;

@property (nonatomic, copy) NSString *yPage;//页码

@property (nonatomic,copy) NSString *departId;//组织机构

@property (nonatomic,strong)  SW_ZZJG_Data * condition;


@end

@implementation XXCXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"试验信息查看";
    NSString *url = [NSString stringWithFormat:@"%@appSys/sysTempQuery",baseUrl];
    _departId = [UserDefaultsSetting shareSetting].userType;
    _yPage = @"1";
    
    [_tabview registerNib:[UINib nibWithNibName:@"XXCXCell" bundle:nil  ] forCellReuseIdentifier:cellId];
    _tabview.estimatedRowHeight = 40;
    _tabview.rowHeight = UITableViewAutomaticDimension;
    
    __weak typeof(self) weakSelf = self;
    _tabview.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        [weakSelf  reloadData:url];
    }];
    //    添加加载
    _tabview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([weakSelf.yPage boolValue]) {
            weakSelf.yPage = FormatInt([weakSelf.yPage intValue]+1);
            [weakSelf reloadData:url];
        }
    }];
    
    [_tabview.mj_header beginRefreshing];
    
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(zzjgViewCtr) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)zzjgViewCtr
{
    __weak typeof(self) weakSelf = self;
    SW_ZZJG_Controller * controller = [[SW_ZZJG_Controller alloc] init];
    controller.modelType = @"3,4";
    controller.type = @"新增";
    controller.zzjgCallBackBlock = ^(SW_ZZJG_Data * data){
        weakSelf.condition = data;
        _departId = weakSelf.condition.departType;
    };
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)reloadData:(NSString *)urlString {
    urlString = [NSString stringWithFormat:@"%@?pageNo=%@&maxPageItems=%@&departType=%@&biaoshiid=%@",urlString,_yPage,pageNum,_departId,[UserDefaultsSetting shareSetting].biaoshi];
    __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        NSMutableArray * datas = [NSMutableArray array];
        NSArray *jsonDics;
        if ([dict[@"success"] boolValue])
        {
            jsonDics = [dict objectForKey:@"data"];
            for (int i = 0; i<jsonDics.count; i++)
            {
                XXCXModel *model = [XXCXModel modelWithDict:jsonDics[i]];
                [datas addObject:model];
            }
        }
        if ([weakSelf.yPage intValue] == 1) {
            weakSelf.tabArr = datas;
        }else {
            [weakSelf.tabArr addObjectsFromArray:datas];
        }
        [self.tabview reloadData];
        [weakSelf.tabview.mj_header endRefreshing];
        [weakSelf.tabview.mj_footer endRefreshing];
        if (weakSelf.tabArr.count < [weakSelf.yPage intValue] *10) {
            [weakSelf.tabview.mj_footer endRefreshingWithNoMoreData];
        }

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXCXCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    XXCXModel *model = [_tabArr objectAtIndex:indexPath.row];
    cell.QRLab.text = model.qrcode;
    cell.uploadTimeLab.text = model.recordTime;
    cell.uploadPersonLab.text = model.operator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSMutableArray *)tabArr
{
    if (!_tabArr)
    {
        _tabArr = [NSMutableArray array];
    }
    return _tabArr;
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
