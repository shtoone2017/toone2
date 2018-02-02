//
//  HNT_BHZ_SB_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LQ_SB_Controller.h"
#import "LQ_SB_Model.h"
@interface LQ_SB_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tbleView;
@property (nonatomic,strong) NSMutableArray * datas;
@end

@implementation LQ_SB_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, Screen_w, Screen_h) style:UITableViewStylePlain];
    _tbleView.delegate =self;
    _tbleView.dataSource = self;
    self.tbleView.rowHeight = 40;
    self.tbleView.tableFooterView = [[UIView alloc] init];
    [self.tbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LQ_SB_Controller"];
    [self.view addSubview:self.tbleView];
}
-(NSMutableArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        
        NSString * urlString = [NSString stringWithFormat:machineList,self.conditonDict[@"bhjtype"],self.conditonDict[@"userGroupId"]];
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        LQ_SB_Model * model = [LQ_SB_Model modelWithDict:dict];
                        [datas addObject:model];
                    }
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_SB_Controller" forIndexPath:indexPath];
    LQ_SB_Model * model = self.datas[indexPath.row];
    cell.textLabel.text = model.banhezhanminchen;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LQ_SB_Model * model = self.datas[indexPath.row];
    if (self.callBlock) {
        self.callBlock(model.banhezhanminchen,model.gprsbianhao);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
