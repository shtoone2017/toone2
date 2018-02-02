//
//  HNT_bhzCell.m
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LQ_SW_Cell.h"
#import "LQ_SW_Model.h"
@interface LQ_SW_Cell()
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
@implementation LQ_SW_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code  snowColor
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.masksToBounds=NO;
    self.containerView.layer.shadowColor=[UIColor whiteColor].CGColor;
    
    self.bhzCountLabel.layer.masksToBounds = YES;
    self.bhjCountLabel.layer.masksToBounds = YES;
    self.bhzCountLabel.layer.cornerRadius = 10;
    self.bhjCountLabel.layer.cornerRadius = 10;
    self.bhzCountLabel.backgroundColor = [UIColor robinEggColor];
    self.bhjCountLabel.backgroundColor = [UIColor turquoiseColor];
    
}

-(void)setModel:(LQ_SW_Model *)model{

//    self.bhzCountLabel.text = model.bhzCount;
//    self.bhjCountLabel.text = model.bhjCount;
    self.departNameLabel.text = model.banhezhanminchen;
    self.totalFangliangLabel.text = [NSString stringWithFormat:@"%@",model.gujifangshu];
    self.totalPanshuLabel.text = [NSString stringWithFormat:@"%@",model.pangshu];
    //初级
    self.cbpanshuLabel.text = [NSString stringWithFormat:@"%@",model.lowcbps];
    self.cblvLabel.text = [NSString stringWithFormat:@"%@",model.lowcbper];
    self.cczpanshuLabel.text = [NSString stringWithFormat:@"%@",model.cczpanshu];
    self.czlvLabel.text = [NSString stringWithFormat:@"%@",model.czper];
    //中级
//    self.mcbpanshuLabel.text = model.mcbpanshu;
//    self.mcblvLabel.text = model.mcblv;
//    self.mczpanshuLabel.text = model.mczpanshu;
//    self.mczlvLabel.text = model.mczlv;
    //高级
    self.hcbpanshuLabel.text = [NSString stringWithFormat:@"%@",model.highcbps];
    self.hcblvLabel.text = [NSString stringWithFormat:@"%@",model.highcbper];
    self.hczpanshuLabel.text = [NSString stringWithFormat:@"%@",model.hczpanshu];
    self.hczlvLabel.text = [NSString stringWithFormat:@"%@",model.hczper];
}
@end
