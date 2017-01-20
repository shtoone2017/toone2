//
//  SGLineChartZBX.h
//  afafaadafaaf
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGLineChart.h"
#import "SGBarSuper.h"

/**
 *      x轴线的y值 = 0.0
 */
@interface SGChartZBX : SGLineChart

@property (nonatomic,retain) NSArray * bar_data;



/**
 *  柱状图与折线图的结合 ， 柱状图只支持一维
 *
 *  @param frame
 *  @param titleX     x轴方向的title
 *  @param line_data  折线图数据源
 *  @param line_color 折线颜色
 *  @param bar_data   柱状图数据源
 *  @param bar_color  柱的颜色，支持单色和不同颜色
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame
                      titleX:(NSArray*)titleX
                   line_data:(NSArray*)line_data
                  line_color:(id)line_color
                    bar_data:(NSArray*)bar_data
                   bar_color:(id)bar_color;



//-------------------------子类继承用-----------------------------
@property (nonatomic,retain) SGBarSuper    * bar;

@end
