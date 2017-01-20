//
//  SGPie.h
//  CAlayer
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGPieChart : UIView



/**
*  用于修改数据源
*/
@property (nonatomic,assign) CGFloat percent;


-(instancetype)initWithFrame:(CGRect)frame
                     percent:(CGFloat)percent
                       color:(UIColor*)color;



@end
