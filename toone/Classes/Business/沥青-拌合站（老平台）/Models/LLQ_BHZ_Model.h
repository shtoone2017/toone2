//
//  LQ_SW_Model.h
//  toone
//
//  Created by sg on 2017/3/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LLQ_BHZ_Model : MyModel

@property (nonatomic,copy) NSString* banhezhanminchen ;//  string app主页显示名称
@property (nonatomic,copy) NSString* bhjCount ;//  string 暂时不要
@property (nonatomic,copy) NSString* bhzCount ;//  string 暂时不要
@property (nonatomic,copy) NSString* cblv ;//  string 初级超标率
@property (nonatomic,copy) NSString* cbpanshu ;//  string 初级超标盘数
@property (nonatomic,copy) NSString* cczpanshu ;//  string 初级处置盘数
@property (nonatomic,copy) NSString* czlv ;//  string 初级处置率
@property (nonatomic,copy) NSString* hcblv ;//  string 高级超标率
@property (nonatomic,copy) NSString* hcbpanshu ;//  string 高级超标盘数
@property (nonatomic,copy) NSString* hczlv ;//  string 高级处置率
@property (nonatomic,copy) NSString* hczpanshu ;//  string 高级处置盘数
@property (nonatomic,copy) NSString* mcblv ;//  string 中级超标率
@property (nonatomic,copy) NSString* mcbpanshu ;//  string 中级超标盘数
@property (nonatomic,copy) NSString* mczlv ;//  string 中级处置率
@property (nonatomic,copy) NSString* mczpanshu ;//  string 中级处置盘数
@property (nonatomic,copy) NSString* remark ;//  string 备注 没用
@property (nonatomic,copy) NSString* totalFangliang ;//  string 总产量
@property (nonatomic,copy) NSString* totalPanshu ;//  string 总盘数
@property (nonatomic,copy) NSString* bsId ;//  string 标识id
@end
