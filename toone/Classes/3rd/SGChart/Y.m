//
//  Y.m
//  afafaadafaaf
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "Y.h"
#import "SGConst.h"

@interface Y()
@property (nonatomic,retain) NSMutableArray * viewsArray;
@property (nonatomic,copy) NSString * key;
@end

@implementation Y
-(instancetype)initWithFrame:(CGRect)frame
                       datas:(NSArray*)datas
                    position:(NSString*)key{
    
    _key = key;
    self = [super initWithFrame:frame];
    if (self) {
        [self views:[self runMax_Min:datas]];
    }
    return self;
}
-(void)views:(NSArray*)textArray{
    _viewsArray = [NSMutableArray array];
    CGFloat height = self.frame.size.height/(Y_count-1);
    CGFloat width  = self.frame.size.width;
    if ([_key isEqualToString:@"left"]){
        for (int i = 0; i<Y_count; ++i) {
            UILabel * label = [[UILabel alloc] init];
            label.frame     = CGRectMake(2, -height/2 + height*i, width-10, height);
            label.text      = textArray[textArray.count-i-1];
            label.font      = [UIFont systemFontOfSize:10.0f];
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentRight;
            [self addSubview:label];
            
            UIView * line        = [[UIView alloc] initWithFrame:CGRectMake(width-2, CGRectGetMidY(label.frame)-0.5, 2, 1)];
            line.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:line];
            [_viewsArray addObject:label];
        }
    }
    if ([_key isEqualToString:@"right"]){
        for (int i = 0; i<Y_count; ++i) {
            UILabel * label     = [[UILabel alloc] init];
            label.frame         = CGRectMake(8, -height/2 + height*i, width-10, height);
            label.text          = textArray[textArray.count-i-1];
            label.font          = [UIFont systemFontOfSize:10.0f];
            label.textColor     = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentLeft;
            [self addSubview:label];
            
            UIView * line        = [[UIView alloc] initWithFrame:CGRectMake(1, CGRectGetMidY(label.frame)-0.5, 2, 1)];
            line.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:line];
            [_viewsArray addObject:label];
        }
    }
}
-(NSArray *)runMax_Min:(NSArray*)datas{
    CGFloat max     = 0.00;
    CGFloat min     = 0.00;
    CGFloat max_min = 0.00;
    for (id num in datas) {
        if ([num isKindOfClass:[NSArray class]]) {
            for (id num_2 in num) {
                NSString * num_str = [NSString stringWithFormat:@"%@",num_2];
                CGFloat  num_float = [num_str floatValue];
                if (num_float > max) {
                    max = num_float;
                }
                if (num_float < min) {
                    min = num_float;
                }
                max_min = max - min;
            }
        }else{
            NSString * num_str = [NSString stringWithFormat:@"%@",num];
            CGFloat  num_float = [num_str floatValue];
            if (num_float > max) {
                max = num_float;
            }
            if (num_float < min) {
                min = num_float;
            }
            max_min = max - min;
        }
    }
    
    //
    NSMutableArray * TextArray = [NSMutableArray array];
    if ([_key isEqualToString:@"left"]) {
        for (int i = 0; i<Y_count; ++i) {
            CGFloat text = i*max/(Y_count-1);
            NSString * text_str = [NSString stringWithFormat:@"%.1f",text];
            [TextArray addObject:text_str];
        }
       
    }
    if ([_key isEqualToString:@"right"]) {
        for (int i = 0; i<Y_count; ++i) {
            CGFloat text = i*max_min/(Y_count-1) + min;
            NSString * text_str = [NSString stringWithFormat:@"%.1f%%",text];
            [TextArray addObject:text_str];
        }
    }
    return TextArray;
}

-(void)setDatas:(NSArray *)datas{
   NSArray * textArray = [self runMax_Min:datas];
    int i = 0;
    for (UILabel * label in _viewsArray) {
        ++i;
        label.text = textArray[textArray.count-i];
    }
}
@end
