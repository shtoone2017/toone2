//
//  SGTextView.h
//  textView添加placeHorder属性
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGTextView : UITextView 
@property (nonatomic,copy) NSString * placeholder;
@property (nonatomic,strong) UIColor * placeholderColor;
@end
