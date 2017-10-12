//
//  GCB_WSC_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/20.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_WSC_Cell.h"
#import "GCB_JZL_Model.h"
#import "GCB_RWD_DetailController.h"
#import "TZD_DetailViewController.h"

@interface GCB_WSC_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *kpsjLabel;
@property (weak, nonatomic) IBOutlet UILabel *ztLabel;//状态
@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *jzbwLabel;//浇筑部位
@property (weak, nonatomic) IBOutlet UILabel *sjqdLabel;//设计强度
@property (weak, nonatomic) IBOutlet UILabel *sjflLabel;//设计方量
@property (weak, nonatomic) IBOutlet UILabel *cjsjLabel;//创建时间
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@property (weak, nonatomic) IBOutlet UIButton *rwbhBut;
@property (weak, nonatomic) IBOutlet UIButton *pbdBut;



@end
@implementation GCB_WSC_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(GCB_JZL_Model *)model {
    _model = model;
    _kpsjLabel.text = model.kaipanriqi;
    _gcmcLabel.text = model.gcmc;
    _jzbwLabel.text = model.jzbw;
    _sjqdLabel.text = model.shuinibiaohao;
    _sjflLabel.text = model.jihuafangliang;
    _cjsjLabel.text = model.createtime;
    _userLabel.text = model.createperson;
    [_rwbhBut setTitle:model.renwuno forState:UIControlStateNormal];
    [_pbdBut setTitle:model.sgphbno forState:UIControlStateNormal];
    
    if ([model.zhuangtai isEqualToString:@"0"]) {
        _ztLabel.text = [NSString stringWithFormat:@"未配料"];
//        _ztLabel.textColor = [UIColor blueColor];
    }if ([model.zhuangtai isEqualToString:@"1"]) {
        _ztLabel.text = [NSString stringWithFormat:@"已配料"];
//        _ztLabel.textColor = [UIColor orangeColor];
    }if ([model.zhuangtai isEqualToString:@"2"]) {
        _ztLabel.text = [NSString stringWithFormat:@"生产中"];
//        _ztLabel.textColor = [UIColor greenColor];
    }if ([model.zhuangtai isEqualToString:@"3"]) {
        _ztLabel.text = [NSString stringWithFormat:@"已完成"];
    }if ([model.zhuangtai isEqualToString:@"-1"]) {
        _ztLabel.text = [NSString stringWithFormat:@"未提交"];
//        _ztLabel.textColor = [UIColor redColor];
    }
}



//任务单
- (IBAction)rwdClick:(id)sender {
    GCB_RWD_DetailController *vc = [[GCB_RWD_DetailController alloc] init];
    vc.detailId = [NSString stringWithFormat:@"%@",self.model.rwdId];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
//配比单
- (IBAction)pbClick:(UIButton *)sender {
    if (![sender.titleLabel.text isEqualToString:@"未配料"]) {
        TZD_DetailViewController *vc = [[TZD_DetailViewController alloc] init];
        vc.detailNum = self.model.sgphbno;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"未生成配料单无法查看";
        [hud hideAnimated:YES afterDelay:2.0];
    }
}


- (UIViewController *)viewController {
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}


@end
