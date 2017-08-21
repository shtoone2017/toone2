//
//  Exp1View.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^Exp71Block_t) (ExpButtonType,id,id);

@interface Exp71View : UIView
@property (nonatomic,copy) Exp71Block_t expBlock;
@property (nonatomic,copy) NSString * useLabel;
@property (nonatomic,copy) NSString * sbLabel;
@property (nonatomic,copy) NSString * earthLabel;
@property (nonatomic,copy) NSString * tjlxLabel;//
@property (nonatomic,copy) NSString * cclxLabel;//

@end
