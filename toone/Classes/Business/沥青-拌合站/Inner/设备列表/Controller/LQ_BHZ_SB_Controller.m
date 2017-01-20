//
//  LQ_BHZ_SB_Controller.m
//  toone
//
//  Created by shtoone on 16/12/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LQ_BHZ_SB_Controller.h"
#import "SB_Model.h"

@interface LQ_BHZ_SB_Controller ()
@property (nonatomic, strong) NSArray *datas;

@end
@implementation LQ_BHZ_SB_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadData];
}

-(void)setUI {
    self.title = @"选择设备";
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.rowHeight = 40;
//    self.tableView.bounces = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LQ_BHZ_SB_Controller"];
}

-(void)loadData {
    SB_Model *model = [[SB_Model alloc] init];
    __weak typeof(self)  weakSelf = self;
    [model sb_Block:^(NSArray *result) {
        weakSelf.datas = result;
        
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_BHZ_SB_Controller" forIndexPath:indexPath];
    SB_Model * model = self.datas[indexPath.row];
    cell.textLabel.text = model.banhezhanminchen;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SB_Model * model = self.datas[indexPath.row];
    if (self.callBlock) {
        self.callBlock(model.banhezhanminchen,model.gprsbianhao);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
