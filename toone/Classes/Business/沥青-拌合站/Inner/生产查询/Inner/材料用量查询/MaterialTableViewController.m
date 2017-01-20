//
//  MaterialTableViewController.m
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MaterialTableViewController.h"
#import "NetworkTool.h"
#import "LQ_CLHS_Cell.h"
#import "LQ_CLHS_ModelG.h"
#import "LQ_CLHS_DataModel.h"
#import "BarModel.h"

@interface MaterialTableViewController ()
@property (nonatomic, strong) LQ_CLHS_ModelG *modelG;
@property (nonatomic, strong) LQ_CLHS_DataModel *dataModel;
@property (nonatomic, copy) NSString *urlString;

@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) NSMutableArray * datas1;
@property (nonatomic,strong) NSMutableArray * datas2;
@end
@implementation MaterialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    NSString *shebStr = @"";
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:super.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:super.endTime];
    NSString *urlString = [NSString stringWithFormat:LQMaterial,shebStr,startTimeStamp,endTimeStamp,userGroupId];
    [self reloadData:urlString];
}

-(void)setUI {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.frame = CGRectMake(0, 100, Screen_w, Screen_h - 105);
    self.tableView.rowHeight = 1100;
}

-(void)reloadData:(NSString *)urlString {
    self.urlString = urlString;
    __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSMutableArray * datas = [NSMutableArray array];
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict[@"success"] boolValue]) {
            weakSelf.modelG = [LQ_CLHS_ModelG modelWithDict:dict[@"Fields"]];
            weakSelf.dataModel = [LQ_CLHS_DataModel modelWithDict:dict[@"data"]];
            [datas addObject:weakSelf.modelG];
            [datas addObject:weakSelf.dataModel];
        }
        NSMutableArray * bars1 = [NSMutableArray array];
        NSMutableArray * bars2 = [NSMutableArray array];
        //实际量
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjf1 withValue:weakSelf.dataModel.sjf1]];
         [bars1 addObject: [self loadBarName:weakSelf.modelG.sjf2 withValue:weakSelf.dataModel.sjf2]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjg1 withValue:weakSelf.dataModel.sjg1]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjg2 withValue:weakSelf.dataModel.sjg2]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjg3 withValue:weakSelf.dataModel.sjg3]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjg4 withValue:weakSelf.dataModel.sjg4]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjg5 withValue:weakSelf.dataModel.sjg5]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjg6 withValue:weakSelf.dataModel.sjg6]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjg7 withValue:weakSelf.dataModel.sjg7]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjlq withValue:weakSelf.dataModel.sjlq]];
        [bars1 addObject: [self loadBarName:weakSelf.modelG.sjtjj withValue:weakSelf.dataModel.sjtjj]];
        //误差率
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjf1 withValue:weakSelf.dataModel.wsjf1]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjf2 withValue:weakSelf.dataModel.wsjf2]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjg1 withValue:weakSelf.dataModel.wsjg1]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjg2 withValue:weakSelf.dataModel.wsjg2]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjg3 withValue:weakSelf.dataModel.wsjg3]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjg4 withValue:weakSelf.dataModel.wsjg4]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjg5 withValue:weakSelf.dataModel.wsjg5]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjg6 withValue:weakSelf.dataModel.wsjg6]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjg7 withValue:weakSelf.dataModel.wsjg7]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjlq withValue:weakSelf.dataModel.wsjlq]];
        [bars2 addObject: [self loadBarName:weakSelf.modelG.sjtjj withValue:weakSelf.dataModel.wsjtjj]];
        
        weakSelf.datas1 = bars1;
        weakSelf.datas2 = bars2;
        [weakSelf.tableView reloadData];
    }
     ];
    
}
-(BarModel *)loadBarName:(NSString *)name withValue:(NSString *)value {
    BarModel *bar = [[BarModel alloc] init];
    bar.name = name;
    bar.value = value;
    return bar;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LQ_CLHS_Cell";
    UINib *nib = [UINib nibWithNibName:@"LQ_CLHS_Cell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    LQ_CLHS_Cell *cell = (LQ_CLHS_Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell.unitButton addTarget:self action:@selector(choiceUnit:) forControlEvents:UIControlEventTouchUpInside];
    cell.datas1 = self.datas1;
    cell.datas2 = self.datas2;
    //核算表
    cell.modelG = self.modelG;//数据
    cell.dataModel = self.dataModel;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)choiceUnit:(UIButton*)sender {
    
}


@end
