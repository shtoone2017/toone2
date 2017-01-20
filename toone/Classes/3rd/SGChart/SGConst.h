//
//  SGconst.h
//  afafaadafaaf
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 jzs.com. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/**
 *    SGBarChart   图表右上角控件的高度
 */
extern CGFloat const titleTop_height;

/**
 *    SGBarChart   图表右上角控件的宽度
 */
#define titleSign_width       self.frame.size.width/8
extern CGFloat const signTopR_width;
/**
 *    SGBarSuper    SGLine    SGLineX
 */
extern CGFloat const titleHeader_height   ;  //titleTop控件的高度(bar头上的title)
extern CGFloat const titleX_height        ;  //titleX控件高度(X轴title)
extern CGFloat const bar_Width            ;  //bar的宽度
extern CGFloat const section_Width        ;  //bar的区间宽度(仅限于datas是一维数组有效)
extern CGFloat const bar_section_spaceing ;  //不同区间最近两个bar的间距
extern CGFloat const bar_spaceing         ;  //相同区间最近两个bar的间距

/**
 *    SGBar  SGLine
 */
extern CGFloat const BAR_TOTALTIME ;
extern CGFloat const LINE_TOTALTIME ;

/**
 *    SGChartZBX
 */
extern CGFloat const distance ;
extern CGFloat const rightView_Width ;

/**
 *    SGPieChart
 */
extern CGFloat const pie_scale ; //比例

/**
 *    SGSign
 */
extern CGFloat const Sign_LittleView_Width ;
extern CGFloat const Y_count ;     //y轴坐标系几等分
#define Sign_TopView_Right_y     self.frame.size.height*2/5















@interface SGConst : NSObject

@end
