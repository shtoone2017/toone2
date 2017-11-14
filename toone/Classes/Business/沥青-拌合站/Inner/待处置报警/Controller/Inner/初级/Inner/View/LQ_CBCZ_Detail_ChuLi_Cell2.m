//
//  HNT_CBCZ_Detail_ChuLi_Cell2.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_CBCZ_Detail_ChuLi_Cell2.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
#import "UIImageView+WebCache.h"
@interface LQ_CBCZ_Detail_ChuLi_Cell2()
@property (nonatomic,weak) IBOutlet UILabel  * chuliren ;//  处置：处理人
@property (nonatomic,weak) IBOutlet UILabel  * chulishijian ;//  处置：处理时间
@property (nonatomic,weak) IBOutlet UILabel  * wentiyuanyin ;//  处置：处置原因
@property (nonatomic,weak) IBOutlet UILabel  * chulifangshi ;//  处置：处理方式
@property (nonatomic,weak) IBOutlet UILabel  * chulijieguo ;//  处置：处理结果
@property (nonatomic,weak) IBOutlet UIImageView  * filePath ;//  处置：

@property (nonatomic,strong) UIImage * filePathImage;
@end
@implementation LQ_CBCZ_Detail_ChuLi_Cell2

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setHeadMsg:(HNT_CBCZ_Detail_HeadMsg *)headMsg{
    _headMsg = headMsg;
    self.chulifangshi.text = headMsg.chuzhifangshi;//  处置：处理方式
    self.chulijieguo.text = headMsg.chulijieguo;//  处置：处理结果
    self.chuliren.text = headMsg.chuzhiren;//  处置：处理人
    self.chulishijian.text = headMsg.chuzhishijian;
    self.wentiyuanyin.text = headMsg.chaobiaoyuanyin;
    
    NSString * urlString = FormatString(baseUrl, headMsg.filepath);
    NSURL * url = [NSURL URLWithString:urlString];
    [self.filePath sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading.jgeg"] options:SDWebImageProgressiveDownload];
}
@end
