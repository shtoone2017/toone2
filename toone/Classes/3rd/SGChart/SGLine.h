//
//  SGLine.h
//  bar自定义
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *       x轴线的y值 = 0.0
 */



@interface SGLine : UIView

@property (nonatomic,assign) CGFloat sectionWidth;

/**
 *  折线图 ， 支持多维
 *
 *  @param frame
 *  @param datas  数据源
 *  @param titleX x轴方向title
 *  @param color  折线颜色
 *
 *  @return 折线图
 */
-(instancetype)initWithFrame:(CGRect)frame
                        data:(NSArray*)datas
                       title:(NSArray*)titleX
                       color:(id)color;





//------------------------用于子类继承---------------------------
@property (nonatomic,assign) CGFloat max;
@property (nonatomic,retain) NSArray * datas;
@property (nonatomic,retain) NSArray * titleX;
@property (nonatomic,retain) id color;
/**
 *  折线拐点上方的数值
 *
 *  @param percent 计算拐点的坐标
 *  @param i
 *  @param j
 *  @param point
 *  @param time  在折线生成完成后显示拐点上的title，总时间
 */
-(void)uptitle:(CGFloat)percent indexI:(int)i indexJ:(int)j point:(CGPoint)point afterDelay:(CGFloat)time;
-(void)layerWith:(UIBezierPath*)path color:(UIColor*)color count:(long)count;
-(void)showTitle:(UILabel*)lable;
-(void)showPoint:(UIView*)view;
@end
