

//
//  Exp1View.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "ExpYS1View.h"
#import "ExpYS1_Xib_View.h"

@interface ExpYS1View()
@property (nonatomic,strong) ExpYS1_Xib_View * xib;
@end

@implementation ExpYS1View


-(instancetype)init{

    self = [super init]; //oldLaceColor
    if (self) {
        self.backgroundColor = [UIColor snowColor];
        
        ExpYS1_Xib_View * xib = [[NSBundle mainBundle] loadNibNamed:@"ExpYS1_Xib_View" owner:nil options:nil][0];
        xib.frame = self.frame;
        [self addSubview:xib];
        self.xib = xib;
        
        [self.xib.startTimeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.endTimeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.okButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.cancelButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.sbButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.mcButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [SGAnimationType show:self animation:0];
    }
    return self;
}
-(void)setSbLabel:(NSString *)sbLabel {
    self.xib.sbLabel.text = sbLabel;
}
-(void)setLabel1:(NSString *)lxLabel Label2:(NSString *)startLabel Label3:(NSString *)endLabel {
    self.xib.mcView.hidden = NO;
    self.xib.endLabel.text = startLabel;
    self.xib.sbLabel.text = endLabel;
    self.xib.top.constant = 55;
}

-(void)click:(UIButton*)sender{
    if (sender == self.xib.startTimeButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeStartTimeButton,self.xib.startTimeButton,nil);
        }
    }
    if (sender == self.xib.endTimeButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeEndTimeButton,self.xib.endTimeButton,nil);
        }
    }
    if (sender == self.xib.okButton) {
        if (self.expBlock) {
            //保存时间
//            [UserDefaultsSetting shareSetting].startTime = self.xib.startTimeButton.currentTitle;
//            [UserDefaultsSetting shareSetting].endTime = self.xib.endTimeButton.currentTitle;
//            [[UserDefaultsSetting shareSetting] saveToSandbox];
            //
            _expBlock(ExpButtonTypeOk,self.xib.startTimeButton.currentTitle,self.xib.endTimeButton.currentTitle);
        }
        [self remove];
    }
    if (sender == self.xib.cancelButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeCancel,nil,nil);
        }
        [self remove];
    }
    
    if (sender == self.xib.sbButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeChoiceSBButton,self.xib.sbButton,nil);
        }
    }
    if (sender == self.xib.mcButton) {
        if (self.expBlock) {
            _expBlock(ExpButtonTypeYSMC,self.xib.mcButton,nil);
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
