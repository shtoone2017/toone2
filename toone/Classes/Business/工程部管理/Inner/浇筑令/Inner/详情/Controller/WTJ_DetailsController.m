//
//  WTJ_DetailsController.m
//  toone
//
//  Created by 上海同望 on 2017/10/12.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "WTJ_DetailsController.h"
#import "GCB_JZL_DetailModel.h"

@interface WTJ_DetailsController ()
@property (weak, nonatomic) IBOutlet UITextField *rwbhText;//任务编号+1
@property (weak, nonatomic) IBOutlet UIButton *kptimeBut;//开盘时间+1
@property (weak, nonatomic) IBOutlet UIButton *jzbwBut;//浇筑部位+1
@property (weak, nonatomic) IBOutlet UITextField *gcmcText;//工程名称+1
@property (weak, nonatomic) IBOutlet UITextField *kddjText;//抗冻等级
@property (weak, nonatomic) IBOutlet UIButton *jzfsBut;//浇筑方式
@property (weak, nonatomic) IBOutlet UILabel *cjtimeLabel;//创建时间
@property (weak, nonatomic) IBOutlet UITextField *jhflText;//计划方量+1
@property (weak, nonatomic) IBOutlet UIButton *jgBut;//组织机构+1
@property (weak, nonatomic) IBOutlet UIButton *sjqdBut;//设计强度
@property (weak, nonatomic) IBOutlet UIButton *tldBut;//塌落度
@property (weak, nonatomic) IBOutlet UIButton *sgdBut;//施工队
@property (weak, nonatomic) IBOutlet UILabel *userLabel;//创建人
@property (weak, nonatomic) IBOutlet UITextField *ksdjText;//抗滲等级
@property (weak, nonatomic) IBOutlet UITextField *bzText;//备注

@end
@implementation WTJ_DetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.title = @"详情";
    _rwbhText.enabled = NO;
    _gcmcText.enabled = NO;
    _kddjText.enabled = NO;
    _jhflText.enabled = NO;
    _ksdjText.enabled = NO;
    _bzText.enabled = NO;
}

-(void)loadData {
    NSString * urlString = [NSString stringWithFormat:AppJZL_BJDetail,_detailId];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    _rwbhText.text = Format(dict[@"renwuno"]);
                    [_kptimeBut setTitle:Format(dict[@"kaipanriqi"]) forState:UIControlStateNormal];
                    [_jzbwBut setTitle:Format(dict[@"jzbw"]) forState:UIControlStateNormal];
                    _gcmcText.text = Format(dict[@"gcmc"]);
                    _kddjText.text = Format(dict[@"kangdongdengji"]);
                    [_jzfsBut setTitle:Format(dict[@"jiaozhufangshi"]) forState:UIControlStateNormal];
                    _cjtimeLabel.text = Format(dict[@"createtime"]);
                    _jhflText.text = Format(dict[@"jihuafangliang"]);
                    [_jgBut setTitle:Format(dict[@"departname"]) forState:UIControlStateNormal];
                    [_sjqdBut setTitle:Format(dict[@"shuinibiaohao"]) forState:UIControlStateNormal];
                    [_tldBut setTitle:Format(dict[@"tanluodu"]) forState:UIControlStateNormal];
                    if (dict[@"shigongteamname"]) {
                        [_sgdBut setTitle:Format(dict[@"shigongteamname"]) forState:UIControlStateNormal];//施工
                    }
                    _userLabel.text = Format(dict[@"createperson"]);
                    _ksdjText.text = Format(dict[@"kangshendengji"]);
                    _bzText.text = Format(dict[@"remark"]);
                }
            }
        }
        
    } failure:^(NSError *error) {
        
    }];

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
