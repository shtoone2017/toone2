//
//  GCB_JZL_DetailCell.m
//  toone
//
//  Created by 上海同望 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JZL_DetailCell.h"
#import "GCB_JZL_DetailModel.h"
#import "HNT_BHZ_SB_Controller.h"
#import "NodeViewController.h"
#import "JZL_JZBW_Controller.h"
#import "GCB_JZL_Controller.h"
#import "SGDateTools.h"

@interface GCB_JZL_DetailCell ()
@property (weak, nonatomic) IBOutlet UITextField *rwbhText;//任务编号+1
@property (weak, nonatomic) IBOutlet UIButton *kptimeBut;//开盘时间+1
@property (weak, nonatomic) IBOutlet UIButton *jzbwBut;//浇筑部位+1
@property (weak, nonatomic) IBOutlet UITextField *gcmcText;//工程名称+1
@property (weak, nonatomic) IBOutlet UITextField *kddjText;//抗冻等级
@property (weak, nonatomic) IBOutlet UIButton *jzfsBut;//浇筑方式
@property (weak, nonatomic) IBOutlet UILabel *cjtimeLabel;//创建时间
@property (weak, nonatomic) IBOutlet UITextField *jhflText;//计划方量+1
@property (weak, nonatomic) IBOutlet UIButton *jgBut;//组织机构+1
@property (weak, nonatomic) IBOutlet UIButton *sjqdBut;//设计强度
@property (weak, nonatomic) IBOutlet UIButton *tldBut;//塌落度
@property (weak, nonatomic) IBOutlet UIButton *sgdBut;//施工队
@property (weak, nonatomic) IBOutlet UILabel *userLabel;//创建人
@property (weak, nonatomic) IBOutlet UITextField *ksdjText;//抗滲等级
@property (weak, nonatomic) IBOutlet UITextField *bzText;//备注

@property (weak, nonatomic) IBOutlet UIButton *subitBut;//保存


@property (nonatomic,copy)NSString *tjID;//当前id
@property (nonatomic,copy)NSString *identifier;//组织机构ID
@property (nonatomic, copy) NSString *sgdId;//施工队id


@end
@implementation GCB_JZL_DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _subitBut.layer.cornerRadius = 25;
    _subitBut.layer.masksToBounds = YES;
//    _subitBut.layer.borderColor = [UIColor blackColor].CGColor;
//    _subitBut.layer.borderWidth = 2;
}
-(void)setXzmodel:(GCB_JZL_DetailModel *)xzmodel {
    _xzmodel = xzmodel;
    [_kptimeBut setTitle:[TimeTools current_yy_MM_dd] forState:UIControlStateNormal];
    _userLabel.text = [UserDefaultsSetting shareSetting].userFullName;
    _cjtimeLabel.text = [TimeTools currentTime];
}

-(void)setModel:(GCB_JZL_DetailModel *)model {//编辑
    _model = model;
    _rwbhText.text = model.renwuno;
    [_kptimeBut setTitle:model.kaipanriqi forState:UIControlStateNormal];
    [_jzbwBut setTitle:model.jzbw forState:UIControlStateNormal];
    _gcmcText.text = model.gcmc;
    _kddjText.text = model.kangdongdengji;
    [_jzfsBut setTitle:model.jiaozhufangshi forState:UIControlStateNormal];
    _cjtimeLabel.text = model.createtime;
    _jhflText.text = model.jihuafangliang;
    [_jgBut setTitle:model.departname forState:UIControlStateNormal];
    [_sjqdBut setTitle:model.shuinibiaohao forState:UIControlStateNormal];
    [_tldBut setTitle:model.tanluodu forState:UIControlStateNormal];
    [_sgdBut setTitle:_sgdId forState:UIControlStateNormal];
    _userLabel.text = model.createperson;
    _ksdjText.text = model.kangshendengji;
    _bzText.text = model.remark;
    _tjID = [NSString stringWithFormat:@"%@",model.tjId];
    _identifier = model.org_code;
    
}
-(void)loadModel:(GCB_JZL_DetailModel *)model :(NSString *)name {
    _model = model;
    _rwbhText.text = model.renwuno;
    [_kptimeBut setTitle:model.kaipanriqi forState:UIControlStateNormal];
    [_jzbwBut setTitle:model.jzbw forState:UIControlStateNormal];
    _gcmcText.text = model.gcmc;
    _kddjText.text = model.kangdongdengji;
    [_jzfsBut setTitle:model.jiaozhufangshi forState:UIControlStateNormal];
    _cjtimeLabel.text = model.createtime;
    _jhflText.text = model.jihuafangliang;
    [_jgBut setTitle:model.departname forState:UIControlStateNormal];
    [_sjqdBut setTitle:model.shuinibiaohao forState:UIControlStateNormal];
    [_tldBut setTitle:model.tanluodu forState:UIControlStateNormal];
    [_sgdBut setTitle:name forState:UIControlStateNormal];
    _userLabel.text = model.createperson;
    _ksdjText.text = model.kangshendengji;
    _bzText.text = model.remark;
    _tjID = [NSString stringWithFormat:@"%@",model.tjId];
    _identifier = model.org_code;
}

