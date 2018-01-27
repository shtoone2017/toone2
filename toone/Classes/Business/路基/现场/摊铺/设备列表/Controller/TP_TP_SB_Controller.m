//
//  TP_NY_SB_Controller.m
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_TP_SB_Controller.h"
#import "TP_SB_Model.h"

@interface TP_TP_SB_Controller ()
@property (nonatomic, strong) NSArray *datas;
@end
@implementation TP_TP_SB_Controller

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TP_TP_SB_Controller"];
}

-(void)loadData {
    TP_SB_Model *model = [[TP_SB_Model alloc] init];
    __weak typeof(self)  weakSelf = self;
    [model sb_Block:^(NSArray *result) {
        
        weakSelf.datas = result;
        
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TP_TP_SB_Controller" forIndexPath:indexPath];
    TP_SB_Model * model = self.datas[indexPath.row];
    cell.textLabel.text = model.banhezhanminchen;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TP_SB_Model * model = self.datas[indexPath.row];
    if (self.callBlock) {
        self.callBlock(model.banhezhanminchen,model.gprsbianhao);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
