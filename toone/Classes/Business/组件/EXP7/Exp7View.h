//
//  Exp1View.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^Exp7Block_t) (ExpButtonType,id,id,int);

@interface Exp7View : UIView
@property (nonatomic,copy) Exp7Block_t expBlock;
@end
