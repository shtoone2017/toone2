//
//  LLQ_RH_DetailController.m
//  toone
//
//  Created by 上海同望 on 2017/6/7.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_RH_DetailController.h"
#import "LLQ_RH_DetailCell.h"
#import "HTTP.h"
#import "LLQ_RH_Model.h"

@interface LLQ_RH_DetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) LLQ_RH_Model * RHModel;
@end
@implementation LLQ_RH_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadData];
    [self loadUI];
}

-(void)loadUI{
    [self.tb registerNib:[UINib nibWithNibName:@"LLQ_RH_DetailCell" bundle:nil] forCellReuseIdentifier:@"LLQ_RH_DetailCell"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tb];
//    self.tb.tableFooterView = [[UIView alloc] init];
//    self.tb.separatorColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
//    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)loadData {
    
//    NSString *urlString = @"";
    NSString * urlString = [NSString stringWithFormat:RH_Datail,self.f_GUID];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    LLQ_RH_Model * model =  [[LLQ_RH_Model alloc] init];
                    model.SHeader2 = dict[@"SHeader2"];
                    model.SHeader3 = dict[@"SHeader3"];
                    model.SHeader4 = dict[@"SHeader4"];
                    model.is_testtime = dict[@"is_testtime"];
                    model.isQualified = dict[@"isQualified"];
                    model.header5 = dict[@"header5"];
                    model.header3 = dict[@"header3"];
                    
                    model.avgvalue1 = dict[@"avgvalue1"];
                    model.biaoZhun1 = dict[@"biaoZhun1"];
                    model.ruanhuadian1 = dict[@"ruanhuadian1"];
                    model.ruanhuadian1 = dict[@"ruanhuadian1"];
                    
                    [datas addObject:model];
                }
            }
        }
        self.datas = datas;
        
    } failure:^(NSError *error) {
        
    }];
}

-(NSMutableArray *)datas{
    if (!_datas) {
        //添加指示器
        [Tools showActivityToView:self.view];
        
        NSString * urlString = [NSString stringWithFormat:RH_Datail,self.f_GUID];
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        LLQ_RH_Model * data = [LLQ_RH_Model modelWithDict:dict];
                        weakSelf.RHModel = data;
//                        [datas addObject:data];
                    }
                }
            }

            weakSelf.datas = datas;
            [weakSelf.tb reloadData];
            
            //移除指示器
            [Tools removeActivity];
        } failure:^(NSError *error) {
        }];
    }
    return _datas;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"LLQ_RH_DetailCell";
//    UINib *nib = [UINib nibWithNibName:@"LLQ_RH_DetailCell" bundle:nil];
//    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
//    LLQ_RH_DetailCell *cell = (LLQ_RH_DetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
    LLQ_RH_DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_RH_DetailCell" forIndexPath:indexPath];
////    cell.currentIndexPath = indexPath;
//    LLQ_RH_Model * model = self.datas[indexPath.row];
//    cell.model = model;
    
    
//    LLQ_RH_DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_RH_DetailCell"];
//    cell.mode = self.headMsg;
    LLQ_RH_Model * model = self.datas[indexPath.row];
    cell.model = model;
    

    return cell;
}

@end
