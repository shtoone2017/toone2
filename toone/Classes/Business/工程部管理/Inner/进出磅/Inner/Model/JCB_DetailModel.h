//
//  JCB_DetailModel.h
//  toone
//
//  Created by 上海同望 on 2017/8/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface JCB_DetailModel : MyModel
@property (nonatomic,copy)NSString *jinchangshijian;//进厂时间
@property (nonatomic,copy)NSString *cailiaoNo;//材料名称id
@property (nonatomic,copy)NSString *qianchepai;//车牌号
@property (nonatomic,copy)NSString *sibangyuan;//司磅员
@property (nonatomic,copy)NSString *guobangleibie;//过磅类别
@property (nonatomic,copy)NSString *cailiaoName;//材料名称
@property (nonatomic,copy)NSString *departid;//部门id
@property (nonatomic,copy)NSString *gongyingshangdanweibianma;//供应商单位编码
@property (nonatomic,copy)NSString *chuchangshijian;//出厂时间
@property (nonatomic,copy)NSString *shebeibianhao;//设备编号
@property (nonatomic,copy)NSString *koulv;//扣率
@property (nonatomic,copy)NSString *banhezhanminchen;//过磅设备
@property (nonatomic,copy)NSString *gongyingshangName;//供应商名字

@property (nonatomic,copy)NSString *remark;//备注
@property (nonatomic,copy)NSString *chengzhongpiancha;//称重偏差
@property (nonatomic,copy)NSString *pici;//批次


@property (nonatomic,copy)NSString *jinchuliaodanNo;//进出料单编号
@property (nonatomic,strong) NSNumber *kouzhong;//扣重
@property (nonatomic,strong) NSNumber *pizhong;//总皮重
@property (nonatomic,strong) NSNumber *maozhong;//总毛重
@property (nonatomic,strong) NSNumber *jingzhong;//总净重

@property (nonatomic,copy)NSString *istype;

@end
