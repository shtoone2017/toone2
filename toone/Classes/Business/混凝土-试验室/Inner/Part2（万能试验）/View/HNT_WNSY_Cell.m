
//
//  HNT_YLSY_Cell.m
//  toone
//
//  Created by 十国 on 16/11/30.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_WNSY_Cell.h"
#import "HNT_WNSY_Model.h"

@interface HNT_WNSY_Cell()
@property (weak, nonatomic) IBOutlet UILabel *sgrqLabel;
@property (weak, nonatomic) IBOutlet UILabel *sysbLabel;
@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjbhLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgbwLabel;
@property (weak, nonatomic) IBOutlet UILabel *pzLabel;
@property (weak, nonatomic) IBOutlet UILabel *sylxLabel;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;

@end
@implementation HNT_WNSY_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.container1.transform=CGAffineTransformMakeRotation(M_PI_4);//旋转角度，90度
    self.container2.transform=CGAffineTransformMakeRotation(-M_PI_4);//旋转角度，90度
}
/*
 @property (nonatomic,copy) NSString * SYRQ;
 
 @property (nonatomic,copy) NSString * shebeiname;
 @property (nonatomic,copy) NSString * GCMC;
 @property (nonatomic,copy) NSString * SJBH;
 @property (nonatomic,copy) NSString * SGBW;
 @property (nonatomic,copy) NSString * PZBM;
 @property (nonatomic,copy) NSString * testName;
 ---
 @property (weak, nonatomic) IBOutlet UILabel *sgrqLabel;
 @property (weak, nonatomic) IBOutlet UILabel *sysbLabel;
 @property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
 @property (weak, nonatomic) IBOutlet UILabel *sjbhLabel;
 @property (weak, nonatomic) IBOutlet UILabel *sgbwLabel;
 @property (weak, nonatomic) IBOutlet UILabel *pzLabel;
 @property (weak, nonatomic) IBOutlet UILabel *sylxLabel;
 */
-(void)setModel:(HNT_WNSY_Model *)model{
    self.sgrqLabel.text = model.SYRQ;
    self.sysbLabel.text = model.banhezhanminchen;
    self.gcmcLabel.text = model.WTBH;
    self.sjbhLabel.text = model.SJBH;
    self.sgbwLabel.text = model.CJMC;
    self.pzLabel.text = model.PZBM;
    self.sylxLabel.text = model.testname;
    
    self.container1_label.text = model.PDJG;
    if(EqualToString(model.PDJG, @"不合格")){
        self.container1_label.backgroundColor = [UIColor salmonColor];
    }else if(EqualToString(model.PDJG, @"合格")){
        self.container2.hidden = YES;
        self.container1_label.backgroundColor = [UIColor grassColor];
    }
    
    
    
    if (model.BEIZHU.length > 0) {
        self.container2_label.text = @"已处置";
        self.container2.backgroundColor = [UIColor emeraldColor];
    }else if (model.BEIZHU.length == 0) {
        self.container2_label.text = @"未处置";
        self.container2.backgroundColor = [UIColor bananaColor];
    }
}
@end
