//
//  Exp1View.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^ExpBlock_t) (ExpButtonType,id,id);

@interface ExpYS1View : UIView
@property (nonatomic,copy) ExpBlock_t expBlock;
@property (nonatomic,copy)NSString *sbLabel;//
-(void)setLabel1:(NSString *)lxLabel Label2:(NSString *)startLabel Label3:(NSString *)endLabel;//成果


@end
