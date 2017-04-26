//
//  TP_CL_Cell.m
//  toone
//
//  Created by 十国 on 2017/4/27.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_CL_Cell.h"

@implementation TP_CL_Cell

-(void)setColor:(UIColor *)color{
    _color = color;
    self.lb1.textColor = color;
    self.lb2.textColor = color;
    self.lb3.textColor = color;
    self.lb4.textColor = color;
    
}
@end
