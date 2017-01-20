//
//  SGChartZBX_X.m
//  afafaadafaaf
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import "SGChartZBX_X.h"
#import "SGLineX.h"
@implementation SGChartZBX_X


/**
 *  重写父类方法
 */
-(void)runAfter{
    super.line = [[SGLineX alloc] initWithFrame:CGRectMake(0, 0, 0, super.sc.frame.size.height)
                                          data:super.datas
                                         title:nil
                                         color:super.color];
    
    [super.sc addSubview:super.line];
    
    if (super.line.sectionWidth * super.datas.count    <   super.sc.frame.size.width) {
        
        super.line.center = CGPointMake(super.sc.frame.size.width/2, super.sc.frame.size.height/2);
    }
}


@end
