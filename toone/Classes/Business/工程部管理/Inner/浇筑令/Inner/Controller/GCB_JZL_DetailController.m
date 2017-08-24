//
//  GCB_JZL_DetailController.m
//  toone
//
//  Created by 上海同望 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JZL_DetailController.h"
#import "GCB_JZL_DetailModel.h"
#import "GCB_JZL_DetailCell.h"


@interface GCB_JZL_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic,strong) NSMutableArray *datas;

@end
@implementation GCB_JZL_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务单编辑";
    [self loadUI];
    [self loadData];
}
-(void)loadUI{
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    //    self.tb.separatorColor = [UIColor clearColor];
    self.tb.rowHeight = 550;
    [self.tb registerNib:[UINib nibWithNibName:@"GCB_JZL_DetailCell" bundle:nil] forCellReuseIdentifier:@"GCB_JZL_DetailCell"];
}
-(void)loadData{
    NSString * urlString = [NSString stringWithFormat:AppJZL_BJDetail,_detailId];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_JZL_DetailModel * model = [GCB_JZL_DetailModel modelWithDict:dict];
                    model.tjId = dict[@"id"];
                    [datas addObject:model];
                }
            }
        }
        weakSelf.datas = datas;
        [weakSelf.tb reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCB_JZL_DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_JZL_DetailCell" forIndexPath:indexPath];
    GCB_JZL_DetailModel * model = self.datas[indexPath.row];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}


@end
