//
//  YSMJViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSMJViewController.h"
#import "Exp_Final.h"
#define grid_layer @"grid_layer"
#define road_id @"road_id"
#define start_stake @"start_stake"
#define end_stake @"end_stake"


@interface YSMJViewController ()
@property (nonatomic,strong) NSMutableDictionary *paraDic;
@end

@implementation YSMJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI
{
    self.title = @"压实面积统计";
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)searchButtonClick
{
    NSMutableArray *tempArr = [NSMutableArray array];
    NSArray *titleArr = @[@"线路选择",@"起始桩号",@"结束桩号",@"面层选择"];
    NSArray *typeArr = @[[NSNumber numberWithInteger:YS_Search_Type_RoadID],[NSNumber numberWithInteger:YS_Search_Type_StartStack],[NSNumber numberWithInteger:YS_Search_Type_EndStack],[NSNumber numberWithInteger:YS_Search_Type_Layer]];
    for (int i = 0; i<titleArr.count; i++)
    {
        Exp_FinalModel *model = [[Exp_FinalModel alloc] init];
        model.title = titleArr[i];
        model.type = [typeArr[i] integerValue];
        [tempArr addObject:model];
    }
    Exp_Final *expView = [[[NSBundle mainBundle] loadNibNamed:@"Exp_Final" owner:self options:nil] objectAtIndex:0];
    expView.dataArr = tempArr;
    expView.frame = CGRectMake(0, 64, Screen_w, Screen_h-64);
    [self.view addSubview:expView];
}

- (void)requestArea
{
    //?road_id=%@&start_stake=%@&end_stake=%@&grid_layer=%@
    //[_paraDic objectForKey:road_id],[_paraDic objectForKey:start_stake],[_paraDic objectForKey:end_stake],[_paraDic objectForKey:grid_layer]
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:YS_Mianji parameter:_paraDic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
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
