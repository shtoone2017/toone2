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
@property (weak, nonatomic) IBOutlet UITextField * bhz_Label         ;// 拌合站1
@property (weak, nonatomic) IBOutlet UITextField * facdBh_Label       ;// 发车单编号1
@property (weak, nonatomic) IBOutlet UITextField * bhzBh_Label     ;// 浇筑令编号1
@property (weak, nonatomic) IBOutlet UITextField * gongName_Label           ;// 工程名称1
@property (weak, nonatomic) IBOutlet UITextField * qiangdudengji_Label          ;// 强度等级1
@property (weak, nonatomic) IBOutlet UITextField *tldLabel;//塌落度1
@property (weak, nonatomic) IBOutlet UITextField *sjflLabel;//设计方量1
@property (weak, nonatomic) IBOutlet UITextField *bcflLabel;//本车1
@property (weak, nonatomic) IBOutlet UITextField *qsflTf;//签收量
@property (weak, nonatomic) IBOutlet UITextField *cphLabel;//车牌号1
@property (weak, nonatomic) IBOutlet UITextField *qsrLabel;//签收人1
@property (weak, nonatomic) IBOutlet UITextField * user_Label;// 发车人1
@property (weak, nonatomic) IBOutlet UITextField *fcTiemTf;//发车时间1
@property (weak, nonatomic) IBOutlet UITextField *qlwzTf;//卸料位置1
@property (weak, nonatomic) IBOutlet UITextField *bzTf;//备注

@property (weak, nonatomic) IBOutlet UIView *jsyyView;//拒收
@property (weak, nonatomic) IBOutlet UIView *bzView;//备注
@property (weak, nonatomic) IBOutlet UIButton *xzBut;//状态显示
@property (weak, nonatomic) IBOutlet UIView *xzStatusView;//状态

@property (nonatomic, copy) NSString *status;//是否签收

@end
@implementation ScanResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)statusBut:(UIButton *)sender {//选择状态
    HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
    vc.type = SBListTypeQS;
    vc.callBlock = ^(NSString *banhezhanminchen, NSString *departid) {
        [sender setTitle:banhezhanminchen forState:UIControlStateNormal];
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
        [sender setTitle:banhezhanminchen forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
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
