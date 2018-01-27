//
//  TP_SBDW_Model.h
//  toone
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface TP_SBDW_Model : MyModel
@property(nonatomic,copy) NSNumber* tempRowNumber ;// number
@property(nonatomic,copy) NSNumber* gpsid ;// number 数据id
@property(nonatomic,copy) NSString* donjin ;// string 东经
@property(nonatomic,copy) NSString* dongjinbeiwei ;// string 东经北纬中文转换
@property(nonatomic,copy) NSString* shijian ;// string 时间
@property(nonatomic,copy) NSString* banhezhanminchen ;// string 拌和站名称
@property(nonatomic,copy) NSNumber* tempColumn ;// number
@property(nonatomic,copy) NSString* beiwei ;// string 北纬
@end
