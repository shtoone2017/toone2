
//
//  LQ_UsePosition_controller.m
//  toone
//
//  Created by sg on 2017/3/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_Peifang_Controller.h"

@interface LQ_Peifang_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tbleView;
@property (nonatomic,strong) NSArray * datas;

@end

@implementation LQ_Peifang_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, Screen_w, Screen_h) style:UITableViewStylePlain];
    _tbleView.delegate =self;
    _tbleView.dataSource = self;
    self.tbleView.rowHeight = 40;
    self.tbleView.tableFooterView = [[UIView alloc] init];
    [self.tbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LQ_Peifang_Controller"];
    [self.view addSubview:self.tbleView];
}
-(NSArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        
        NSString * urlString = appLq_usePosition;
//        NSDictionary * dict = @{@"departType":self.conditonDict[@"departType"],
//                                @"biaoshiid":self.conditonDict[@"biaoshiid"],
//                                };
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSArray * datas = [NSArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSDictionary class]]) {
                        datas = [json[@"data"] allValues];
                }
            }
            weakSelf.datas = datas;
            [weakSelf.tbleView reloadData];
            
            
            [Tools removeActivity];
        } failure:^(NSError *error) {
        }];
        
    }
    return _datas;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_Peifang_Controller" forIndexPath:indexPath];
    cell.textLabel.text = self.datas[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.callBlock) {
        self.callBlock(self.datas[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
