//
//  YSViewController.m
//  toone
//
//  Created by 上海同望 on 2018/1/26.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSViewController.h"
#import "YSView.h"
#import "SSYSViewController.h"
#import "YS_SB_Controller.h"

@interface YSViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic, strong) YSView *ysView;


@end
@implementation YSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ysView = [[YSView alloc] init];
    self.tb.tableHeaderView = self.ysView;
    
    [self loadUI];
    [self addPanGestureRecognizer];
}

-(void)loadUI {
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb.separatorStyle = NO;
    self.tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tb.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:244/255.f alpha:1];
//    self.tb.mj_header = [MJDIYHeader2 headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tb.mj_header beginRefreshing];
}

-(void)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 2:{
            YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
            sbVc.type = SBListTypeYSLX;
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.YScallBlock = ^(NSString *name, NSString *num) {
                [UserDefaultsSetting shareSetting].road_id = num;
            };
        }
            break;
        case 3:{
            [super pan];
        }
            break;
            
        default:
            break;
    }
}

-(void)searchButtonClick {
//    [super pan];
    SSYSViewController *vc = [SSYSViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    GCB_Model * model;
    if (self.datas.count) {
//        model = self.datas[0];
//        _seView.model = model;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"";
    cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:244/255.f alpha:1];
    return cell;
}

@end
