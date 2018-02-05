
//
//  MySJView.m
//  toone
//
//  Created by 十国 on 2016/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MySJView.h"
#import "MySJxib.h"
@interface MySJView()
@property (nonatomic,strong) MySJxib * xib;

@property (nonatomic,strong) UIButton * back;
@end


@implementation MySJView


-(instancetype)init{
    self = [super init];
    self.frame = CGRectMake(0, 0, 240, 350);;
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    if (self) {
    
        UIButton * back = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        back.backgroundColor = [UIColor blackColor];
        back.alpha = 0.3;

        self.back = back;
        
        
        MySJxib * xib = [[NSBundle mainBundle] loadNibNamed:@"MySJxib" owner:nil options:nil][0];
        xib.frame = CGRectMake(0, 0, 240, 350);
        [self addSubview:xib];
       
        self.xib = xib;
    
        [self.xib.cancelButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.xib.okButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:back];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)click:(UIButton *)sender {
    NSDate *select = [self.xib.picker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (_isDetailSecond == YES)
    {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    }
    else
    {
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    NSString *dateAndTime =  [dateFormatter stringFromDate:select];
    if (sender == self.xib.cancelButton) {
        if (self.callBack) {
            self.callBack(SJCancelClick,nil);
        }
    }
    if (sender == self.xib.okButton) {
        if (self.callBack) {
            self.callBack(SJOkClick,dateAndTime);
        }
    }
    
    [self.back removeFromSuperview];
    self.back = nil;
    [self removeFromSuperview];
    self.callBack = nil;
}
@end
