//
//  HNT_XZ_HeadCell.m
//  toone
//
//  Created by 上海同望 on 2018/1/10.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "HNT_XZ_HeadCell.h"
#import "HNT_BHZ_SB_Controller.h"
#import "SGDateTools.h"
#import "InputController.h"
#import "SW_ZZJG_Controller.h"

@interface HNT_XZ_HeadCell ()
@property (nonatomic,strong)  SW_ZZJG_Data * condition;


@end
@implementation HNT_XZ_HeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self startTimeClick];
//    UITapGestureRecognizer *startTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTimeClick)];
//    [self.startTimeView addGestureRecognizer:startTime];
    UITapGestureRecognizer *qddj = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qddjClick)];
    [self.qddjView addGestureRecognizer:qddj];
    UITapGestureRecognizer *lq = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lqClick)];
    [self.lqView addGestureRecognizer:lq];
    UITapGestureRecognizer *gcmc = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gcmcClick)];
    [self.gcmcView addGestureRecognizer:gcmc];
    UITapGestureRecognizer *sgbw = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sgbwClick)];
    [self.sgbwView addGestureRecognizer:sgbw];
    UITapGestureRecognizer *zzjg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zzjgClick)];
    [self.zzjgView addGestureRecognizer:zzjg];
}


-(void)hiddenView {
    _zzjgView.hidden = YES;
    _top.constant = 100;
}

-(void)startTimeClick {
    _startTimeLabel.text = [TimeTools currentTime];
}
-(void)qddjClick {
    HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
    controller.type = SBListTypeSJQD;
    controller.callBlock = ^(NSString *banhezhanminchen,NSString *gprsbianhao){
        _qddjLabel.text = banhezhanminchen;
    };
    [self.viewController.navigationController pushViewController:controller animated:YES];
}
-(void)zzjgClick {//组织机构
    SW_ZZJG_Controller * controller = [[SW_ZZJG_Controller alloc] init];
    controller.modelType = @"3,4";
    controller.type = @"新增";
    __weak __typeof(self)  weakSelf = self;
    controller.zzjgCallBackBlock = ^(SW_ZZJG_Data * data){
        weakSelf.condition = data;
        if (weakSelf.condition.biaoshi.length == 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"请选择试验室";
            [hud hideAnimated:YES afterDelay:2.0];
        }else {
            _zzjgLabel.text = weakSelf.condition.name;
            _biaoshiid = weakSelf.condition.biaoshi;
            _departType = weakSelf.condition.departType;
        }
    };
    [self.viewController.navigationController pushViewController:controller animated:YES];
}
-(void)lqClick {
    InputController *vc = [[InputController alloc] init];
    vc.oldString = _lqLabel.text;
    vc.title = @"请输入龄期";
    vc.callBlock = ^(NSString * banhezhanminchen){
        _lqLabel.text = banhezhanminchen;
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(void)gcmcClick {
    InputController *vc = [[InputController alloc] init];
    vc.title = @"请输入工程名称";
    vc.callBlock = ^(NSString * banhezhanminchen){
        _gcmcLabel.text = banhezhanminchen;
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
-(void)sgbwClick {
    InputController *vc = [[InputController alloc] init];
    vc.title = @"请输入施工部位";
    vc.callBlock = ^(NSString * banhezhanminchen){
        _sgbwLabel.text = banhezhanminchen;
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
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
