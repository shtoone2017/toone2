//
//  QR_Tool.h
//  toone
//
//  Created by 景晓峰 on 2017/9/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QR_Tool : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;

@end
