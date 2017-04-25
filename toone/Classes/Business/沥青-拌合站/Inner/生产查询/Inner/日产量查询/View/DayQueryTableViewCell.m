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
@property (weak, nonatomic) IBOutlet UILabel *dailyclLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailypsLabel;

@property (weak, nonatomic) IBOutlet UILabel *dailysbbh_label;


@end
@implementation DayQueryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDayQueryModel:(DayQueryModel *)dayQueryModel {
    _dayQueryModel = dayQueryModel;
    
    self.dailyrqLabel.text = dayQueryModel.dailyrq;
    self.dailyclLabel.text = dayQueryModel.dailycl;
    self.dailypsLabel.text = dayQueryModel.dailyps;
    self.dailysbbh_label.text = dayQueryModel.dailysbbh;


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
