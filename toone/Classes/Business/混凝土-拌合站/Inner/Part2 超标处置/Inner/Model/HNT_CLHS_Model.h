//
//  HNT_CLHS_Model.h
//  toone
//
//  Created by 十国 on 2016/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_CLHS_Model : MyModel



@property (nonatomic,copy) NSString * cbGrade ;//  超标等级
@property (nonatomic,copy) NSString * name ;//  材料名称
@property (nonatomic,copy) NSString * shiji ;//  实际值
@property (nonatomic,copy) NSString * peibi ;//  配比值
@property (nonatomic,copy) NSString * wuchazhi ;//  误差值
@property (nonatomic,copy) NSString * wuchalv ;//  误差率

@end
