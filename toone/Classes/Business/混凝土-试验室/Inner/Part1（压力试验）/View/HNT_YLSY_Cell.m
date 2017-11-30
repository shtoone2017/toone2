
//
//  HNT_YLSY_Cell.m
//  toone
//
//  Created by 十国 on 16/11/30.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_YLSY_Cell.h"
#import "HNT_YLSY_Model.h"

@interface HNT_YLSY_Cell()
@property (weak, nonatomic) IBOutlet UILabel *sgrqLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjbhLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjqdLabel;
@property (weak, nonatomic) IBOutlet UILabel *qddbLabel;
@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgbwLabel;
@property (weak, nonatomic) IBOutlet UILabel *sylxLabel;
@property (weak, nonatomic) IBOutlet UILabel *sbmcLabel;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *container1_label;
@property (weak, nonatomic) IBOutlet UILabel *container2_label;

@end
@implementation HNT_YLSY_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.container1.transform=CGAffineTransformMakeRotation(M_PI_4);//旋转角度，90度
    self.container2.transform=CGAffineTransformMakeRotation(-M_PI_4);//旋转角度，90度
}
-(void)setModel:(HNT_YLSY_Model *)model{
    self.sgrqLabel.text = model.SYRQ;
    self.sjbhLabel.text = model.SJBH;
    self.sjqdLabel.text = model.SJQD;
    self.qddbLabel.text = model.QDDBZ;
    self.gcmcLabel.text = model.WTBH;
    self.sgbwLabel.text = model.CJMC;
    self.sylxLabel.text = model.testname;
    self.sbmcLabel.text = model.banhezhanminchen;
    
    self.container1_label.text = model.PDJG;
    if(EqualToString(model.PDJG, @"不合格")){
        self.container1_label.backgroundColor = [UIColor salmonColor];
    }else if(EqualToString(model.PDJG, @"合格")){
        self.container2.hidden = YES;
        self.container1_label.backgroundColor = [UIColor emeraldColor];
    }else if(EqualToString(model.PDJG, @"有效")){
        self.container2.hidden = YES;
        self.container1_label.backgroundColor = [UIColor emeraldColor];
    }else if(EqualToString(model.PDJG, @"无效")){
        self.container1_label.backgroundColor = [UIColor brickRedColor];
    }
    
    
    if (model.BEIZHU.length > 0) {
        self.container2_label.text = @"已处置";
        self.container2.backgroundColor = [UIColor emeraldColor];
    }else if (model.BEIZHU.length == 0) {
        self.container2_label.text = @"未处置";
        self.container2.backgroundColor = [UIColor bananaColor];
    }
    
//    if (EqualToString(model.chuzhi, @"0")) {
//        self.container2_label.text = @"未处置";
//        self.container2.backgroundColor = [UIColor bananaColor];
//    }else if (EqualToString(model.chuzhi, @"1")){
//        self.container2_label.text = @"已处置";
//        self.container2.backgroundColor = [UIColor emeraldColor];
//    }
}
/*
 // Greens
 + (instancetype)emeraldColor;
 + (instancetype)grassColor;
 + (instancetype)pastelGreenColor;
 + (instancetype)seafoamColor;
 + (instancetype)paleGreenColor;
 + (instancetype)cactusGreenColor;
 + (instancetype)chartreuseColor;
 + (instancetype)hollyGreenColor;
 + (instancetype)oliveColor;
 + (instancetype)oliveDrabColor;
 + (instancetype)moneyGreenColor;
 + (instancetype)honeydewColor;
 + (instancetype)limeColor;
 + (instancetype)cardTableColor;
 
 // Reds
 + (instancetype)salmonColor;
 + (instancetype)brickRedColor;
 + (instancetype)easterPinkColor;
 + (instancetype)grapefruitColor;
 + (instancetype)pinkColor;
 + (instancetype)indianRedColor;
 + (instancetype)strawberryColor;
 + (instancetype)coralColor;
 + (instancetype)maroonColor;
 + (instancetype)watermelonColor;
 + (instancetype)tomatoColor;
 + (instancetype)pinkLipstickColor;
 + (instancetype)paleRoseColor;
 + (instancetype)crimsonColor;
 
 // Yellows
 + (instancetype)goldenrodColor;
 + (instancetype)yellowGreenColor;
 + (instancetype)bananaColor;
 + (instancetype)mustardColor;
 + (instancetype)buttermilkColor;
 + (instancetype)goldColor;
 + (instancetype)creamColor;
 + (instancetype)lightCreamColor;
 + (instancetype)wheatColor;
 + (instancetype)beigeColor;
 */


@end
