//
//  GCB_JCB_DetailController.m
//  toone
//
//  Created by 上海同望 on 2017/8/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCB_DetailController.h"
#import "JCB_DetailModel.h"
#import "JCB_DetailCell_1.h"

@interface GCB_JCB_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic,strong) NSMutableArray *datas;

@end
@implementation GCB_JCB_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    if (_type == GCBTypeJC) {
        self.navigationItem.title = @"材料进场过磅明细";
        [self loadJCData];
    }if (_type == GCBTypeCC) {
        self.navigationItem.title = @"材料出场过磅明细";
        [self loadCCData];
    }
}

-(void)loadUI {
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb.rowHeight = 300;
    [self.tb registerNib:[UINib nibWithNibName:@"JCB_DetailCell_1" bundle:nil] forCellReuseIdentifier:@"JCB_DetailCell_1"];
}
#pragma mark - 网络请求
-(void)loadJCData {
    if (_pici != nil && ![_pici isKindOfClass:[NSNull class]]) {//不为空
        
    }else {
        _pici = @"null";
    }
    NSString * urlString = [NSString stringWithFormat:AppJCB_Detail_1,_jinchuliaodanNo,_cailiaoNo,_gongyingshangdanweibianma,_pici,_shebeibianhao,_jcmin,_jcmax,_ccmin,_ccmax];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    JCB_DetailModel * model = [JCB_DetailModel modelWithDict:dict];
                    [datas addObject:model];
                }
            }
        }
        
        weakSelf.datas = datas;
        [weakSelf.tb reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadCCData {//出厂
    if (_pici != nil && ![_pici isKindOfClass:[NSNull class]]) {//不为空
        
    }else {
        _pici = @"null";
    }
    NSString * urlString = [NSString stringWithFormat:AppCCB_Detail_2,_ccid,_guobangleibie,_cailiaoNo,_gongyingshangdanweibianma,_pici,_shebeibianhao,_jcmin,_jcmax,_ccmin,_ccmax];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    JCB_DetailModel * model = [JCB_DetailModel modelWithDict:dict];
                    model.istype = @"出厂";
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
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JCB_DetailCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"JCB_DetailCell_1" forIndexPath:indexPath];
    JCB_DetailModel * model = self.datas[indexPath.row];
    cell.model = model;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
