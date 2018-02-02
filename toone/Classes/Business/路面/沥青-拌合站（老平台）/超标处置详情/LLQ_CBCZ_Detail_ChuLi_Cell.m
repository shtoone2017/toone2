//
//  HNT_CBCZ_Detail_ChuLi_Cell2.m
//  toone
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_CBCZ_Detail_ChuLi_Cell.h"
#import "LLQ_CBCZ_Detail_lqjg.h"
#import "UIImageView+WebCache.h"
@interface LLQ_CBCZ_Detail_ChuLi_Cell()
@property (nonatomic,weak) IBOutlet UILabel  * lb1 ;//  处理人：
@property (nonatomic,weak) IBOutlet UILabel  * lb2 ;//  处理时间：
@property (nonatomic,weak) IBOutlet UILabel  * lb3 ;//  处理原因：
@property (nonatomic,weak) IBOutlet UILabel  * lb4 ;//  处理方式：
@property (nonatomic,weak) IBOutlet UILabel  * lb5 ;//  处理结果：

@property (nonatomic,weak) IBOutlet UIImageView  * imgv ;//  处置：

@property (nonatomic,strong) UIImage * filePathImage;
@end
@implementation LLQ_CBCZ_Detail_ChuLi_Cell


-(void)setModel:(LLQ_CBCZ_Detail_lqjg *)model{
    _model = model;
    self.lb1.text = model.chuzhiren;
    self.lb2.text = model.chuzhishijian;
    self.lb3.text = model.chaobiaoyuanyin;
    self.lb4.text = model.chulifangshi;
    self.lb5.text = model.chuzhijieguo;

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
    NSString * urlString = FormatString(baseUrl, model.filePath);
    NSURL * url = [NSURL URLWithString:urlString];
    [self.imgv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading.jgeg"] options:SDWebImageProgressiveDownload];
}
@end
