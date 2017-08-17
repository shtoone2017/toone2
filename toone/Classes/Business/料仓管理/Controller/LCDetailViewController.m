//
//  LCDetailViewController.m
//  toone
//
//  Created by 景晓峰 on 2017/8/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LCDetailViewController.h"
#import "LCListModel.h"
#import "LCListCell.h"
#import "LCDetailXZModel.h"

@interface LCDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tbView;
    LCListModel *dataModel;
    LCDetailXZModel *xzModel;
}

@end

@implementation LCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
}

- (void)setUpUI
{
    //创建列表
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0,70,Screen_w,Screen_h-70) style:UITableViewStyleGrouped];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tbView.estimatedRowHeight = 30.0;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
}

- (void)getData
{
    NSString *urlString = [NSString stringWithFormat:@"%@AppKuCunInterfaceController.do?AppkuCunDetail",baseUrl];
    WS(weakSelf);
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString parmas:@{@"id":_identifier} completeBlock:^(id result) {
        if (result && result != nil)
        {
            NSDictionary *dict = (NSDictionary *)result;
            NSArray *tempArr = [NSArray arrayWithArray:dict[@"deatilData"]];
            dataModel = [[LCListModel alloc] initWithDictionary:tempArr[0] error:nil];
            NSArray *tempArr1 = [NSArray arrayWithArray:dict[@"xiuZhengMsg"]];
            xzModel = [[LCDetailXZModel alloc] initWithDictionary:tempArr1[0] error:nil];
        }
        [weakSelf setUpUI];
    }];
    
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *cellId = @"DetailCell1";
        LCListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LCListCell" owner:self options:nil] objectAtIndex:1];
            
            cell.LC_Detail_CLName_Label.text = dataModel.cailiaoname;
            cell.LC_Detail_SSJG_Label.text = dataModel.departname;
            cell.LC_Detail_KC_Label.text = [NSString stringWithFormat:@"%.2f",[dataModel.result floatValue]];
            cell.LC_Detail_CLJL_Label.text = dataModel.jinliang;
            cell.LC_Detail_LLCL_Label.text = dataModel.lilunchuliang;
            cell.LC_Detail_SJCL_Label.text = dataModel.shijichuliang;
            cell.LC_Detail_XZL_Label.text = dataModel.xiuzhengliang;
            cell.LC_Detail_CSL_Label.text = dataModel.chushiliang;
            if ([dataModel.baojing isEqualToString:@"0"])
            {
                cell.LC_Detail_BJ_Label.text = @"不报警";
            }
            else
            {
                cell.LC_Detail_BJ_Label.text = @"报警";
            }
            cell.LC_Detail_JJZ_Label.text = dataModel.jingjiezhi;
        }
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *cellId = @"DetailCell1";
        LCListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LCListCell" owner:self options:nil] objectAtIndex:2];
            
            cell.LC_Detail_BZ_Label.text = xzModel.remark;
            cell.LC_Detail_XZZ_Label.text = xzModel.xiuzhengzhi;
            cell.LC_Detail_XZR_Label.text = xzModel.createperson;
            cell.LC_Detail_CZSJ_Label.text = xzModel.createdatetime;
        }
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titleArr = @[@"基本信息",@"修正记录"];
    UIView *headerView = [UIView new];
    UILabel *titleLab = [UILabel new];
    titleLab.frame = CGRectMake(25, 10, 150, 25);
    titleLab.text = titleArr[section];
    titleLab.textColor = BLUECOLOR;
    [headerView addSubview:titleLab];
//    headerView.backgroundColor = [UIColor yellowColor];
    return headerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
