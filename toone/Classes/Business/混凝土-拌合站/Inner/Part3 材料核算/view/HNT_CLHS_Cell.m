//
//  HNT_CLHS_Cell.m
//  toone
//
//  Created by 十国 on 2016/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_CLHS_Cell.h"
#import "HNT_CLHS_Model.h"
@interface  HNT_CLHS_Cell()
@property (weak, nonatomic) IBOutlet UILabel *name ;//  材料名称
@property (weak, nonatomic) IBOutlet UILabel *shiji ;//  实际值
@property (weak, nonatomic) IBOutlet UILabel *peibi ;//  配比值
@property (weak, nonatomic) IBOutlet UILabel *wuchazhi ;//  误差值
@end 

@implementation HNT_CLHS_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(HNT_CLHS_Model *)data{
    self.name.text = data.name;
    self.shiji.text = FormatFloat([data.shiji floatValue]);
    self.peibi.text = FormatFloat([data.peibi floatValue]);
    self.wuchazhi.text = FormatFloat([data.wuchazhi floatValue]);
}
@end
