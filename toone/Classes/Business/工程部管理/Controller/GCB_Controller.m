//
//  GCB_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/4.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_Controller.h"
#import "NodeViewController.h"
#import "GCB_Table_Cell.h"
#import "GCB_Model.h"
#import "WZ_GCB_InnerController.h"

@interface GCB_Controller ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;


@property (nonatomic,copy)NSString *parentno;//节点
@property (nonatomic,copy)NSString *parentName;//名
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,copy) NSString *pageNo;//当前页数
@property (nonatomic,copy) NSString *maxPageItems;//一页最多显示条数


@end
@implementation GCB_Controller

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_parentName) {
        NSString * zjjg = FormatString(@"分部分项 : ",_parentName);
        self.departName_Label.text = FormatString(zjjg, @"\t\t\t\t\t\t\t\t\t\t");
    }
    self.departName_Label.textColor = [UIColor whiteColor];
    self.departName_Label.font = [UIFont systemFontOfSize:12.0];
    self.departName_Label.speed = BBFlashCtntSpeedSlow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = @"1";
    self.maxPageItems = @"5";
    self.parentno = @"";
    [self addPanGestureRecognizer];
    [self loadTb];
    [self loadUI];
    [self loadData];
}

-(void)loadTb{
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 99, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    self.tb.separatorColor = [UIColor clearColor];
    __weak __typeof(self) weakSelf = self;
    self.tb.mj_header = [MJDIYHeader2 headerWithRefreshingBlock:^{
        weakSelf.pageNo = @"1";
        [weakSelf loadData];
    }];

    self.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo = FormatInt([weakSelf.pageNo intValue]+1);
        [weakSelf loadData];
    }];
    self.tb.rowHeight = 80;
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_Table_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_Table_Cell"];
}
-(void)loadUI{
    self.containerView.backgroundColor = BLUECOLOR;
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
}
#pragma mark - loadData
-(void)loadData{
    NSString * urlString = [NSString stringWithFormat:AppProgress,_parentno,_pageNo,_maxPageItems];
    __weak typeof(self)  weakSelf = self;
    if(self.datas){
        self.datas = nil;
        [self.tb reloadData];
    }
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_Model * model = [GCB_Model modelWithDict:dict];
                    model.uesid = dict[@"id"];
                    [datas addObject:model];
                }
            }
        }
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
#pragma mark -Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCB_Table_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_Table_Cell" forIndexPath:indexPath];
    GCB_Model * model = self.datas[indexPath.row];
    cell.model = model;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    WZ_TaBar_Controller * vc = (WZ_TaBar_Controller*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WZ_TaBar_Controller"];
    WZ_GCB_InnerController *vc = [[WZ_GCB_InnerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self performSegueWithIdentifier:@"WZ_TaBar_Controller" sender:nil];
}

- (IBAction)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 2:{
            __weak typeof(self) weakSelf = self;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeFBFX;
            vc.FBFXBlock = ^(NSString *identifier, NSString *name) {
                weakSelf.parentno = identifier;
                weakSelf.parentName = name;
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            [super pan];
            break;
        }
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
