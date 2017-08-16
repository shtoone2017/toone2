//
//  MySegmentedControl.m
//  toone
//
//  Created by 十国 on 16/11/29.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MySYSSegmentedControl.h"

@interface MySYSSegmentedControl()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
- (IBAction)buttonClick:(UIButton *)sender;

@end

@implementation MySYSSegmentedControl

-(void)awakeFromNib{
    [super awakeFromNib];
    self.button1.backgroundColor = BLUECOLOR;
    self.button2.backgroundColor = BLUECOLOR;
    self.button3.backgroundColor = BLUECOLOR;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0;
}
-(void)switchToWZ{
    [self.button4 setTitle:@"任务单" forState:UIControlStateNormal];
    [self.button2 setTitle:@"进出磅" forState:UIControlStateNormal];
    [self.button3 setTitle:@"进出耗" forState:UIControlStateNormal];
    [self.button1 setTitle:@"浇筑令" forState:UIControlStateNormal];
}
- (IBAction)buttonClick:(UIButton *)sender {
    self.button1.backgroundColor = BLUECOLOR;
    self.button2.backgroundColor = BLUECOLOR;
    self.button3.backgroundColor = BLUECOLOR;
    self.button4.backgroundColor = BLUECOLOR;
    
    [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (self.segBlock) {
        self.segBlock((int)sender.tag);
    }
}
@end
