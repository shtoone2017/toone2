

//
//  Exp1View.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp1View.h"
#import "Exp1_Xib_View.h"

@interface Exp1View()
@property (nonatomic,strong) Exp1_Xib_View * xib;
@end

@implementation Exp1View

/*
 // Whites
 + (instancetype)antiqueWhiteColor;
 + (instancetype)oldLaceColor;
 + (instancetype)ivoryColor;
 + (instancetype)seashellColor;
 + (instancetype)ghostWhiteColor;
 + (instancetype)snowColor;
 + (instancetype)linenColor;
 */
-(instancetype)init{

    self = [super init]; //oldLaceColor
    if (self) {
        self.backgroundColor = [UIColor snowColor];
        
        Exp1_Xib_View * xib = [[NSBundle mainBundle] loadNibNamed:@"Exp1_Xib_View" owner:nil options:nil][0];
        xib.frame = self.frame;
        [self addSubview:xib];
        self.xib = xib;
        
        [self.xib.startTimeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.endTimeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.okButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.cancelButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [SGAnimationType show:self animation:0];
    }
    return self;
}
-(void)click:(UIButton*)sender{
    if (sender == self.xib.startTimeButton) {
        if (self.expBlock) {
            self.expBlock(ExpButtonTypeStartTimeButton,self.xib.startTimeButton,nil);
        }
    }
    if (sender == self.xib.endTimeButton) {
        if (self.expBlock) {
            self.expBlock(ExpButtonTypeEndTimeButton,self.xib.endTimeButton,nil);
        }
    }
    if (sender == self.xib.okButton) {
        if (self.expBlock) {
            //保存时间
            [UserDefaultsSetting shareSetting].startTime = self.xib.startTimeButton.currentTitle;
            [UserDefaultsSetting shareSetting].endTime = self.xib.endTimeButton.currentTitle;
            [[UserDefaultsSetting shareSetting] saveToSandbox];
            //执行回调
            self.expBlock(ExpButtonTypeOk,self.xib.startTimeButton.currentTitle,self.xib.endTimeButton.currentTitle);
        }
        [self remove];
    }
    if (sender == self.xib.cancelButton) {
        if (self.expBlock) {

            self.expBlock(ExpButtonTypeCancel,nil,nil);
        }
        [self remove];
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
