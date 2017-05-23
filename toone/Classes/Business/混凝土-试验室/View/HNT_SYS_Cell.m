//
//  HNT_sysCell.m
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SYS_Cell.h"
#import "HNT_SYS_HeaderView.h"
#import "HNT_SYS_TestView.h"
#import "HNT_SYS_Model.h"
#import "HNT_SYS_FrameModel.h"

#define CELL_WIDTH      self.contentView.frame.size.width
#define CELL_HEIGHT     self.contentView.frame.size.height
#define TEST_COLORS     @[[UIColor lightCreamColor],[UIColor honeydewColor],[UIColor chiliPowderColor],[UIColor pastelBlueColor],[UIColor eggplantColor],[UIColor burntOrangeColor],[UIColor violetColor],[UIColor skyBlueColor],[UIColor coolGrayColor],[UIColor antiqueWhiteColor]]
@interface HNT_SYS_Cell()
@property (nonatomic,strong) UIView * containerView;
@property (nonatomic,strong) HNT_SYS_HeaderView * headerView;
@end

@implementation HNT_SYS_Cell
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
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *containerView = [[UIView alloc] init];
        containerView.backgroundColor = [UIColor whiteColor];
//        containerView.layer.masksToBounds=NO;
//        containerView.layer.cornerRadius =3.0;
//        containerView.layer.shadowOpacity=1.0;
//        containerView.layer.shadowOffset=CGSizeMake(1,1);
//        containerView.layer.shadowRadius= 2;
//        containerView.layer.shadowColor=[UIColor oldLaceColor].CGColor;
        [self.contentView addSubview:containerView];
        self.containerView = containerView;
        
        HNT_SYS_HeaderView * headerView  = [[NSBundle mainBundle] loadNibNamed:@"HNT_SYS_HeaderView" owner:nil options:nil][0];
        [self.containerView addSubview:headerView];
        self.headerView = headerView;
    }
    return self;
}

-(void)setFrameModel:(HNT_SYS_FrameModel *)frameModel{
    self.containerView.frame = CGRectMake(0, 0, CELL_WIDTH, CELL_HEIGHT);
    self.headerView.frame = CGRectMake(2,10,self.containerView.frame.size.width-4,44);

    for (UIView * subView in self.containerView.subviews) {
        if ([subView isKindOfClass:[HNT_SYS_TestView class]]) {
            [subView removeFromSuperview];
            [subView.layer removeFromSuperlayer];
        }
    }
    
    int index = 0;
    for (HNT_SYS_Model * model in frameModel.models) {
        HNT_SYS_TestView * testView  = [[NSBundle mainBundle] loadNibNamed:@"HNT_SYS_TestView" owner:nil options:nil][0];
        testView.frame = CGRectMake(2, CGRectGetMaxY(self.headerView.frame)+index*20, self.containerView.frame.size.width-4, 20);
        [self.containerView addSubview:testView];
        
        testView.text0 = model.testName;
        testView.text1 = model.testCount;
        testView.text2 = model.notQualifiedCount;
        testView.text3 = model.realCount;
        testView.text4 = FormatString(model.realPer, @"%");
        
        if (index == 0) {
            self.headerView.text0 =  model.departName;
            self.headerView.text1 =  model.sysCount;
            self.headerView.text2 =  model.syjCount;
        }
        
//        if (TEST_COLORS.count > index) {
//            testView.backgroundColor = TEST_COLORS[index];
//        }
        index++;
    }
    

}

@end
/*
 //公共属性
 @property (nonatomic,copy) NSString * departName; //组织机构名称
 @property (nonatomic,copy) NSString * sysCount;//试验室总数
 @property (nonatomic,copy) NSString * syjCount;//试验机器总数
 
 //私有属性
 @property (nonatomic,copy) NSString * testName;//试验名称
 @property (nonatomic,copy) NSString * testCount;//试验总数
 @property (nonatomic,copy) NSString * notQualifiedCount;//不合格总数
 @property (nonatomic,copy) NSString * realCount;//处置总数
 @property (nonatomic,copy) NSString * realPer;//处置率
 */
