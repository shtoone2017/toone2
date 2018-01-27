//
//  JCB_DetailCell_1.m
//  toone
//
//  Created by 上海同望 on 2017/8/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "JCB_DetailCell_1.h"
#import "JCB_DetailModel.h"

@interface JCB_DetailCell_1 ()
@property (weak, nonatomic) IBOutlet UILabel *jctimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cctimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *gysLabel;//供应商
@property (weak, nonatomic) IBOutlet UILabel *clmcLabel;//材料名称
@property (weak, nonatomic) IBOutlet UILabel *sbyLabel;//司磅员
@property (weak, nonatomic) IBOutlet UILabel *cphLabel;//车牌号
@property (weak, nonatomic) IBOutlet UILabel *bzLabel;//备注
@property (weak, nonatomic) IBOutlet UILabel *mzLabel;
@property (weak, nonatomic) IBOutlet UILabel *pzLabel;
@property (weak, nonatomic) IBOutlet UILabel *jzLabel;
@property (weak, nonatomic) IBOutlet UILabel *kzLabel;
@property (weak, nonatomic) IBOutlet UILabel *klvLabel;//扣率
@property (weak, nonatomic) IBOutlet UILabel *czbcLabel;//称重偏差
@property (weak, nonatomic) IBOutlet UILabel *piciLabel;
@property (weak, nonatomic) IBOutlet UILabel *shbhLabel;//进货编号

@property (weak, nonatomic) IBOutlet UIView *jhbhView;

@end
@implementation JCB_DetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(JCB_DetailModel *)model {
    _model = model;
    if ([_model.istype isEqualToString:@"出厂"]) {
        self.jhbhView.hidden = YES;
    }
    _jctimeLabel.text = model.jinchangshijian;
    _cctimeLabel.text = model.chuchangshijian;
    _gysLabel.text = model.gongyingshangName;
    _clmcLabel.text = model.cailiaoName;
    _sbyLabel.text = model.sibangyuan;
    _cphLabel.text = model.qianchepai;
    _bzLabel.text = model.remark;
    _klvLabel.text = model.koulv;
    _czbcLabel.text = model.chengzhongpiancha;
    _piciLabel.text = model.pici;
    _shbhLabel.text = model.jinchuliaodanNo;
    _mzLabel.text = [NSString stringWithFormat:@"%@",model.maozhong];
    _pzLabel.text = [NSString stringWithFormat:@"%@",model.pizhong];
    if (model.jingzhong) {
        _jzLabel.text = [NSString stringWithFormat:@"%@",model.jingzhong];
    }
    _kzLabel.text = [NSString stringWithFormat:@"%@",model.kouzhong];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
