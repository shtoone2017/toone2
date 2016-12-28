//
//  HNT_sysFrameModel.m
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SYS_FrameModel.h"


@implementation HNT_SYS_FrameModel


-(CGFloat)cellHeight{
    /*
     container上下左右边距=5；-------------->5
     组织机构名称departName高度=20，上边距container=5,底线line1上距departName=2；----------->27
     试验类型高度=20 ,底线line2上距testName=2 ------>22
     */
    
    /*
     试验名称高度 = 20 * ?
     */
    return 5*2+27+22 + self.models.count*20+2;
}
@end
