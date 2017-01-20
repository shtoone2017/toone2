//
//  SGBarChart.h
//  bar自定义
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGBarChart : UIView

/**
 *  重置数据
 *  datas和titleX需要调用show方法
 */
@property (nonatomic,retain) NSArray * datas;
@property (nonatomic,retain) NSArray * titleX;
@property (nonatomic,retain) NSArray * titleTop;



/**
 *  一维柱状图
 *
 *  @param frame
 *  @param datas    支持一维数组
 *  @param titleX   nil显示下标
 *  @param color    可以是NSArray ， 可以是UIColor  ， 可以是nil==蓝色（默认）
 *
 *  @return 柱状图
 */
-(instancetype)initWithFrame:(CGRect)frame
                        data:(NSArray*)datas
                       title:(NSArray*)titleX
                       color:(id)color;



/**
 *  多维柱状图
 *
 *  @param frame
 *  @param datas    支持多维数组
 *  @param titleX   nil显示下标
 *  @param colors   只能是数组
 *
 *  @return 柱状图
 */
-(instancetype)initWithFrame:(CGRect)frame
                       datas:(NSArray*)datas
                      titles:(NSArray*)titleX
                      colors:(NSArray*)colors;



/**
 *  用于修改参数以后 ， 重绘
 */
-(void)show;
@end
