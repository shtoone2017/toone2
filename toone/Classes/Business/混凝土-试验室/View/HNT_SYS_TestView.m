//
//  HNT_sysTestView.m
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SYS_TestView.h"
@interface HNT_SYS_TestView()
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;



@end
@implementation HNT_SYS_TestView


-(void)awakeFromNib{
    [super awakeFromNib];
     [self.label4 sizeToFit];
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
-(void)setText3:(NSString *)text3{
    self.label3.text = text3;
}
-(void)setText4:(NSString *)text4{
    self.label4.text = text4;
   
}
@end
