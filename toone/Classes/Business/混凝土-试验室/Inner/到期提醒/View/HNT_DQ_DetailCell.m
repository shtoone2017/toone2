//
//  HNT_DQ_DetailCell.m
//  toone
//
//  Created by 上海同望 on 2018/1/10.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "HNT_DQ_DetailCell.h"
#import "HNT_DQ_DetailModel.h"

@interface HNT_DQ_DetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *sysLabel;
@property (weak, nonatomic) IBOutlet UILabel *lqLabel;
@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *jzbwLabel;//浇筑部位
@property (weak, nonatomic) IBOutlet UILabel *sjqdLabel;//强度
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//养护时间


@end
@implementation HNT_DQ_DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(HNT_DQ_DetailModel *)model {
    _model = model;
    _sysLabel.text = model.xiangmubuminchen;
    _lqLabel.text = [NSString stringWithFormat:@"%@",model.lq];
    _gcmcLabel.text = model.gcmc;
    _jzbwLabel.text = model.sgbw;
    _sjqdLabel.text = model.sjqd;
    _timeLabel.text = model.endTime;
}

@end
