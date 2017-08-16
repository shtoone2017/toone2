//
//  GCB_JC_Model.h
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface GCB_JC_Model : MyModel
@property (nonatomic,copy)NSString *cailiaoName;//材料名称
@property (nonatomic,strong) NSNumber *maozhong;//总毛重
@property (nonatomic,strong) NSNumber *jingzhong;//总净重
@property (nonatomic,copy)NSString *ccmin;//出厂最早时间
@property (nonatomic,copy)NSString *pici;//批次
@property (nonatomic,copy)NSString *gongyingshangdanweibianma;//供应商单位编码
@property (nonatomic,copy)NSString *cailiaoNo;//材料名称编号id
@property (nonatomic,copy)NSString *shebeibianhao;//设备编号id
@property (nonatomic,strong) NSNumber *pizhong;//总皮重
@property (nonatomic,copy)NSString *jcmax;//最晚进厂时间
@property (nonatomic,copy)NSString *jinchuliaodanNo;//进出料单编号
@property (nonatomic,copy)NSString *datetype;//统计类型（季度、月、周）
@property (nonatomic,copy)NSString *banhezhanminchen;//地磅名称
@property (nonatomic,copy)NSString *gongyingshangName;//供应商名字
@property (nonatomic,copy)NSString *jcmin;//最早进厂时间
@property (nonatomic,copy)NSString *ccmax;//最晚出厂时间


@end
