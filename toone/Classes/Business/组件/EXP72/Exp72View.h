//
//  Exp1View.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^Exp72Block_t) (ExpButtonType,id,id);

@interface Exp72View : UIView
@property (nonatomic,copy) Exp72Block_t expBlock;
@property (nonatomic,copy) NSString * useLabel;

@end
