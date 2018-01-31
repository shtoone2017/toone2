//
//  YS_YSCG_Controller.m
//  toone
//
//  Created by 上海同望 on 2018/1/30.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_YSCG_Controller.h"
#import "UIImageView+WebCache.h"
#import "YS_SB_Controller.h"
#import "SGDateTools.h"

@interface YS_YSCG_Controller ()
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *start;//桩号
@property (nonatomic, copy) NSString *roadName;
@property (nonatomic, copy) NSString *road_id;//路线id
@property (nonatomic, copy) NSString *mc;//面层
@property (nonatomic, copy) NSString *time;

@end
@implementation YS_YSCG_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    _roadName = @"";
    _road_id = @"";
    
    [self loadUI];
    [self loadData];
}

-(void)loadUI {
    self.sjLabel.text = [NSString stringWithFormat:@"当前路线： %@",_roadName];
    self.view.backgroundColor = [UIColor snowColor];
    self.title = @"压实成果";
}

-(void)loadData {
//    NSString *urlString = @"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/drawRoadController?drawData&roadid=f9a816c15e50be21015e566322495fe0&id=2&mc=3&dates=2018-01-09";
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/drawRoadController?drawData&roadid=%@&id=%@&mc=%@&dates=%@",_road_id,_start,_mc,_time];
    __weak typeof(self)  weakSelf = self;
    
    [[HTTP shareAFNNetworking] requestMethod:GETS urlString:urlString parameter:nil success:^(id json) {
        weakSelf.iconUrl = [NSString stringWithFormat:@"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS%@",json];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:weakSelf.iconUrl] placeholderImage:nil];
    } failure:^(NSError *error) {

    }];
}

- (IBAction)searchButtonClick:(UIButton *)sender {
    sender.enabled = NO;
    //1.
    UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(0, 64+36, Screen_w, Screen_h  -64-36);
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    backView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        backView.hidden = NO;
    });
    [self.view addSubview:backView];
    
    //2.
    ExpYS1View * e = [[ExpYS1View alloc] init];
    [e setLabel1:nil Label2:@"选择时间" Label3:@"选择桩号"];
    e.frame = CGRectMake(0, 64+36, Screen_w, 250);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {
            sender.enabled = YES;
            [backView removeFromSuperview];
            
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
            sbVc.type = SBListTypeYSLX;
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.callBlock = ^(NSString *name, NSString *num) {
                [btn setTitle:name forState:UIControlStateNormal];
                _roadName = name;
                _road_id = num;
            };
        }
        if (type == ExpButtonTypeEndTimeButton) {//日期
            UIButton * btn = (UIButton*)obj1;
            SGymd *ymd = [[SGymd alloc] init];
            ymd.block = ^(NSString * string){
                [btn setTitle:string forState:UIControlStateNormal];
                _time = string;
            };
        }
        if (type == ExpButtonTypeChoiceSBButton) {//桩号
            UIButton * btn = (UIButton*)obj1;
            YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
            sbVc.type = SBListTypeYSZH;
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.YScallBlock = ^(NSString *name, NSNumber *num) {
                [btn setTitle:name forState:UIControlStateNormal];
                _start = [NSString stringWithFormat:@"%@",num];
            };
        }
        if (type == ExpButtonTypeYSMC) {//面层
            UIButton * btn = (UIButton*)obj1;
            YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
            sbVc.type = SBListTypeYSMC;
            [self.navigationController pushViewController:sbVc animated:YES];
            sbVc.callBlock = ^(NSString *name, NSString *num) {
                [btn setTitle:name forState:UIControlStateNormal];
                _mc = num;
            };
        }
    };
    [self.view addSubview:e];
}

@end
