//
//  GCB_JCB_DetailController.h
//  toone
//
//  Created by 上海同望 on 2017/8/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ViewController.h"
typedef NS_ENUM(NSInteger,GCBType) {
    GCBTypeJC = 0,
    GCBTypeCC
};

@interface GCB_JCB_DetailController : ViewController
@property (nonatomic,copy)NSString *jinchuliaodanNo;//进出料单编号
@property (nonatomic,copy)NSString *cailiaoNo;//材料名称编号id
@property (nonatomic,copy)NSString *pici;//批次
@property (nonatomic,copy)NSString *gongyingshangdanweibianma;//供应商单位编码
@property (nonatomic,copy)NSString *shebeibianhao;//设备编号id
@property (nonatomic,copy)NSString *jcmin;//最早进厂时间
@property (nonatomic,copy)NSString *jcmax;//最晚进厂时间
@property (nonatomic,copy)NSString *ccmin;//出厂最早时间
@property (nonatomic,copy)NSString *ccmax;//最晚出厂时间

@property (nonatomic,strong) NSNumber *ccid;//id
@property (nonatomic,copy)NSString *guobangleibie;//过磅类别

@property (nonatomic,assign) NSInteger type;
@end
