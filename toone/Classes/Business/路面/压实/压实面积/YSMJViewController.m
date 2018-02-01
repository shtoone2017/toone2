//
//  YSMJViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YSMJViewController.h"
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
