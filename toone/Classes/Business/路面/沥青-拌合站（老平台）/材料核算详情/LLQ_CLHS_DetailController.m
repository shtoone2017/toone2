//
//  LLQ_CLHS_DetailController.m
//  toone
//
//  Created by 上海同望 on 2018/2/5.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "LLQ_CLHS_DetailController.h"
#import "LLQ_LSSJ_Detail_Head.h"
#import "LLQ_LSSJ_Detail_HeadCell.h"
#import "LLQ_CBCZ_Detail_DataCell1.h"
#import "LLQ_CDCZ_Detail_lqData.h"

@interface LLQ_CLHS_DetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tbleView;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) NSMutableArray * chartDatas;
@property (nonatomic,strong) NSMutableArray * charts;
@property (nonatomic,strong) NSMutableArray * titles;
@property (nonatomic,strong) NSMutableArray * colors;
@property (nonatomic,strong) LLQ_LSSJ_Detail_Head * headModel;
@property (nonatomic, strong) LLQ_CDCZ_Detail_lqData * cjModel;

@end
@implementation LLQ_CLHS_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];
    [self loadData];
}

-(void)loadUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, Screen_w, Screen_h) style:UITableViewStylePlain];
    _tbleView.delegate =self;
    _tbleView.dataSource = self;
    self.tbleView.tableFooterView = [[UIView alloc] init];
    [self.tbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tbleView];
    
    [self.tbleView registerNib:[UINib nibWithNibName:@"LLQ_LSSJ_Detail_HeadCell" bundle:nil] forCellReuseIdentifier:@"LLQ_LSSJ_Detail_HeadCell"];
    [self.tbleView registerNib:[UINib nibWithNibName:@"LLQ_CBCZ_Detail_DataCell1" bundle:nil] forCellReuseIdentifier:@"LLQ_CBCZ_Detail_DataCell1"];
}

-(void)loadData{
    NSString * urlString = [NSString stringWithFormat:lqmaterialxq,_detaId];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            
            if ([json[@"liqingxixxPage"] isKindOfClass:[NSDictionary class]]) {
                LLQ_CDCZ_Detail_lqData * data = [LLQ_CDCZ_Detail_lqData modelWithDict:json[@"liqingxixxPage"]];
                weakSelf.cjModel = data;
            }
            if ([json[@"liqingxixxPage"] isKindOfClass:[NSDictionary class]]) {
                LLQ_LSSJ_Detail_Head * headModel = [LLQ_LSSJ_Detail_Head modelWithDict:json[@"liqingxixxPage"]];
                weakSelf.headModel = headModel;
            }
            
            [weakSelf.tbleView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"材料信息";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140.0f;
    }
    if (indexPath.section == 1) {
        return 260;
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LLQ_LSSJ_Detail_HeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_LSSJ_Detail_HeadCell"];
        cell.model1 = self.headModel;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        LLQ_CBCZ_Detail_DataCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"LLQ_CBCZ_Detail_DataCell1"];
        cell.model= self.cjModel;
        return cell;
    }
    return nil;
}

@end
