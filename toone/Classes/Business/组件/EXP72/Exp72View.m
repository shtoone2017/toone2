

//
//  Exp1View.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp72View.h"
#import "Exp72_Xib_View.h"

@interface Exp72View()
@property (nonatomic,strong) Exp72_Xib_View * xib;
@end

@implementation Exp72View


-(instancetype)init{

    self = [super init]; //oldLaceColor
    if (self) {
        self.backgroundColor = [UIColor snowColor];
        
        Exp72_Xib_View * xib = [[NSBundle mainBundle] loadNibNamed:@"Exp72_Xib_View" owner:nil options:nil][0];
        xib.frame = self.frame;
        [self addSubview:xib];
        self.xib = xib;
        [self.xib.okButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.cancelButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
        [self.xib.rwdhText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [SGAnimationType show:self animation:0];
    }
    return self;
}
-(void)click:(UIButton*)sender{
    if (sender == self.xib.okButton) {
        if (self.expBlock) {
            //保存时间
            [[UserDefaultsSetting shareSetting] saveToSandbox];
            _expBlock(ExpButtonTypeOk,nil,nil);
        }
        [self remove];
    }
    if (sender == self.xib.cancelButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeCancel,nil,nil);
        }
        [self remove];
    }
}
-(void)textFieldDidChange :(UITextField *)theTextField{
//    NSLog( @"text changed: %@", theTextField.text);
    if (self.expBlock) {
        _expBlock(ExpButtonTypeRwdText,theTextField.text,nil);
    }
}

-(void)remove{
     [SGAnimationType remove:self animation:AnimationBottomTop completion:^{
         self.expBlock = nil;
         self.xib = nil;
     }];
}

-(void)dealloc{
    FuncLog;
}
@end
