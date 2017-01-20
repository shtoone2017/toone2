//
//  SGBar.h
//  bar自定义
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface SGBarSuper : UIView

@property (nonatomic,assign) CGFloat sectionWidth;

/**
 *  一维柱状图
 *
 *  @param frame
 *  @param datas  数据源
 *  @param titleX x轴方向的title
 *  @param color  柱的颜色
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame
                        data:(NSArray*)datas
                       title:(NSArray*)titleX
                       color:(id)color;

/**
 *  多维柱状图
 *
 *  @param frame
 *  @param datas  数据源
 *  @param titleX x轴方向的title
 *  @param color  柱的颜色
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame
                        datas:(NSArray*)datas
                       titles:(NSArray*)titleX
                       colors:(NSArray*)colors;
@end
