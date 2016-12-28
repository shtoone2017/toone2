//
//  Exp3View.h
//  toone
//
//  Created by 十国 on 16/12/1.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^exp3ViewBlock_t) (NSString*,NSString*);
@interface Exp3View : UIView
@property (nonatomic,copy) exp3ViewBlock_t exp3ViewBlock;


/*
 实验室 设备
 */
-(instancetype)initWithSBJson:(id)json frame:(CGRect)frame ;


@end
