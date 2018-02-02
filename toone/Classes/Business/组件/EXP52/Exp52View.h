//
//  Exp1View.h
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^Exp52Block_t) (ExpButtonType,id,id);

@interface Exp52View : UIView
@property (nonatomic,copy) Exp52Block_t expBlock;
@property (nonatomic,copy) NSString * useLabel;
@property (nonatomic,copy) NSString * sbLabel;
@property (nonatomic,copy) NSString * earthLabel;

-(void)hiddEarthView;
@end
