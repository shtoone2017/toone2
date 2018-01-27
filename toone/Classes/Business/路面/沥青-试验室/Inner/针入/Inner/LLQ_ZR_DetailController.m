//
//  LLQ_ZR_DetailController.m
//  toone
//
//  Created by 上海同望 on 2017/6/8.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_ZR_DetailController.h"

@interface LLQ_ZR_DetailController ()
@property (weak, nonatomic) IBOutlet UILabel * chuliaoshijian_Label         ;// 出料时间
@property (weak, nonatomic) IBOutlet UILabel * banhezhanminchen_Label       ;// 样品编号
@property (weak, nonatomic) IBOutlet UILabel * gongchengmingcheng_Label     ;// 工程名称
@property (weak, nonatomic) IBOutlet UILabel * jiaozuobuwei_Label           ;// 浇筑部位
@property (weak, nonatomic) IBOutlet UILabel *yangName;//样品名称
@property (weak, nonatomic) IBOutlet UILabel *ypmsLabel;//样品描述
@property (weak, nonatomic) IBOutlet UILabel * sigongdidian_Label           ;// 平均值
@property (weak, nonatomic) IBOutlet UILabel * qiangdudengji_Label          ;// 标准值
@property (weak, nonatomic) IBOutlet UILabel *bz2;


@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;
@property (weak, nonatomic) IBOutlet UILabel *zr3;
@property (nonatomic,strong) NSArray *datas;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@end
@implementation LLQ_ZR_DetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (kDevice_Is_iPhoneX) {
        self.top.constant = 88;
    }else {
        self.top.constant = 64;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.title = @"详情";
}
-(void)loadData {
    NSString * urlString = [NSString stringWithFormat:ZR_Datail,self.f_GUID];
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        __weak typeof(self)  weakSelf = self;
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    weakSelf.jiaozuobuwei_Label.text = Format(dict[@"SHeader2"]);
                    weakSelf.yangName.text = Format(dict[@"SHeader3"]);
                    weakSelf.ypmsLabel.text = Format(dict[@"SHeader4"]);
                    weakSelf.chuliaoshijian_Label.text = Format(dict[@"IS_TESTTIME"]);
                    weakSelf.banhezhanminchen_Label.text = Format(dict[@"header5"]);
                    weakSelf.gongchengmingcheng_Label.text = Format(dict[@"header3"]);
                    weakSelf.sigongdidian_Label.text = Format(dict[@"avgvalue1"]);
                    weakSelf.qiangdudengji_Label.text = Format(dict[@"biaoZhun1"]);
                    weakSelf.datas = [dict[@"zhenRuDuGuoChengZhi"] componentsSeparatedByString:@","];
                    weakSelf.bz2.text = Format(dict[@"biaoZhun2"]);
                    weakSelf.container1_label.text = weakSelf.datas[0];
                    weakSelf.container2_label.text = weakSelf.datas[1];
                    weakSelf.zr3.text = weakSelf.datas[2];
                    
                }
            }
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
