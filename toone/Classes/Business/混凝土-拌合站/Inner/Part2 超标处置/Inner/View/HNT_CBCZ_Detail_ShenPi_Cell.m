//
//  HNT_CBCZ_Detail_ShenPi_Cell.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Detail_ShenPi_Cell.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
@interface HNT_CBCZ_Detail_ShenPi_Cell()
@property (nonatomic,weak) IBOutlet UILabel  * shenpiren ;//  审批：审批人

@property (nonatomic,weak) IBOutlet UILabel  * jianliresult ;//  审批：监理结果
@property (nonatomic,weak) IBOutlet UILabel  * jianlishenpi ;//  审批：监理审批
@property (nonatomic,weak) IBOutlet UILabel  * confirmdate ;//  审批：确认时间
@property (nonatomic,weak) IBOutlet UILabel  * shenpidate ;//  审批：审批时间

@end
@implementation HNT_CBCZ_Detail_ShenPi_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setHeadMsg:(HNT_CBCZ_Detail_HeadMsg *)headMsg{
    _headMsg = headMsg;
    self.shenpiren.text = headMsg.shenpiren;//  审批：审批人
    self.jianliresult.text = headMsg.jianliresult ;//  审批：监理结果
    self.jianlishenpi.text = headMsg.jianlishenpi ;//  审批：监理审批
    self.confirmdate.text = headMsg.confirmdate ;//  审批：确认时间
    self.shenpidate.text = headMsg.shenpidate ;//  审批：审批时间
}
@end
