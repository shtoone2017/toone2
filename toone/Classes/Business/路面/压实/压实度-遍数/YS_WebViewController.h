//
//  YS_WebViewController.h
//  toone
//
//  Created by 景晓峰 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, YS_WebType)
{
    YS_WebTypeYSD = 0,//压实度
    YS_WebTypeBS,//遍数
};
@interface YS_WebViewController : UIViewController
@property (nonatomic,assign) NSInteger type;
@end
