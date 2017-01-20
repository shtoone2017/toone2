//
//  SGBar.m
//  bar自定义
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGBarSuper.h"
#import "SGBar.h"
#import "SGConst.h"


@interface SGBarSuper()
@property (nonatomic,retain) NSArray * titleX;
@property (nonatomic,assign) CGFloat max;
@property (nonatomic,retain) id color;
@property (nonatomic,retain) NSArray * colors;
@property (nonatomic,assign) int sign;
@property (nonatomic,retain) NSArray * datas;
@end
@implementation SGBarSuper


-(CGFloat)sectionWidth{
    if (!_sectionWidth) {
        switch (_sign) {
            case 1:
                _sectionWidth = section_Width;
                break;
            default:
                _sectionWidth =  [_datas[0] count]*bar_Width + ([_datas[0] count]-1)*bar_spaceing + bar_section_spaceing;;
                break;
        }
    }
    return _sectionWidth;
}
-(instancetype)initWithFrame:(CGRect)frame
                        data:(NSArray*)datas
                       title:(NSArray*)titleX
                       color:(id)color{
    _datas  = datas;
    _titleX = titleX;
    _color  = color;
   
    return [self initBarBgview:frame sign:1];
}
-(instancetype)initWithFrame:(CGRect)frame
                       datas:(NSArray*)datas
                      titles:(NSArray*)titleX
                      colors:(NSArray*)colors{
    _datas  = datas;
    _titleX = titleX;
    _colors = colors;

    return [self initBarBgview:frame sign:2];
}
-(instancetype)initBarBgview:(CGRect)frame sign:(int)sign{
    _sign = sign;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w;
    if (_sign == 1) {
        w = _datas.count*section_Width;
    }else{
        long count = [_datas[0] count];
        CGFloat reg_w = count*bar_Width + (count-1)*bar_spaceing + bar_section_spaceing; //区间宽度
        w = _datas.count*reg_w;
    }
    CGFloat h = frame.size.height;
    CGRect self_frame = CGRectMake(x, y, w, h);
    self = [super initWithFrame:self_frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self view];
    }
    return self;
}
-(void)view{
    /**
     *  比较数据源 ， 获取最大值
     */
    _max = 0.000001;//防止崩溃
    for (id num in _datas) {
        if ([num isKindOfClass:[NSArray class]]) {
            for (id num_2 in num) {
                NSString * num_str = [NSString stringWithFormat:@"%@",num_2];
                CGFloat  num_float = [num_str floatValue];
                if (num_float > _max) {
                    _max = num_float;
                }
                
            }
        }else{
            NSString * num_str = [NSString stringWithFormat:@"%@",num];
            CGFloat  num_float = [num_str floatValue];
            if (num_float > _max) {
                _max = num_float;
            }
        }
    }
    /*
             bar
     */
    CGFloat x = (section_Width - bar_Width)/2; //第一个bar的x值
    CGFloat y = titleHeader_height;
    CGFloat w = bar_Width;
    CGFloat h = self.frame.size.height - titleX_height - titleHeader_height;
    CGFloat x_space = section_Width;
    CGFloat reg_w = 0.0;
    
    for (int i= 0 ; i<_datas.count; ++i) {
        if (_sign == 1) {
            NSString * max_str = [NSString stringWithFormat:@"%@",_datas[i]];
            CGFloat  max_float = [max_str floatValue];
            CGFloat  percent = max_float/_max;
            
            CGRect   frame = CGRectMake(x+x_space*i, y, w, h);
            UIColor * sgbar_color ;
            if ([_color isKindOfClass:[NSArray class]]) {
                sgbar_color = _color[i];
            }else if ([_color isKindOfClass:[UIColor class]]){
                sgbar_color = _color;
            }else{
                sgbar_color = [UIColor blueColor];
            }
            SGBar * sgbar = [[SGBar alloc] initWithFrame:frame percent:percent color:sgbar_color];
            sgbar.backgroundColor = self.backgroundColor;
            [self addSubview:sgbar];
            
            //添加title
            UILabel * titleLabel =  [self uptitle:percent indexI:i  indexJ:-1];

            titleLabel.textColor = sgbar_color;
            titleLabel.center = CGPointMake(sgbar.frame.size.width/2, h*(1-percent)-titleHeader_height/2);
            [sgbar addSubview:titleLabel];
            titleLabel.hidden = YES;
            [self performSelector:@selector(showTitle:) withObject:titleLabel afterDelay:percent*sgbar.totalTime];
        }else{

            long count = [_datas[0] count];
            reg_w = count*bar_Width + (count-1)*bar_spaceing + bar_section_spaceing; //区间宽度
            for (int j = 0; j<count; ++j) {
                CGFloat x_reg =  reg_w*i+bar_section_spaceing/2+(bar_Width+bar_spaceing)*j;
                CGRect frame = CGRectMake(x_reg, y, w, h);
                
                NSString * reg_str = [NSString stringWithFormat:@"%@",_datas[i][j]];
                CGFloat  reg_float = [reg_str floatValue];
                CGFloat  reg_percent = reg_float/_max;
                
                
                UIColor * sgbar_color = _colors? _colors[j] : [UIColor blueColor];
                SGBar * sgbar = [[SGBar alloc] initWithFrame:frame percent:reg_percent color:sgbar_color];
                sgbar.backgroundColor = self.backgroundColor;
                [self addSubview:sgbar];
                
                //添加title
                UILabel * titleLabel =  [self uptitle:reg_percent indexI:i  indexJ:j];
                titleLabel.textColor = sgbar_color;
                titleLabel.center = CGPointMake(sgbar.frame.size.width/2, h*(1-reg_percent)-titleHeader_height/2);
                [sgbar addSubview:titleLabel];
                 titleLabel.hidden = YES;
                [self performSelector:@selector(showTitle:) withObject:titleLabel afterDelay:reg_percent*sgbar.totalTime];
            }
        }
    }

    /**
     *  bar 下面对应的title
     */
    CGFloat  title_x = _sign == 1 ? section_Width : reg_w;
    CGFloat  title_y = self.frame.size.height - titleX_height;
    CGFloat  title_w = _sign == 1 ? section_Width : reg_w;;
    CGFloat  title_h = titleX_height;
    for (int i = 0; i<_datas.count; ++i) {
        
        UILabel * label=[[UILabel alloc] init];
        label.frame = CGRectMake(title_x*i, title_y, title_w, title_h);
        NSString * title = _titleX[i]?:[NSString stringWithFormat:@"%d",i];
        label.text = [NSString stringWithFormat:@"%@",title];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth=YES;
        [self addSubview:label];
    }
}

-(void)showTitle:(UILabel*)lable{
    lable.hidden = NO;
}

-(UILabel*)uptitle:(CGFloat)percent indexI:(int)i indexJ:(int)j{
    /**
     *  bar 上面的值
     */
    CGFloat label_x = 0;
    CGFloat label_y = 0;
    CGFloat label_w = _sign == 1 ? section_Width :(bar_Width+bar_spaceing);
    CGFloat label_h = titleHeader_height;
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(label_x, label_y, label_w, label_h);
    if (j == -1) {
        label.text = [NSString stringWithFormat:@"%@",_datas[i]];
    }else{
        label.text = [NSString stringWithFormat:@"%@",_datas[i][j]];
    }
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth=YES;
    return  label;
}
@end
