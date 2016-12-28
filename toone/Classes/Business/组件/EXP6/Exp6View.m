

//
//  Exp1View.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp6View.h"
#import "Exp6_Xib_View.h"

#define LIGHTCOLOR              SGCOLOR(225, 224, 224, 1.0)
#define LIGHTRED                SGCOLOR(250, 105, 107, 1.0)
@interface Exp6View()
@property (nonatomic,strong) Exp6_Xib_View * xib;
@property (nonatomic,assign) int buttonTag;
@end

@implementation Exp6View


-(instancetype)init{

    self = [super init]; //oldLaceColor
    if (self) {
        self.backgroundColor = [UIColor snowColor];
        
        Exp6_Xib_View * xib = [[NSBundle mainBundle] loadNibNamed:@"Exp6_Xib_View" owner:nil options:nil][0];
        xib.frame = self.frame;
        [self addSubview:xib];
        self.xib = xib;
        
        [self.xib.startTimeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.endTimeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.okButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.cancelButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.sbButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [SGAnimationType show:self animation:0];
        
        //*********
        for (UIButton * bt in self.xib.buttons) {
            [bt addTarget:self action:@selector(xibButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
-(void)xibButtonClick:(UIButton*)sender{
    [self.xib shapeWithTag:(int)sender.tag];
    self.buttonTag = (int)sender.tag;
}


-(void)click:(UIButton*)sender{
    if (sender == self.xib.startTimeButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeStartTimeButton,self.xib.startTimeButton,nil,0);
        }
    }
    if (sender == self.xib.endTimeButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeEndTimeButton,self.xib.endTimeButton,nil,0);
        }
    }
    if (sender == self.xib.okButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeOk,self.xib.startTimeButton.currentTitle,self.xib.endTimeButton.currentTitle,self.buttonTag);
        }
        [self remove];
    }
    if (sender == self.xib.cancelButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeCancel,nil,nil,0);
        }
        [self remove];
    }
    
    if (sender == self.xib.sbButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeChoiceSBButton,self.xib.sbButton,nil,0);
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
