//
//  HNT_CBCZ_Detail_ChuLi_Cell2.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Detail_ChuLi_Cell2.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
#import "UIImageView+WebCache.h"
@interface HNT_CBCZ_Detail_ChuLi_Cell2()
@property (nonatomic,weak) IBOutlet UILabel  * chuliren ;//  处置：处理人
@property (nonatomic,weak) IBOutlet UILabel  * chulishijian ;//  处置：处理时间
@property (nonatomic,weak) IBOutlet UILabel  * wentiyuanyin ;//  处置：处置原因
@property (nonatomic,weak) IBOutlet UILabel  * chulifangshi ;//  处置：处理方式
@property (nonatomic,weak) IBOutlet UILabel  * chulijieguo ;//  处置：处理结果
@property (nonatomic,weak) IBOutlet UIImageView  * filePath ;//  处置：

@property (nonatomic,strong) UIImage * filePathImage;
@end
@implementation HNT_CBCZ_Detail_ChuLi_Cell2

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
    

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        if (self.filePathImage == nil) {
//            NSString * urlString = FormatString(baseUrl, headMsg.filePath);
//            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//            self.filePathImage = [UIImage imageWithData:data];
//        }
//        //
//        if (self.filePathImage) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.filePath.image = self.filePathImage;
//            });
//        }
//    });
    
    NSString * urlString = FormatString(baseUrl, headMsg.filePath);
    NSURL * url = [NSURL URLWithString:urlString];
    [self.filePath sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading.jgeg"] options:SDWebImageRetryFailed];
}
@end
