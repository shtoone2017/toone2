//
//  DCZ_CJ_Ineer_Controller.m
//  toone
//
//  Created by shtoone on 17/1/5.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "DCZ_CJ_Ineer_Controller.h"
#import "NetworkTool.h"
#import "NQ_BHZ_SCCX_Inne_Cell.h"
#import "NQ_BHZ_SCCX_InneModel.h"
#import "NQ_BHZ_SCCX_Inne_ moreModel.h"
#import "ProductionDetailsM.h"
#import "ProductionDetailsG.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
/***/
#import "LQ_CBCZ_Detail_ChuLi_Cell.h"
#import "LQ_CBCZ_Detail_ChuLi_Cell2.h"
#import "LQ_CBCZ_Detail_ChuLi_Controller.h"
#import "EXPrimaryModel.h"

@interface DCZ_CJ_Ineer_Controller ()
@property (nonatomic, strong) ProductionDetailsM *modelM;//数据显示
@property (nonatomic, strong) NQ_BHZ_SCCX_InneModel *model;//字段名称
@property (nonatomic, strong) NQ_BHZ_SCCX_Inne__moreModel *moreModel;//数据
@property (nonatomic, strong) ProductionDetailsG *modelG;
@property (nonatomic, strong) HNT_CBCZ_Detail_HeadMsg *headMsg;//超标处置

@property (nonatomic,assign) BOOL  filePathImageHas;
@property (nonatomic,strong) NSMutableArray * datas;
@end
@implementation DCZ_CJ_Ineer_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self looadData];
}
-(void)setUI {
    self.chuli = self.ChaoBiaoModel.chuli;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.navigationItem.title = @"详情";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LQ_CBCZ_Detail_ChuLi_Cell" bundle:nil] forCellReuseIdentifier:@"LQ_CBCZ_Detail_ChuLi_Cell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"LQ_CBCZ_Detail_ChuLi_Cell2" bundle:nil] forCellReuseIdentifier:@"LQ_CBCZ_Detail_ChuLi_Cell2"];
    [self looadData];
}

-(void)looadData {
    NSString *shebeiStr =self.ChaoBiaoModel.shebeibianhao;
    //[UserDefaultsSetting shareSetting].CBshebeibianhao;
    NSNumber *bianhaoBer = self.ChaoBiaoModel.bianhao;
    NSString *urlString = [NSString stringWithFormat:LQExInner,bianhaoBer,shebeiStr];
    
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
            
            weakSelf.headMsg = [HNT_CBCZ_Detail_HeadMsg modelWithDict:dict[@"data"]];
            
            //判断有没有图片
            NSString * urlString = FormatString(baseUrl, self.headMsg.filepath);
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            if (data.length > 100) {
                self.filePathImageHas = YES;
                data = nil;
            }
            weakSelf.datas = datas;
            [weakSelf.tableView reloadData];
        }

    }
     ];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (EqualToString(self.chuli, @"1")) {//已处置
        if (indexPath.row == 0) {
            return 630;
        }else {
            if (self.filePathImageHas) {
                return 450;
            }else{
                return 220;
            }
        }
    }else  if (EqualToString(self.chuli, @"0")){
        if (indexPath.row == 0) {
            return 630;
        }else {
            return 40;
        }
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (EqualToString(self.chuli, @"1")) {//已处置
        if (indexPath.row == 0) {
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
        }else {
            if (self.filePathImageHas) {
                LQ_CBCZ_Detail_ChuLi_Cell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_CBCZ_Detail_ChuLi_Cell2"];
                cell.headMsg = self.headMsg;
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                return cell;
            }else {
                LQ_CBCZ_Detail_ChuLi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_CBCZ_Detail_ChuLi_Cell"];
                cell.headMsg = self.headMsg;
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
    else if (EqualToString(self.chuli, @"0")) {//未处置
        if (indexPath.row == 0) {
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
        }else {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if ([UserDefaultsSetting shareSetting].lqchaobiaoReal) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(0, 0, Screen_w, 40);
                [btn setTitle:@"点击这里开始处置..." forState:UIControlStateNormal];
                [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [cell.contentView addSubview:btn];
                [btn addTarget:self action:@selector(goto_chuzhi) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
    }
    return nil;
}

-(void)goto_chuzhi{
    LQ_CBCZ_Detail_ChuLi_Controller * vc = [[LQ_CBCZ_Detail_ChuLi_Controller alloc] init];
    vc.bianhao = self.ChaoBiaoModel.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
