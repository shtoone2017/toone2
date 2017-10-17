//
//  JZL_JZBW_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/24.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "JZL_JZBW_Controller.h"
#import "JZL_JZBW_Model.h"
#import "JZL_JZBW_Cell.h"

@interface JZL_JZBW_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,copy) NSString * pageNo;//当前页数
@property (nonatomic,copy) NSString * maxPageItems;//一页最多显示条数
@property (nonatomic,copy) NSString * departId;//组织机构id
@property (nonatomic,strong) UITableView *tb;//

@end
@implementation JZL_JZBW_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = @"1";
    _maxPageItems = @"10";
    _departId = @"";
    self.navigationItem.title = @"选择浇筑部位";
    [self loadUI];
    [self loadData];
}

-(void)loadUI {
    UIButton * btn = [[UIButton alloc] init];
    btn.backgroundColor = BLUECOLOR;
    [btn setTitle:@"" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.view.backgroundColor = [UIColor snowColor];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_w, Screen_h) style:UITableViewStylePlain];
    _tb.delegate =self;
    _tb.dataSource = self;
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tb];
    
    __weak __typeof(self) weakSelf = self;
    self.tb.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];
    
    self.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        [weakSelf loadData];
    }];
    self.tb.rowHeight = 120;
    [self.tb registerNib:[UINib nibWithNibName:@"JZL_JZBW_Cell" bundle:nil] forCellReuseIdentifier:@"JZL_JZBW_Cell"];
}
#pragma mark - 网络请求
-(void)loadData {
    
    NSString *depard = @"";
    if (![self.departId isEqualToString:@""]) {
        depard = self.departId;
    }else {
        depard = [UserDefaultsSetting shareSetting].departId;
    }
    NSString * urlString = [NSString stringWithFormat:AppJZBW,depard,self.pageNo,self.maxPageItems];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    JZL_JZBW_Model * model = [JZL_JZBW_Model modelWithDict:dict];
                    model.jzbwId = dict[@"id"];
                    [datas addObject:model];
                }
            }
        }
        
        //1.
        if ([weakSelf.pageNo intValue] == 1) {
            weakSelf.datas = datas;
        }else{
            [weakSelf.datas addObjectsFromArray:datas];
        }
        //2.
        [weakSelf.tb reloadData];
        [weakSelf.tb.mj_header endRefreshing];
        [weakSelf.tb.mj_footer endRefreshing];
        //3.
        if (weakSelf.datas.count < ([weakSelf.pageNo intValue]* [weakSelf.maxPageItems intValue])) {
            [weakSelf.tb.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZL_JZBW_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"JZL_JZBW_Cell" forIndexPath:indexPath];
    JZL_JZBW_Model * model = self.datas[indexPath.row];
    cell.model = model;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JZL_JZBW_Model *model = self.datas[indexPath.row];
    if (self.callBlock) {
        self.callBlock(model.projectname,model.zjiedian);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
