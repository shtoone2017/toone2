//
//  NQ_BHZ_SCCX_Innel_Controller.m
//  toone
//
//  Created by shtoone on 16/12/26.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NQ_BHZ_SCCX_Innel_Controller.h"
#import "NetworkTool.h"
#import "NQ_BHZ_SCCX_Inne_Cell.h"
#import "NQ_BHZ_SCCX_InneModel.h"
#import "NQ_BHZ_SCCX_Inne_ moreModel.h"
#import "ProductionDetailsM.h"
#import "ProductionDetailsG.h"

@interface NQ_BHZ_SCCX_Innel_Controller ()
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) ProductionDetailsM *modelM;//数据显示
@property (nonatomic, strong) NQ_BHZ_SCCX_InneModel *model;//字段名称

@property (nonatomic, strong) NQ_BHZ_SCCX_Inne__moreModel *moreModel;//数据
@property (nonatomic, strong) ProductionDetailsG *modelG;

@end
@implementation NQ_BHZ_SCCX_Innel_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
#warning 需手动刷新一次
    [self looadData];
}

-(void)setUI {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.title = @"生产数据详情";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = 610;
    
   [self looadData];
}

-(void)looadData {
    NSString *shebeiStr = [UserDefaultsSetting shareSetting].shebeibianhao;
    NSNumber *bianhaoBer = [UserDefaultsSetting shareSetting].bianhao;
    NSString *urlString = [NSString stringWithFormat:ProductionDetails,shebeiStr,bianhaoBer];
    __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
                    NSMutableArray * datas = [NSMutableArray array];
        NSDictionary *dict = (NSDictionary *)result;
        
        if ([dict[@"success"] boolValue]) {
            weakSelf.modelM = [ProductionDetailsM modelWithDict:dict[@"data"]];
            weakSelf.model = [NQ_BHZ_SCCX_InneModel moodWithDict:dict[@"Fields"]];
            
            weakSelf.moreModel = [NQ_BHZ_SCCX_Inne__moreModel modelWithDict:dict[@"data"]];
            weakSelf.modelG = [ProductionDetailsG modelWithDict:dict[@"Fields"]];
            
            [datas addObject:weakSelf.modelM];
            [datas addObject:weakSelf.model];
        }
        [weakSelf.tableView reloadData];
    }
     ];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *CellIdentifier = @"NQ_BHZ_SCCX_Inne_Cell";
        UINib *nib = [UINib nibWithNibName:@"NQ_BHZ_SCCX_Inne_Cell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        NQ_BHZ_SCCX_Inne_Cell *cell = (NQ_BHZ_SCCX_Inne_Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //上段
        cell.model = self.model;
        cell.modelM = self.modelM;//数据
    
    //核算表
        cell.moreModel = self.moreModel;//数据
        cell.modelG = self.modelG;

        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
}

@end
