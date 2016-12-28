//
//  HNT_sysHeaderView.m
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SYS_HeaderView.h"
@interface HNT_SYS_HeaderView()
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end
@implementation HNT_SYS_HeaderView
/*
 + (instancetype)tealColor;
 + (instancetype)steelBlueColor;
 + (instancetype)robinEggColor;
 + (instancetype)pastelBlueColor;
 + (instancetype)turquoiseColor;
 + (instancetype)skyBlueColor;
 + (instancetype)indigoColor;
 + (instancetype)denimColor;
 + (instancetype)blueberryColor;
 + (instancetype)cornflowerColor;
 + (instancetype)babyBlueColor;
 + (instancetype)midnightBlueColor;
 + (instancetype)fadedBlueColor;
 + (instancetype)icebergColor;
 + (instancetype)waveColor;
 */
-(void)awakeFromNib{
    [super awakeFromNib];
    self.label1.layer.masksToBounds = YES;
    self.label2.layer.masksToBounds = YES;
    self.label1.layer.cornerRadius = 10;
    self.label2.layer.cornerRadius = 10;
    self.label1.backgroundColor = [UIColor robinEggColor];
    self.label2.backgroundColor = [UIColor turquoiseColor];

}

-(void)setText0:(NSString *)text0{
    self.label0.text = text0;
}
-(void)setText1:(NSString *)text1{
    self.label1.text = text1;
}
-(void)setText2:(NSString *)text2{
    self.label2.text = text2;
}

@end
