//
//  Exp1View.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^Exp6Block_t) (ExpButtonType,id,id,int);

@interface Exp6View : UIView
@property (nonatomic,copy) Exp6Block_t expBlock;
@end
