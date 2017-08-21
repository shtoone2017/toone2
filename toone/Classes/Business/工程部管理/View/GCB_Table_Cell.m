//
//  GCB_Table_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_Table_Cell.h"
#import "GCB_Model.h"
#import "ZYProGressView.h"

@interface GCB_Table_Cell (){
    ZYProGressView *progress;
}
@property (weak, nonatomic) IBOutlet UILabel *bxLabl;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;//设计
@property (weak, nonatomic) IBOutlet UILabel *ssjLabel;
@property (weak, nonatomic) IBOutlet UILabel *gcLabel;//类型
@property (weak, nonatomic) IBOutlet UILabel *jdLabel;//进度
@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;//工程名称

@property (weak, nonatomic) IBOutlet UIView *jdView;


@end
@implementation GCB_Table_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
//    progress = [[ZYProGressView alloc]initWithFrame:CGRectMake(50, 90, 100, 7)];
    progress = [[ZYProGressView alloc] initWithFrame:CGRectMake(_jdView.frame.origin.x, _jdView.frame.origin.y+8, 100, 7)];
    [self.jdView addSubview:progress];
}

-(void)setModel:(GCB_Model *)model {
    _model = model;
    NSString *jin = [NSString stringWithFormat:@"%@",model.jindu];
    progress.progressValue = [NSString stringWithFormat:@"%.2f",[jin doubleValue]*0.01];
    progress.progressColor = [UIColor orangeColor];
    
    _bxLabl.text = [NSString stringWithFormat:@"%@",model.uesid];
    _sjLabel.text = [NSString stringWithFormat:@"%@",model.shejifangliang];
    _ssjLabel.text = [NSString stringWithFormat:@"%@",model.shijifangliang];
    if ([[model.projectType stringValue] isEqual: @"0"]) {
        _gcLabel.text = [NSString stringWithFormat:@"单位工程"];
    }if ([model.projectType isEqual:@"1"]) {
        _gcLabel.text = [NSString stringWithFormat:@"分部工程"];
    }if ([model.projectType isEqual:@"2"]) {
        _gcLabel.text = [NSString stringWithFormat:@"分项工程"];
    }if ([model.projectType isEqual:@"3"]) {
        _gcLabel.text = [NSString stringWithFormat:@"浇筑部位"];
    }
    _gcmcLabel.text = model.projectName;
    _jdLabel.text = [NSString stringWithFormat:@"工程进度:%@%%",model.jindu];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
