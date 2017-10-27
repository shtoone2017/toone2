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

-(void)submitClick:(UIButton *)sender {
    if (_qsflTf.text.length == 0 || [_status isEqualToString:@""]) {
        [Tools tip:@"必填项不可为空，请填写完整信息"];
        return;
    }
    if ([_status isEqualToString:@"签收"]) {
        NSString *urlSting = @"http://61.237.239.105:18190/FCDService/FCDService.asmx/UploadQSXX";
        NSDictionary *dict = @{@"token":[UserDefaultsSetting_SW shareSetting].Token,
                               @"fcdbh":_facdBh_Label.text?:@"",
                               @"bhzbh":_model.BHZBH?:@"",
                               @"qsfl":_qsflTf.text?:@"",
                               @"qsr":_qsrLabel.text?:@"",
                               @"xlwzmc":_qlwzTf.text?:@"",
                               @"xlwzcode":@"1",
                               @"xlwzzb":_loation?:@"",
                               @"qszp":_dataImg,
                               @"qssj":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                               };
        
        [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlSting parameter:dict success:^(id json) {
            if ([json isKindOfClass:[NSDictionary class]]) {
                if ([json[@"code"] integerValue] == 1) {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loation"];
                    [SVProgressHUD showImage:nil status:@"提交成功，请刷新数据"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        UIViewController * vc = self.viewController.navigationController.viewControllers[self.viewController.navigationController.viewControllers.count-3];
                        [self.viewController.navigationController popToViewController:vc animated:YES];
                    });
                }else {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loation"];
                    [SVProgressHUD showImage:nil status:json[@"message"]];
                }
                
                
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showImage:nil status:@"服务器异常"];
        }];
        
    }else if ([_status isEqualToString:@"拒收"]) {
        if (([_jsyylx isEqualToString:@"5"] && _bzTf.text.length == 0) || _xzBut.titleLabel.text.length == 0 || _jsBut.titleLabel.text.length == 0) {
            [Tools tip:@"必填项不可为空，请填写完整信息"];
            return;
        }
        NSString *urlSting = @"http://61.237.239.105:18190/FCDService/FCDService.asmx/UploadJSXX";
        NSDictionary *dict = @{@"token":[UserDefaultsSetting_SW shareSetting].Token,
                               @"fcdbh":_facdBh_Label.text?:@"",
                               @"bhzbh":_model.BHZBH?:@"",
                               @"qsfl":_qsflTf.text?:@"",
                               @"qsr":_qsrLabel.text?:@"",
                               @"xlwzmc":_qlwzTf.text?:@"",
                               @"xlwzcode":@"1",
                               @"xlwzzb":_loation?:@"",
                               @"qszp":_dataImg?:@"",//签收
                               @"qssj":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                               @"jsyylx":_jsyylx?:@"",
                               @"jsyy":_jsyy?:@"",
                               @"jspz":_jsImg?:@"",//拒收
                               };
        
        [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlSting parameter:dict success:^(id json) {
            if ([json isKindOfClass:[NSDictionary class]]) {
                if ([json[@"code"] integerValue] == 1) {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loation"];
                    [SVProgressHUD showImage:nil status:@"提交成功，请刷新数据"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        UIViewController * vc = self.viewController.navigationController.viewControllers[self.viewController.navigationController.viewControllers.count-3];
                        [self.viewController.navigationController popToViewController:vc animated:YES];
                    });
                }else {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jsImg"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loation"];
                    [SVProgressHUD showImage:nil status:json[@"message"]];
                }
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showImage:nil status:@"服务器异常"];
        }];
        
    }
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

    [_jsBut setTitle:model.JSYY forState:UIControlStateNormal];
    _bzTf.text = model.JSBZ;
    [_xzBut setTitle:model.orderStatus forState:UIControlStateNormal];
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
