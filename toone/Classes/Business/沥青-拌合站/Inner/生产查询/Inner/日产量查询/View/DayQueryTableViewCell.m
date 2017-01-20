//
//  DayQueryTableViewCell.m
//  toone
//
//  Created by shtoone on 16/12/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "DayQueryTableViewCell.h"
#import "DayQueryModel.h"

@interface DayQueryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dailyrqLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailybuweiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyclLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyxzclLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailypsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailymdLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailycdLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailykdLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyhdLabel;


@end
@implementation DayQueryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDayQueryModel:(DayQueryModel *)dayQueryModel {
    _dayQueryModel = dayQueryModel;
    
    self.dailyrqLabel.text = dayQueryModel.dailyrq;
    self.dailybuweiLabel.text = dayQueryModel.dailybuwei;
    self.dailyclLabel.text = dayQueryModel.dailycl;
    self.dailyxzclLabel.text = dayQueryModel.dailyxzcl;
    self.dailypsLabel.text = dayQueryModel.dailyps;
    self.dailymdLabel.text = dayQueryModel.dailymd;
    self.dailycdLabel.text = dayQueryModel.dailycd;
    self.dailykdLabel.text = dayQueryModel.dailykd;
    self.dailyhdLabel.text = dayQueryModel.dailyhd;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
