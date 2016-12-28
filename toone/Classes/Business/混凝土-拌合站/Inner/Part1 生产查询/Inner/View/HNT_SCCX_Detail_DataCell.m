//
//  HNT_SCCX_Detail_DataCell.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//
#import "HNT_SCCX_Detail_Data.h"
#import "HNT_SCCX_Detail_DataCell.h"
@interface HNT_SCCX_Detail_DataCell()
@property (nonatomic,weak) IBOutlet UILabel *  cbGrade ;//  超标等级
@property (nonatomic,weak) IBOutlet UILabel *  name ;//  材料名称
@property (nonatomic,weak) IBOutlet UILabel *  peibi ;//  配比值
@property (nonatomic,weak) IBOutlet UILabel *  shiji ;//  实际值
@property (nonatomic,weak) IBOutlet UILabel *  wuchalv ;//  误差率
@property (nonatomic,weak) IBOutlet UILabel *  wuchazhi ;//  误差值
@end
@implementation HNT_SCCX_Detail_DataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(HNT_SCCX_Detail_Data *)data{
    self.cbGrade.text = data.cbGrade;//  超标等级
    self.name.text = data.name;//  材料名称
    self.peibi.text = data.peibi;//  配比值
    self.shiji.text = data.shiji;//  实际值
    self.wuchalv.text = data.wuchalv;//  误差率
    self.wuchazhi.text = data.wuchazhi;//  误差值
}
@end
