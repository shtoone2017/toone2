//
//  SGSign.h
//  bar自定义
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGSign : UIView
@property (nonatomic,copy) NSString * title;
@property (nonatomic,retain) UIColor * color;



/**
 *   top_rightView
 */
-(instancetype)initWithFrame:(CGRect)frame;


/**
 *   rightView
 */
//-(instancetype)initWithFrame:(CGRect)frame
//                      colors:(NSArray*)colors
//                      titles:(NSArray*)titles;




@end
