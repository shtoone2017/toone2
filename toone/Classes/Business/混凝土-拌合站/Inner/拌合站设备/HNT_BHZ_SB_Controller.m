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
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * datas;

@property (nonatomic, strong) NSArray *qddjArr;//强度等级
@end

@implementation HNT_BHZ_SB_Controller

- (void)viewWillAppear:(BOOL)animated {
    switch (_type) {
        case SBListTypeSJQD:{
            self.title = @"选择设计强度";
        }
            break;
        default:{
            self.title = @"选择设备";
            [self datas];
        }
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_w, Screen_h) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HNT_BHZ_SB_Controller"];
}
-(NSMutableArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        
        NSString * departId = self.departId;
        NSString * urlString = [NSString stringWithFormat:getShebeiList_1,departId];
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
    if (_type == SBListTypeSJQD) {//强度等级
        return self.qddjArr.count;
    }else {
        return self.datas.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_BHZ_SB_Controller" forIndexPath:indexPath];
    if (_type == SBListTypeSJQD) {//强度等级
        NSDictionary * dict = self.qddjArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else {
        HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
        cell.textLabel.text = model.banhezhanminchen;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == SBListTypeSJQD) {
        NSDictionary * dict = self.qddjArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], nil);
    }else {
        HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
        if (self.callBlock) {
            self.callBlock(model.banhezhanminchen,model.gprsbianhao);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSArray *)qddjArr {
    if (_qddjArr == nil) {
        _qddjArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"qddj.plist" ofType:nil]];
    }
    return _qddjArr;
}
@end
