//
//  HNT_bhzCell.m
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_BHZ_Cell.H"

#import "HNT_BHZ_Model.H"
@interface HNT_BHZ_Cell()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *departNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bhzCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bhjCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalFangliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPanshuLabel;


//初级
@property (weak, nonatomic) IBOutlet UILabel *cbpanshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *cblvLabel;
@property (weak, nonatomic) IBOutlet UILabel *cczpanshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *czlvLabel;

//中级
@property (nonatomic,weak)IBOutlet UILabel * mcbpanshuLabel;//超标盘数
@property (nonatomic,weak)IBOutlet UILabel * mcblvLabel;//超标率
@property (nonatomic,weak)IBOutlet UILabel * mczpanshuLabel;//处置盘数
@property (nonatomic,weak)IBOutlet UILabel * mczlvLabel;//处置率

//高级
@property (nonatomic,weak)IBOutlet UILabel * hcbpanshuLabel;//超标盘数
@property (nonatomic,weak)IBOutlet UILabel * hcblvLabel;//超标率
@property (nonatomic,weak)IBOutlet UILabel * hczpanshuLabel;//处置盘数
@property (nonatomic,weak)IBOutlet UILabel * hczlvLabel;//处置率

@end
@implementation HNT_BHZ_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code  snowColor
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.masksToBounds=NO;
//    self.containerView.layer.cornerRadius =3.0;
//    self.containerView.layer.shadowOpacity=1.0;
//    self.containerView.layer.shadowOffset=CGSizeMake(1,1);
//    self.containerView.layer.shadowRadius= 2;
    self.containerView.layer.shadowColor=[UIColor whiteColor].CGColor;
    
    self.bhzCountLabel.layer.masksToBounds = YES;
    self.bhjCountLabel.layer.masksToBounds = YES;
    self.bhzCountLabel.layer.cornerRadius = 10;
    self.bhjCountLabel.layer.cornerRadius = 10;
    self.bhzCountLabel.backgroundColor = [UIColor robinEggColor];
    self.bhjCountLabel.backgroundColor = [UIColor turquoiseColor];
    
}
//// Greens
//+ (instancetype)emeraldColor;
//+ (instancetype)grassColor;
//+ (instancetype)pastelGreenColor;
//+ (instancetype)seafoamColor;
//+ (instancetype)paleGreenColor;
//+ (instancetype)cactusGreenColor;
//+ (instancetype)chartreuseColor;
//+ (instancetype)hollyGreenColor;
//+ (instancetype)oliveColor;
//+ (instancetype)oliveDrabColor;
//+ (instancetype)moneyGreenColor;
//+ (instancetype)honeydewColor;
//+ (instancetype)limeColor;
//+ (instancetype)cardTableColor;
//
//// Yellows
//+ (instancetype)goldenrodColor;
//+ (instancetype)yellowGreenColor;
//+ (instancetype)bananaColor;
//+ (instancetype)mustardColor;
//+ (instancetype)buttermilkColor;
//+ (instancetype)goldColor;
//+ (instancetype)creamColor;
//+ (instancetype)lightCreamColor;
//+ (instancetype)wheatColor;
//+ (instancetype)beigeColor;
//
//// Reds
//+ (instancetype)salmonColor;
//+ (instancetype)brickRedColor;
//+ (instancetype)easterPinkColor;
//+ (instancetype)grapefruitColor;
//+ (instancetype)pinkColor;
//+ (instancetype)indianRedColor;
//+ (instancetype)strawberryColor;
//+ (instancetype)coralColor;
//+ (instancetype)maroonColor;
//+ (instancetype)watermelonColor;
//+ (instancetype)tomatoColor;
//+ (instancetype)pinkLipstickColor;
//+ (instancetype)paleRoseColor;
//+ (instancetype)crimsonColor;


-(void)setModel:(HNT_BHZ_Model *)model{

    self.departNameLabel.text = model.departName;
    self.bhzCountLabel.text = model.bhzCount;
    self.bhjCountLabel.text = model.bhjCount;
    self.totalFangliangLabel.text = model.totalFangliang;
    self.totalPanshuLabel.text = model.totalPanshu;
    //初级
    self.cbpanshuLabel.text = model.cbpanshu;
    self.cblvLabel.text = model.cblv;
    self.cczpanshuLabel.text = model.cczpanshu;
    self.czlvLabel.text = model.czlv;
    //中级
    self.mcbpanshuLabel.text = model.mcbpanshu;
    self.mcblvLabel.text = model.mcblv;
    self.mczpanshuLabel.text = model.mczpanshu;
    self.mczlvLabel.text = model.mczlv;
    //高级
    self.hcbpanshuLabel.text = model.hcbpanshu;
    self.hcblvLabel.text = model.hcblv;
    self.hczpanshuLabel.text = model.hczpanshu;
    self.hczlvLabel.text = model.hczlv;
}
@end
