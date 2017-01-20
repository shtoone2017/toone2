//
//  SGLineChart.h
//  bar自定义
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGLine.h"
#import "SGConst.h"
#import "SGSign.h"

@interface SGLineChart : UIView

/**
 *  重置数据
 *  datas和titleX需要调用show方法
 */
@property (nonatomic,retain) NSArray * datas;
@property (nonatomic,retain) NSArray * titleX;
/**
 *  右上角的数据类型提示
 */
@property (nonatomic,retain) NSArray * titleTop;




/**
 *  父视图view ，子视图scrollview ， 内容物SGLine
 *
 *  @param frame
 *  @param datas  数据源
 *  @param titleX x轴方向的title
 *  @param color  折线的颜色
 *
 *  @return 折线图
 */
-(instancetype)initWithFrame:(CGRect)frame
                        data:(NSArray*)datas
                       title:(NSArray*)titleX
                       color:(id)color;



/**
 *  用于修改参数以后 ， 重绘
 */
-(void)show;




//-------------------------子类继承用-----------------------------
@property (nonatomic,retain) SGLine * line;
@property (nonatomic,retain) UIScrollView * sc;
@property (nonatomic,retain) id color;
-(void)views;
-(void)remove;
@end
