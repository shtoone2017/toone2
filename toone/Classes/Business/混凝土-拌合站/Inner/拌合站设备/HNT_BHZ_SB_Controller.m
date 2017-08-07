//
//  HNT_BHZ_SB_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_BHZ_SB_Controller.h"
#import "HNT_BHZ_SB_Model.h"
@interface HNT_BHZ_SB_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * datas;
@end

@implementation HNT_BHZ_SB_Controller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"adaada";
    [self datas];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 40;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HNT_BHZ_SB_Controller"];
}
-(NSMutableArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        
        NSString * departId = self.departId;
        NSString * urlString;
        if (_type == SBListTypeBF)
        {
            //磅房设备URL
            urlString = [NSString stringWithFormat:@"%@AppGB.do?AppDiBangList&departId=%@",baseUrl,[UserDefaultsSetting shareSetting].departId];
        }
        else
        {
            urlString = [NSString stringWithFormat:getShebeiList_1,departId];
        }
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        HNT_BHZ_SB_Model * model = [HNT_BHZ_SB_Model modelWithDict:dict];
                        [datas addObject:model];
                    }
                }
            }
            weakSelf.datas = datas;
            [weakSelf.tableView reloadData];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_BHZ_SB_Controller" forIndexPath:indexPath];
    HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
    cell.textLabel.text = model.banhezhanminchen;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
    if (self.callBlock) {
        self.callBlock(model.banhezhanminchen,model.gprsbianhao);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
