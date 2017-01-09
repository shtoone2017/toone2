//
//  HNT_CBCZ_Detail_ChuLi_Cell.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Detail_ChuLi_Cell.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
@interface HNT_CBCZ_Detail_ChuLi_Cell()

@property (nonatomic,weak) IBOutlet UILabel  * chuliren ;//  处置：处理人
@property (nonatomic,weak) IBOutlet UILabel  * chulishijian ;//  处置：处理时间
@property (nonatomic,weak) IBOutlet UILabel  * wentiyuanyin ;//  处置：处置原因
@property (nonatomic,weak) IBOutlet UILabel  * chulifangshi ;//  处置：处理方式
@property (nonatomic,weak) IBOutlet UILabel  * chulijieguo ;//  处置：处理结果
@end
@implementation HNT_CBCZ_Detail_ChuLi_Cell

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
    self.chulifangshi.text = headMsg.chulifangshi;//  处置：处理方式
    self.chulijieguo.text = headMsg.chulijieguo;//  处置：处理结果
    self.chuliren.text = headMsg.chuliren;//  处置：处理人
     self.chulishijian.text = headMsg.chulishijian;
     self.wentiyuanyin.text = headMsg.wentiyuanyin;
}
@end
