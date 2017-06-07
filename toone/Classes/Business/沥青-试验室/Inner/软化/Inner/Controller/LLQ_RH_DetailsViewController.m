//
//  LLQ_RH_DetailsViewController.m
//  toone
//
//  Created by 上海同望 on 2017/6/7.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_RH_DetailsViewController.h"

@interface LLQ_RH_DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel * chuliaoshijian_Label         ;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 样品编号
@property (weak, nonatomic) IBOutlet UILabel * gongchengmingcheng_Label     ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * jiaozuobuwei_Label           ;// 浇筑部位
@property (weak, nonatomic) IBOutlet UILabel *yangName;//样品名称
@property (weak, nonatomic) IBOutlet UILabel *ypmsLabel;//样品描述
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 平均值
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label          ;// 标准值

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;

@end
@implementation LLQ_RH_DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
-(void)loadData {
    self.automaticallyAdjustsScrollViewInsets = YES;
    NSString * urlString = [NSString stringWithFormat:RH_Datail,self.f_GUID];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        __weak typeof(self)  weakSelf = self;
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    weakSelf.jiaozuobuwei_Label.text = Format(json[@"SHeader2"]);
                    weakSelf.yangName.text = Format(json[@"SHeader3"]);
                    weakSelf.ypmsLabel.text = Format(json[@"SHeader4"]);
                    weakSelf.chuliaoshijian_Label.text = Format(dict[@"is_testtime"]);
                    weakSelf.banhezhanminchen_Label.text = Format(dict[@"header5"]);
                    weakSelf.gongchengmingcheng_Label.text = Format(dict[@"header3"]);
                    weakSelf.sigongdidian_Label.text = Format(json[@"avgvalue1"]);
                    weakSelf.qiangdudengji_Label.text = Format(dict[@"biaoZhun1"]);
                    weakSelf.container1_label.text = Format(json[@"ruanhuadian1"]);
                    weakSelf.container2_label.text = Format(json[@"ruanhuadian2"]);
                    
                }
            }
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}


@end
