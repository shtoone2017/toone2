//
//  BFDetailViewController.m
//  toone
//
//  Created by 景晓峰 on 2017/8/10.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "BFDetailViewController.h"
#import "BFListModel.h"
#import "BFListCell.h"

@interface BFDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tbView;
    BFListModel *dataModel;
}
@end

@implementation BFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
}

- (void)setUpUI
{
    //创建列表
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Screen_w,Screen_h) style:UITableViewStylePlain];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tbView.estimatedRowHeight = 30.0;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
}

- (void)getData
{
    WS(weakSelf);
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:_urlStr parmas:@{@"id":_identifier} completeBlock:^(id result) {
        if (result && result != nil)
        {
            NSDictionary *dict = (NSDictionary *)result;
            dataModel = [[BFListModel alloc] initWithDictionary:dict[@"data"] error:nil];
        }
        [weakSelf setUpUI];
    }];

    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    switch (section)
//    {
//        case 0:
//            return 1;
//            break;
//        default:
//            return 1;
//            break;
//    }
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0)
//    {
//        
//    }
    static NSString *cellId = @"BFListCell1";
    BFListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BFListCell" owner:self options:nil] objectAtIndex:3];
        
    }
    cell.Remeke.text = dataModel.remark;
    cell.Car_Num.text = dataModel.qianchepai;
    cell.Order_Num.text = [NSString stringWithFormat:@"%@",dataModel.jinchuliaodanNo];
    cell.PC.text = dataModel.pici;
    cell.LC_Name.text = dataModel.liaocang;
    cell.JC_Time.text = dataModel.jinchangshijian;
    cell.CC_Time.text = dataModel.chuchangshijian;
    cell.Person_Name.text = dataModel.sibangyuan;
    cell.DB_Name.text = dataModel.banhezhanminchen;
    cell.GYS_Name.text = dataModel.gongyingshangName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
