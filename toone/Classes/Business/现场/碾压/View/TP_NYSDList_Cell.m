//
//  TP_NYSDList_Cell.m
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_NYSDList_Cell.h"
#import "TP_NYSDList_Model.h"

@interface TP_NYSDList_Cell()
@property (weak, nonatomic) IBOutlet UILabel *sbLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UILabel *sdLabel;

@end
@implementation TP_NYSDList_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setListModel:(TP_NYSDList_Model *)listModel {
    _listModel = listModel;
    self.sbLabel.text = listModel.banhezhanminchen;
//    self.sjLabel.text = listModel.shijian;
    if (listModel.sudu) {//速度
        self.sdLabel.text = Format(listModel.sudu);
        self.sjLabel.text = listModel.shijian;
    }if (listModel.tmpdata) {//温度
        self.sdLabel.text = listModel.tmpdata;
        self.sjLabel.text = listModel.tmpshijian;
    }
    
}

@end
