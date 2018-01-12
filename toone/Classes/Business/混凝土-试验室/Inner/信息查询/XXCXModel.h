//
//  XXCXModel.h
//  toone
//
//  Created by 景晓峰 on 2018/1/12.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface XXCXModel : MyModel
@property (nonatomic,copy) NSString *   qrcode;//二维码值
@property (nonatomic,copy) NSString *   recordTime;//上传时间
@property (nonatomic,copy) NSString *   operator;//上传人

@end
