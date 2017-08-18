//
//  GCB_RWD_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/17.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_RWD_Cell.h"
#import "GCB_RWD_Model.h"
#import "ZYProGressView.h"

@interface GCB_RWD_Cell (){
    ZYProGressView *progress;
}
@property (weak, nonatomic) IBOutlet UILabel *kaipanriqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhutLabel;
@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *jzbwLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuinibiaohaoLabel;
@property (weak, nonatomic) IBOutlet UIButton *renwuBut;
@property (weak, nonatomic) IBOutlet UIButton *sgphbBut;
@property (weak, nonatomic) IBOutlet UIView *jdView;
@property (weak, nonatomic) IBOutlet UILabel *baifenbiLabel;
@property (weak, nonatomic) IBOutlet UILabel *shejifangliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *jihuafangliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *shijifangliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiechaoLabel;



@end
@implementation GCB_RWD_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    progress = [[ZYProGressView alloc] initWithFrame:CGRectMake(0, _jdView.frame.origin.y+8, 100, 7)];
    [self.jdView addSubview:progress];
}

-(void)setModel:(GCB_RWD_Model *)model {
    _model = model;
    NSString *jin = [NSString stringWithFormat:@"%@",model.baifenbi];
    progress.progressValue = [NSString stringWithFormat:@"%.2f",[jin doubleValue]*0.01];
    progress.progressColor = [UIColor orangeColor];
    
    _baifenbiLabel.text = [NSString stringWithFormat:@"%@%%",jin];
    _kaipanriqiLabel.text = model.kaipanriqi;
    _gcmcLabel.text = model.gcmc;
    _jzbwLabel.text = model.jzbw;
    _shuinibiaohaoLabel.text = model.shuinibiaohao;
    [_renwuBut setTitle:model.renwuNo forState:UIControlStateNormal];
    [_sgphbBut setTitle:model.sgphbNo forState:UIControlStateNormal];
    _shejifangliangLabel.text = [NSString stringWithFormat:@"%@",model.shejifangliang];
    _jihuafangliangLabel.text = model.jihuafangliang;
    _shijifangliangLabel.text = [NSString stringWithFormat:@"%@",model.shijifangliang];
    _jiechaoLabel.text = [NSString stringWithFormat:@"%@",model.jiechao];
    
    if ([model.zhuangtai isEqualToString:@"0"]) {
        _zhutLabel.text = [NSString stringWithFormat:@"未配料"];
        _zhutLabel.textColor = [UIColor blueColor];
    }if ([model.zhuangtai isEqualToString:@"1"]) {
        _zhutLabel.text = [NSString stringWithFormat:@"已配料"];
        _zhutLabel.textColor = [UIColor orangeColor];
    }if ([model.zhuangtai isEqualToString:@"2"]) {
        _zhutLabel.text = [NSString stringWithFormat:@"生产中"];
        _zhutLabel.textColor = [UIColor greenColor];
    }if ([model.zhuangtai isEqualToString:@"3"]) {
        _zhutLabel.text = [NSString stringWithFormat:@"已完成"];
    }
}

- (IBAction)renwuClick:(UIButton *)sender {//任务单
    NSLog(@"任务单号");
}
- (IBAction)sgphbClick:(UIButton *)sender {//配比单
    NSLog(@"配比单号");
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
