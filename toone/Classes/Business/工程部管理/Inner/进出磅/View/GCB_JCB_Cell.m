//
//  GCB_JCB_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/17.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCB_Cell.h"
#import "GCB_JC_Model.h"

@interface GCB_JCB_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *cailiaoName;
@property (weak, nonatomic) IBOutlet UILabel *datetype;//统计类型（季度、月、周）
@property (weak, nonatomic) IBOutlet UILabel *banhezhanminchen;
@property (weak, nonatomic) IBOutlet UILabel *jinchuliaodanNo;//进出料单编号
@property (weak, nonatomic) IBOutlet UILabel *piciLabel;
@property (weak, nonatomic) IBOutlet UILabel *maocLabel;
@property (weak, nonatomic) IBOutlet UILabel *picLabel;
@property (weak, nonatomic) IBOutlet UILabel *jincLabel;
@property (weak, nonatomic) IBOutlet UILabel *gysLabel;//供应商

@end
@implementation GCB_JCB_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setJcModel:(GCB_JC_Model *)jcModel {
    _jcModel = jcModel;
    _cailiaoName.text = jcModel.cailiaoName;
    _datetype.text = jcModel.datetype;
    _banhezhanminchen.text = jcModel.banhezhanminchen;
    _jinchuliaodanNo.text = jcModel.jinchuliaodanNo;
    _picLabel.text = [NSString stringWithFormat:@"%@",jcModel.pizhong];
    _maocLabel.text = [NSString stringWithFormat:@"%@",jcModel.maozhong];
    _jincLabel.text = [NSString stringWithFormat:@"%@",jcModel.jingzhong];
    _gysLabel.text = jcModel.gongyingshangName;
    _piciLabel.text = jcModel.pici;
}
-(void)setCcModel:(GCB_JC_Model *)ccModel {
    _ccModel = ccModel;
    _jcModel = ccModel;
    _cailiaoName.text = ccModel.cailiaoName;
    _datetype.text = ccModel.datetype;
    _banhezhanminchen.text = ccModel.banhezhanminchen;
//    _jinchuliaodanNo.text = ccModel.jinchuliaodanNo;
    _jinchuliaodanNo.hidden = YES;
    _picLabel.text = [NSString stringWithFormat:@"%@",ccModel.pizhong];
    _maocLabel.text = [NSString stringWithFormat:@"%@",ccModel.maozhong];
    if (ccModel.jingzhong) {
        _jincLabel.text = [NSString stringWithFormat:@"%@",ccModel.jingzhong];
    }
    _gysLabel.text = ccModel.gongyingshangName;
    _piciLabel.text = ccModel.pici;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
