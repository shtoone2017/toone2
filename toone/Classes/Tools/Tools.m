
//
//  Tools.m
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(void)tip:(NSString*)msg{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    label.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 64+15);
    label.text = msg;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor yellowColor];
    label.alpha = 1.0;
    label.textColor = [UIColor redColor];

    
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:3.0f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [label removeFromSuperview];
        });
    });
}

/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
+(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(00, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
+(NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    //得到图片的data
    NSData* data;
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
//    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}
@end
