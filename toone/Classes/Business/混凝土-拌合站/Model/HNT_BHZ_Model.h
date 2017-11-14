//
//  HNT_bhzModel.h
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyModel.h"

@interface HNT_BHZ_Model : MyModel
//公共属性
@property (nonatomic,copy) NSString * departName; //组织机构名称
@property (nonatomic,copy) NSString * bhjCount;//拌合机总数
@property (nonatomic,copy) NSString * bhzCount;//拌合站总数
@property (nonatomic,copy) NSString * totalFangliang;//拌合机总数
@property (nonatomic,copy) NSString * totalPanshu;//拌合站总数
//@property (nonatomic,assign) CGFloat headerHeight;
//私有属性
//初级
@property (nonatomic,copy) NSString * cbpanshu;//超标盘数
@property (nonatomic,copy) NSString * cblv;//超标率
@property (nonatomic,copy) NSString * cczpanshu;//处置盘数
@property (nonatomic,copy) NSString * czlv;//处置率

//中级
@property (nonatomic,copy) NSString * mcbpanshu;//超标盘数
@property (nonatomic,copy) NSString * mcblv;//超标率
@property (nonatomic,copy) NSString * mczpanshu;//处置盘数
@property (nonatomic,copy) NSString * mczlv;//处置率

//高级
@property (nonatomic,copy) NSString * hcbpanshu;//超标盘数
@property (nonatomic,copy) NSString * hcblv;//超标率
@property (nonatomic,copy) NSString * hczpanshu;//处置盘数
@property (nonatomic,copy) NSString * hczlv;//处置率
//----
@property (nonatomic,copy) NSString * departId;  //组织机构id
@property (nonatomic, copy) NSString *bsId;

/*

 剩余属性

 departId true string 组织机构id
 departName true string 组织机构名称

 totalFangliang true string 总方量
 totalPanshu true string 总盘数
 */




-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)modelWithDict:(NSDictionary*)dict;
@end
