

//
//  Exp1View.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp51View.h"
#import "Exp51_Xib_View.h"

@interface Exp51View()
@property (nonatomic,strong) Exp51_Xib_View * xib;
@end

@implementation Exp51View


-(instancetype)init{

    self = [super init]; //oldLaceColor
    if (self) {
        self.backgroundColor = [UIColor snowColor];
        
        Exp51_Xib_View * xib = [[NSBundle mainBundle] loadNibNamed:@"Exp51_Xib_View" owner:nil options:nil][0];
        xib.frame = self.frame;
        [self addSubview:xib];
        self.xib = xib;
        
      
        [self.xib.okButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.cancelButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.usePositionButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.earthworkButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.xib.rwdhText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.xib.jzbwText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [SGAnimationType show:self animation:0];
    }
    return self;
}
-(void)setUseLabel:(NSString *)useLabel{
    self.xib.useLabel.text = useLabel;
}
-(void)click:(UIButton*)sender{
    
    if (sender == self.xib.okButton) {
        if (self.expBlock) {
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
    if (sender == self.xib.usePositionButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeUsePosition,self.xib.usePositionButton,nil);
        }
    }
    if (sender == self.xib.earthworkButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeSJQDText,self.xib.earthworkButton,nil);
        }
    }
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField == self.xib.rwdhText) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeLQText,theTextField.text,nil);
        }
    }else {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeJZBWext,theTextField.text,nil);
        }
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
