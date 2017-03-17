//
//  LQ_SW_Model.h
//  toone
//
//  Created by sg on 2017/3/14.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface LQ_SW_Model : MyModel

@property (nonatomic,copy) NSString* banhezhanminchen ;//app主页显示名称
@property (nonatomic,copy) NSString* bhjCount ;// 暂时不要
@property (nonatomic,copy) NSString* bhzCount ;// 暂时不要
@property (nonatomic,copy) NSString* bsId ;// 标识id
@property (nonatomic,copy) NSString* cblv ;// 初级超标率
@property (nonatomic,copy) NSString* cbpanshu ;// 初级超标盘数
@property (nonatomic,copy) NSString* cczpanshu ;// 初级处置盘数
@property (nonatomic,copy) NSString* czlv ;// 初级处置率
@property (nonatomic,copy) NSString* hcblv ;// 高级超标率
@property (nonatomic,copy) NSString* hcbpanshu ;// 高级超标盘数
@property (nonatomic,copy) NSString* hczlv ;// 高级处置率
@property (nonatomic,copy) NSString* hczpanshu ;// 高级处置盘数
@property (nonatomic,copy) NSString* mcblv ;// 中级超标率
@property (nonatomic,copy) NSString* mcbpanshu ;// 中级超标盘数
@property (nonatomic,copy) NSString* mczlv ;// 中级处置率
@property (nonatomic,copy) NSString* mczpanshu ;// 中级处置盘数
@property (nonatomic,copy) NSString* remark ;// 备注 没用
@property (nonatomic,copy) NSString* totalFangliang ;// 总产量
@property (nonatomic,copy) NSString* totalPanshu ;// 总盘数
@end
