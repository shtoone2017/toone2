//
//  DrawerHeaderImgv.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "DrawerHeaderImgv.h"

@implementation DrawerHeaderImgv



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self ui:frame];
    }
    return self;
}


-(void)ui:(CGRect)frame{
    self.userInteractionEnabled = YES;
    UIButton * headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(0, 0, 55, 55);
    headerBtn.center = CGPointMake(frame.size.width*0.5, frame.size.height*0.5);
    headerBtn.layer.cornerRadius = 26.5;
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"head_portrait"] forState:UIControlStateNormal];
    [self addSubview:headerBtn];
    self.headerIconBtn = headerBtn;
    
    UILabel * nameLb = [[UILabel alloc] init];
    nameLb.frame = CGRectMake(0, 0, Screen_w, 20);
    nameLb.center = CGPointMake(headerBtn.center.x, CGRectGetMaxY(headerBtn.frame)+20);
    NSString * acount = [UserDefaultsSetting shareSetting].userFullName;
    nameLb.text = [NSString stringWithFormat:@"用户：%@",acount ?acount :@""];
    nameLb.textAlignment = NSTextAlignmentCenter;
    nameLb.font = [UIFont systemFontOfSize:14.0];
    nameLb.textColor = [UIColor whiteColor];
    [self addSubview:nameLb];
    self.nameLabel = nameLb;
    
    UIButton * linker = [UIButton buttonWithType:UIButtonTypeCustom];
    linker.frame = CGRectMake(0, 0, Screen_w, 20);
    linker.center = CGPointMake(headerBtn.center.x, CGRectGetMaxY(nameLb.frame)+20);
    NSString * tell = [UserDefaultsSetting shareSetting].userPhoneNum;
    NSString * linkerTitle = [NSString stringWithFormat:@"电话：%@",tell ?tell :@""];
    linker.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [linker setTitle:linkerTitle forState:UIControlStateNormal];
    [self addSubview:linker];
    self.linkerBtn = linker;
}
-(void)dealloc{
    FuncLog;
}
@end
