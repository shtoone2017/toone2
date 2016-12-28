//
//  Exp4View.h
//  toone
//
//  Created by 十国 on 16/12/2.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^exp4ViewBlock_t) (NSString*,NSString*);
@interface Exp4View : UIView
@property (nonatomic,copy) exp4ViewBlock_t exp4ViewBlock;

/*
 实验室 试验类型
 */
-(instancetype)initWithTypeJson:(id)json frame:(CGRect)frame ;
@end
