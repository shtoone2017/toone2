//
//  Exp1_xib_view.m
//  toone
//
//  Created by 十国 on 16/11/25.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp6_Xib_View.h"

#define SGCOLOR(r,g,b,a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define LIGHTCOLOR              SGCOLOR(225, 224, 224, 1.0)
#define LIGHTRED                SGCOLOR(250, 105, 107, 1.0)
@interface Exp6_Xib_View()
@property (weak, nonatomic) IBOutlet UIButton *bt10;
@property (weak, nonatomic) IBOutlet UIButton *bt11;
@property (weak, nonatomic) IBOutlet UIButton *bt12;
@property (weak, nonatomic) IBOutlet UIButton *bt20;
@property (weak, nonatomic) IBOutlet UIButton *bt21;
@property (weak, nonatomic) IBOutlet UIButton *bt22;


@property (nonatomic,strong) NSArray * buttons1;
@property (nonatomic,strong) NSArray * buttons2;
@end
@implementation Exp6_Xib_View


-(void)awakeFromNib{
    [super awakeFromNib];
    self.okButton.layer.cornerRadius = 17;
    [_startTimeButton setTitle:[UserDefaultsSetting shareSetting].startTime forState:UIControlStateNormal];
    _startTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _startTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    [_endTimeButton setTitle:[UserDefaultsSetting shareSetting].endTime forState:UIControlStateNormal];
    _endTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endTimeButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    self.sbButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.sbButton.titleEdgeInsets = UIEdgeInsetsMake(26, 0, 0, 0);
    
    
    
    // 2.0*********
    NSArray * arr = @[self.bt10,self.bt11,self.bt12,self.bt20,self.bt21,self.bt22];
    [UIView views:arr shapeWithStatus:YES withCornerRadius:4 withBorderColor:nil withBorderWidth:0];
    for (UIButton * bt in arr) {
        bt.backgroundColor = LIGHTCOLOR;
        bt.titleLabel.textColor = [UIColor blackColor];
    }
    self.bt10.backgroundColor = LIGHTRED;
    [self.bt10 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.buttons = arr;
    

    // 2.1*********
    self.buttons1 = @[self.bt10,self.bt11,self.bt12];
    self.buttons2 = @[self.bt20,self.bt21,self.bt22];
    for (UIButton * bt in self.buttons2) {
        bt.backgroundColor = LIGHTCOLOR;
        bt.titleLabel.textColor = [UIColor blackColor];
        bt.enabled = NO;
    }

}

-(void)shapeWithTag:(int)buttonTag{
    UIButton * sender = [self viewWithTag:buttonTag];
    if (sender.tag <= 30) {
        for (UIButton * bt in self.buttons1) {
            bt.backgroundColor = LIGHTCOLOR;
            bt.titleLabel.textColor = [UIColor blackColor];
        }
        sender.backgroundColor = LIGHTRED;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (sender.tag == 30) {
            self.bt21.enabled = YES;
            self.bt21.backgroundColor = LIGHTCOLOR;
            [self.bt21 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.bt22.enabled = YES;
            self.bt22.backgroundColor = LIGHTCOLOR;
            [self.bt22 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.bt20.enabled = YES;
            self.bt20.backgroundColor = LIGHTRED;
            [self.bt20 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            self.bt21.enabled = NO;
            self.bt21.backgroundColor = LIGHTCOLOR;
            [self.bt21 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.bt22.enabled = NO;
            self.bt22.backgroundColor = LIGHTCOLOR;
            [self.bt22 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.bt20.enabled = NO;
            self.bt20.backgroundColor = LIGHTCOLOR;
            [self.bt20 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }else{
        for (UIButton * bt in self.buttons2) {
            bt.backgroundColor = LIGHTCOLOR;
            bt.titleLabel.textColor = [UIColor blackColor];
        }
        sender.backgroundColor = LIGHTRED;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}



@end