//开盘时间
- (IBAction)kpTimeClick:(UIButton *)sender {
    SGymd *ymd = [[SGymd alloc] init];
    ymd.block = ^(NSString * string){
        [sender setTitle:string forState:UIControlStateNormal];
    };
}
//浇筑部位
- (IBAction)jzbwClick:(UIButton *)sender {
    JZL_JZBW_Controller *controller = [[JZL_JZBW_Controller alloc] init];
    controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
        [sender setTitle:banhezhanminchen forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:controller animated:YES];
}
//浇筑方式
- (IBAction)jzfsClick:(UIButton *)sender {
    HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
    controller.type = SBListTypeJZFS;
    controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
        [sender setTitle:banhezhanminchen forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:controller animated:YES];
}
//组织机构
- (IBAction)jgClick:(UIButton *)sender {
    NodeViewController *vc = [[NodeViewController alloc] init];
    vc.type = NodeTypeZZJG;
    vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
        _identifier = identifier;
        [sender setTitle:name forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
//设计强度
- (IBAction)sjqdClick:(UIButton *)sender {
    HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
    controller.type = SBListTypeSJQD;
    controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
        [sender setTitle:banhezhanminchen forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:controller animated:YES];
}
//塌落度
- (IBAction)tldClick:(UIButton *)sender {
    HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
    controller.type = SBListTypeTLD;
    controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
        [sender setTitle:banhezhanminchen forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:controller animated:YES];
}
//施工队
- (IBAction)sgdButton:(UIButton *)sender {
    HNT_BHZ_SB_Controller *controller = [[HNT_BHZ_SB_Controller alloc] init];
    controller.type = SBListTypeSGD;
    controller.departId = [UserDefaultsSetting shareSetting].departId;
    controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
        _sgdId = gprsbianhao;
        [sender setTitle:banhezhanminchen forState:UIControlStateNormal];
    };
    [self.viewController.navigationController pushViewController:controller animated:YES];
}


//提交
- (IBAction)submitClick:(id)sender {
    NSString *urlString = FormatString(baseUrl, @"appWZproject.do?AppWZRenwudanEdit");
    NSDictionary * dic;
    switch (_isbjti) {
        case 1:{//新增
            dic = @{@"isAdd":@"1",
                    @"renwuno":self.rwbhText.text?:@"",
                    @"kaipanriqi":self.kptimeBut.titleLabel.text?:@"",
                    @"jzbw":self.jzbwBut.currentTitle?:@"",
                    @"gcmc":self.gcmcText.text?:@"",
                    @"kangdongdengji":self.kddjText.text?:@"",
                    @"jiaozhufangshi":self.jzfsBut.titleLabel.text?:@"",
                    @"createtime":self.cjtimeLabel.text?:@"",
                    @"jihuafangliang":self.jhflText.text?:@"",
                    @"departid":_identifier?:@"",
                    @"shuinibiaohao":self.sjqdBut.titleLabel.text?:@"",
                    @"tanluodu":self.tldBut.titleLabel.text?:@"",
                    @"username":self.userLabel.text?:[UserDefaultsSetting shareSetting].userFullName,
                    @"kangshendengji":self.ksdjText.text?:@"",
                    @"remark":self.bzText.text?:@"",
                    @"shigongteamid":_sgdId?:@"",
                    };
            break;
        }
        case 2:{//编辑
            dic = @{@"isAdd":@"0",
                    @"id":_tjID?:@"",
                    @"renwuno":self.rwbhText.text?:@"",
                    @"kaipanriqi":self.kptimeBut.titleLabel.text?:@"",
                    @"jzbw":self.jzbwBut.titleLabel.text?:@"",
                    @"gcmc":self.gcmcText.text?:@"",
                    @"kangdongdengji":self.kddjText.text?:@"",
                    @"jiaozhufangshi":self.jzfsBut.titleLabel.text?:@"",
                    @"createtime":self.cjtimeLabel.text?:@"",
                    @"jihuafangliang":self.jhflText.text?:@"",
                    @"departid":_identifier?:@"",
                    @"shuinibiaohao":self.sjqdBut.titleLabel.text?:@"",
                    @"tanluodu":self.tldBut.titleLabel.text?:@"",
                    @"createperson":self.userLabel.text?:[UserDefaultsSetting shareSetting].userFullName,
                    @"kangshendengji":self.ksdjText.text?:@"",
                    @"remark":self.bzText.text?:@"",
                    @"shigongteamid":_sgdId?:@"",
                    };
            break;
        }
        default:
            break;
    }
    if (![_rwbhText.text isEqualToString:@""] && ![_kptimeBut.titleLabel.text isEqualToString:@""] && ![_jzbwBut.currentTitle isEqualToString:@""] && ![_gcmcText.text isEqualToString:@""] && ![_jhflText.text isEqualToString:@""] && ![_jgBut.titleLabel.text isEqualToString:@""]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
        
        req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                if ([responseObject[@"success"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [UserDefaultsSetting shareSetting].GCBSeed = [NSString stringWithFormat:@"%d",arc4random()%1000];
                        UIViewController *vc = self.viewController.navigationController.viewControllers[self.viewController.navigationController.viewControllers.count-2];
                        [self.viewController.navigationController popToViewController:vc animated:YES];
                    });
                }else {
                    [SVProgressHUD showErrorWithStatus:@"保存失败"];
                }
            }else {
                NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            }
            
        }] resume];
        
    }else {
        [Tools tip:@"必填项不可为空，请填写完整信息"];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.rwbhText resignFirstResponder];
    [self.gcmcText resignFirstResponder];
    [self.kddjText resignFirstResponder];
    [self.jhflText resignFirstResponder];
    [self.ksdjText resignFirstResponder];
    [self.bzText resignFirstResponder];
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
