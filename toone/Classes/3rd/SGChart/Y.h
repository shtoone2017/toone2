//
//  Y.h
//  afafaadafaaf
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Y : UIView


@property (nonatomic,retain) NSArray * datas;
/**
 *   y_leftView  或者  y_rightView
 *   key == @"left"  或者 @"right"
 */
-(instancetype)initWithFrame:(CGRect)frame
                       datas:(NSArray*)datas
                    position:(NSString*)key;
@end
