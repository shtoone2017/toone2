//
//  SGLineX.m
//  afafaadafaaf
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGLineX.h"
#import "SGConst.h"

@interface SGLineX()
@property (nonatomic,assign) CGFloat max_min;
@property (nonatomic,assign) CGFloat min;
@end

@implementation SGLineX
-(void)view{
    /**
     * 获取最大值
     */
    super.max = 0.000001;//防止崩溃
//    _min = 1.000001;
    _min = super.max;
    for (id num in super.datas) {
        if ([num isKindOfClass:[NSArray class]]) {
            for (id num_2 in num) {
                NSString * num_str = [NSString stringWithFormat:@"%@",num_2];
                CGFloat  num_float = [num_str floatValue];
                if (num_float > super.max) {
                    super.max = num_float;
                }
                if (num_float < _min) {
                    _min = num_float;
                }
                _max_min = super.max - _min;
            }
        }else{
            NSString * num_str = [NSString stringWithFormat:@"%@",num];
            CGFloat  num_float = [num_str floatValue];
            if (num_float > super.max) {
                super.max = num_float;
            }
            if (num_float < _min) {
                _min = num_float;
            }
            _max_min = super.max - _min;
        }
    }
    
    if ([super.datas[0] isKindOfClass:[NSArray class]]) {
        
        NSMutableArray * big_datas = [NSMutableArray array];
        for (int i = 0; i<((NSArray*)super.datas[0]).count; ++i) {
            NSMutableArray * little_datas = [NSMutableArray array];
            for (int j = 0; j<super.datas.count; ++j) {
                [little_datas addObject:((NSArray*)super.datas[j])[i]];
            }
            [big_datas addObject:little_datas];
        }
        
        super.datas = nil;
        super.datas = big_datas;
        
        for (int i = 0; i<super.datas.count; ++i) {
            UIBezierPath * path = [UIBezierPath bezierPath];
            for (int j = 0 ; j<((NSArray*)super.datas[i]).count-1; ++j) {
                NSString * str1     = [NSString stringWithFormat:@"%@",super.datas[i][j]];
                CGFloat  str1_float = [str1 floatValue];
                CGFloat  percent1   = (str1_float-_min)/_max_min;
                CGFloat  point1_X   = section_Width/2+j*section_Width;
                CGFloat  point1_Y   = (self.frame.size.height - titleHeader_height - titleX_height)*(1-percent1)+titleHeader_height;
                CGPoint point1      = CGPointMake(point1_X, point1_Y);

                NSString * str2     = [NSString stringWithFormat:@"%@",super.datas[i][j+1]];
                CGFloat str2_float  = [str2 floatValue];
                CGFloat percent2    = (str2_float-_min)/_max_min;
                CGFloat point2_X    = section_Width/2+(j+1)*section_Width;
                CGFloat point2_Y    = (self.frame.size.height - titleHeader_height - titleX_height)*(1-percent2)+titleHeader_height;
                CGPoint point2      = CGPointMake(point2_X, point2_Y);
                
                
                [path moveToPoint:point1];
                [path addLineToPoint:point2];
                //添加title
                [self uptitle:percent1 indexI:i indexJ:j point:point1 afterDelay:super.datas.count*LINE_TOTALTIME];
                if (j == ((NSArray*)super.datas[0]).count-2) {
                    [self uptitle:percent2 indexI:i indexJ:j+1 point:point2 afterDelay:super.datas.count*LINE_TOTALTIME];
                }
            }
            UIColor * color ;
            if ([super.color isKindOfClass:[UIColor class]]) {
                color = ((UIColor*)super.color);
            }else if ([super.color isKindOfClass:[NSArray class]]){
                color = ((UIColor*)super.color[i]);
            }
            else{
                color = [UIColor blackColor];
            }
            [self layerWith:path color:color count:super.datas.count];
        }
    }else{
        UIBezierPath * path = [UIBezierPath bezierPath];
        for (int i= 0 ; i<super.datas.count-1; ++i) {
            NSString * startData_str = [NSString stringWithFormat:@"%@",super.datas[i]];
            CGFloat startData_float  = [startData_str floatValue];
            CGFloat startPercent     = startData_float/_max_min;
            CGFloat startPointX      = section_Width/2+i*section_Width;
            CGFloat startPointy      = (self.frame.size.height - titleHeader_height - titleX_height)*(1-startPercent)+titleHeader_height;
            CGPoint startPoint       = CGPointMake(startPointX, startPointy);
            
            
            NSString * endData_str = [NSString stringWithFormat:@"%@",super.datas[i+1]];
            CGFloat endData_float  = [endData_str floatValue];
            CGFloat endPercent     = endData_float/_max_min;
            CGFloat endPointX      = section_Width/2+(i+1)*section_Width;
            CGFloat endPointy      = (self.frame.size.height - titleHeader_height - titleX_height)*(1-endPercent)+titleHeader_height;
            CGPoint endPoint       = CGPointMake(endPointX, endPointy);
            
            
            [path moveToPoint:startPoint];
            [path addLineToPoint:endPoint];
            //添加title
            [self uptitle:startPercent indexI:i indexJ:-1 point:startPoint afterDelay:super.datas.count*LINE_TOTALTIME];
            if (i == super.datas.count - 2) {
                [self uptitle:endPercent indexI:i+1 indexJ:-1 point:endPoint afterDelay:super.datas.count*LINE_TOTALTIME];
            }
        }
        
        /**
         *  只有一个点
         */
        if (super.datas.count == 1) {
            NSString * startData_str = [NSString stringWithFormat:@"%@",super.datas[0]];
            CGFloat startData_float  = [startData_str floatValue];
            CGFloat startPercent     = startData_float/super.max;
            CGFloat startPointX      = section_Width/2;
            CGFloat startPointy      = (self.frame.size.height - titleHeader_height - titleX_height)*(1-startPercent)+titleHeader_height;
            CGPoint startPoint       = CGPointMake(startPointX, startPointy);
            //添加title
            [self uptitle:startPercent indexI:0 indexJ:-1 point:startPoint afterDelay:super.datas.count*LINE_TOTALTIME];
        }
        UIColor * color = super.color&&[super.color isKindOfClass:[UIColor class]] ? super.color : [UIColor blueColor];
        [self layerWith:path color:color count:super.datas.count];
    }
    
    
    /**
     * bar 下面对应的title
     */
    
    CGFloat  title_x = section_Width;
    CGFloat  title_y = self.frame.size.height - titleX_height;
    CGFloat  title_w = section_Width;
    CGFloat  title_h = titleX_height;
    for (int i = 0; i<super.titleX.count; ++i) {
        UILabel * label     = [[UILabel alloc] init];
        label.frame         = CGRectMake(title_x*i, title_y, title_w, title_h);
        NSString * title    = super.titleX[i]?:@"";
        label.text          = title;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}
-(void)uptitle:(CGFloat)percent indexI:(int)i indexJ:(int)j point:(CGPoint)point afterDelay:(CGFloat)time{
    /*
     小点点
     */
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    view.layer.cornerRadius = 2.5;
    view.center = point;
    [self addSubview:view];
    
    /*
     bar 上面的值
     */
    CGFloat label_x  = 0;
    CGFloat label_y  = 0;
    CGFloat label_w  = section_Width;
    CGFloat label_h  = titleHeader_height;
    CGFloat center_x = j == -1 ?section_Width/2+section_Width*i:section_Width/2+section_Width*j;
    CGFloat center_y = titleHeader_height+(1-percent)*(self.frame.size.height-titleHeader_height-titleX_height)-titleHeader_height/2+titleHeader_height;
    UILabel * label  = [[UILabel alloc] init];
    label.frame      = CGRectMake(label_x, label_y, label_w, label_h);
    label.center     = CGPointMake(center_x,center_y);
    if (j == -1) {
        NSString * str = [NSString stringWithFormat:@"%@",super.datas[i]];
        CGFloat      f = [str floatValue];
        label.text     = [NSString stringWithFormat:@"%.2f%%",f];
    }else{
        NSString * str = [NSString stringWithFormat:@"%@",super.datas[i][j]];
        CGFloat      f = [str floatValue];
        label.text     = [NSString stringWithFormat:@"%.2f%%",f];
    }
    
    
    if ([super.color isKindOfClass:[UIColor class]]) {
        label.textColor = super.color;
        view.backgroundColor = super.color;
    }else if ([super.color isKindOfClass:[NSArray class]]){
        label.textColor = (UIColor*)super.color[i];
        view.backgroundColor = (UIColor*)super.color[i];
    }
    else{
        label.textColor = [UIColor blackColor];
        view.backgroundColor = [UIColor blackColor];
    }
    label.font = j==-1 ? [UIFont systemFontOfSize:14.0f]:[UIFont systemFontOfSize:10.0f];
    label.textAlignment = NSTextAlignmentRight;
    label.hidden = YES;
    [self addSubview:label];
    [self performSelector:@selector(showTitle:) withObject:label afterDelay:time];
    
    view.hidden = YES;
    [self performSelector:@selector(showPoint:) withObject:view afterDelay:time];
    
}
@end
