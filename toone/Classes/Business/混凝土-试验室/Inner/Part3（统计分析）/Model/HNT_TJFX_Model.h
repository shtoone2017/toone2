//
//  HNT_TJFX_Model.h
//  toone
//
//  Created by 十国 on 16/12/8.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_TJFX_Model : MyModel

@property (nonatomic,copy) NSString * notqualifiedCount ;//  不合格试验
@property (nonatomic,copy) NSString * qualifiedCount ;//   合格试验数
@property (nonatomic,copy) NSString * qualifiedPer ;//   合格率
@property (nonatomic,copy) NSString * testCount ;//   总共进行的试验数
@property (nonatomic,copy) NSString * testName ;//   试验名称
@property (nonatomic,copy) NSString * testType ;//   试验类型
@property (nonatomic,copy) NSString * userGroupId ;//   组织机构id
@property (nonatomic,copy) NSString * validCount ;//   有效的试验数
@end
