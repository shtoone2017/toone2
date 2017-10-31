//
//  ScanResultCell.m
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ScanResultCell.h"
#import "Car_ScanModel.h"
#import "HNT_BHZ_SB_Controller.h"

@interface ScanResultCell ()

@end
@implementation ScanResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _status = @"";
    _jsyy = @"";
    _jsyylx = @"";
    _bhz_Label.enabled = NO;
    _fcTiemTf.enabled = NO;
    _facdBh_Label.enabled = NO;
    _bhzBh_Label.enabled = NO;
    _gongName_Label.enabled = NO;
    _qiangdudengji_Label.enabled = NO;
    _user_Label.enabled = NO;
    _tldLabel.enabled = NO;
    _bcflLabel.enabled = NO;
    _sjflLabel.enabled = NO;
    _cphLabel.enabled = NO;
    _qsrLabel.enabled = NO;
    _qlwzTf.enabled = NO;
}
- (IBAction)statusBut:(UIButton *)sender {//选择状态
    HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
    vc.type = SBListTypeQS;
    vc.callBlock = ^(NSString *banhezhanminchen, NSString *departid) {
        [_xzBut setTitle:banhezhanminchen forState:UIControlStateNormal];
        _status = banhezhanminchen;
        if (![banhezhanminchen isEqualToString:@"签收"]) {
            _jsyyView.hidden = NO;
            _bzView.hidden = NO;
        }else {
            _jsyyView.hidden = YES;
            _bzView.hidden = YES;
        }
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)jsBut:(UIButton *)sender {//拒收原因
    HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
    vc.type = SBListTypeJSYY;
    vc.callBlock = ^(NSString *banhezhanminchen, NSString *departid) {
        [_jsBut setTitle:banhezhanminchen forState:UIControlStateNormal];
        _jsyylx = departid;
        _jsyy = banhezhanminchen;
        if ([departid isEqualToString:@"5"]) {
            _jsyy = _bzTf.text;
        }
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

-(void)didDetailCell {//本地详情
    _qsflTf.enabled = NO;
    _xzBut.userInteractionEnabled = NO;
    _jsBut.userInteractionEnabled = NO;
    _bzTf.enabled = NO;
}


-(void)setModel:(Car_ScanModel *)model {
    _model = model;
    _bhz_Label.text = model.BHZMC;
    _fcTiemTf.text = model.FCSJ;
    _facdBh_Label.text = model.FCDBH;
    _bhzBh_Label.text = model.JZLBH;
    _gongName_Label.text = model.GCMC;
    _qiangdudengji_Label.text = model.QDDJ;
    _user_Label.text = model.FCR;
    _tldLabel.text = model.TLD;
    _bcflLabel.text = model.BCFL;
    _sjflLabel.text = model.SJFL;
    _cphLabel.text = model.CH;
    _qsrLabel.text = model.QSR;
    _qlwzTf.text = model.XLWZ;
}
-(void)setData:(Car_ScanModel *)model :(NSDictionary *)dict {
    _bhz_Label.text = model.BHZMC;
    _fcTiemTf.text = model.FCSJ;
    _facdBh_Label.text = model.FCDBH;
    _bhzBh_Label.text = model.JZLBH;
    _gongName_Label.text = model.GCMC;
    _qiangdudengji_Label.text = model.QDDJ;
    _user_Label.text = model.FCR;
    _tldLabel.text = model.TLD;
    _bcflLabel.text = model.BCFL;
    _sjflLabel.text = model.SJFL;
    _cphLabel.text = model.CH;
    _qsrLabel.text = model.QSR;
    _qlwzTf.text = model.XLWZ;
    _qsflTf.text = model.QSFL;
    
    if ([model.orderStatus isEqualToString:@"拒收"]) {
        _jsyyView.hidden = NO;
        _bzView.hidden = NO;
    }
    [_jsBut setTitle:model.JSYY forState:UIControlStateNormal];
    _jsyy = model.JSYY;
    _jsyylx = model.JSYYLX;
    _bzTf.text = model.JSBZ;
    [_xzBut setTitle:model.orderStatus forState:UIControlStateNormal];
    _status = model.orderStatus;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.qsflTf resignFirstResponder];
    [self.bzTf resignFirstResponder];
}

- (UIViewController *)viewController {
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}
@end
