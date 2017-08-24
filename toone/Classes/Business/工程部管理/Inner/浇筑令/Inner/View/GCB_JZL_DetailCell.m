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
#import "YYModel.h"

@interface GCB_JZL_DetailCell ()
@property (weak, nonatomic) IBOutlet UITextField *rwbhText;//任务编号
@property (weak, nonatomic) IBOutlet UIButton *kptimeBut;//开盘时间
@property (weak, nonatomic) IBOutlet UIButton *jzbwBut;//浇筑部位
@property (weak, nonatomic) IBOutlet UITextField *gcmcText;//工程名称
@property (weak, nonatomic) IBOutlet UITextField *kddjText;//抗冻等级
@property (weak, nonatomic) IBOutlet UIButton *jzfsBut;//浇筑方式
@property (weak, nonatomic) IBOutlet UILabel *cjtimeLabel;//创建时间
@property (weak, nonatomic) IBOutlet UITextField *jhflText;//计划方量
@property (weak, nonatomic) IBOutlet UIButton *jgBut;//组织机构
@property (weak, nonatomic) IBOutlet UIButton *sjqdBut;//设计强度
@property (weak, nonatomic) IBOutlet UIButton *tldBut;//塌落度
@property (weak, nonatomic) IBOutlet UILabel *userLabel;//创建人
@property (weak, nonatomic) IBOutlet UITextField *ksdjText;//抗滲等级
@property (weak, nonatomic) IBOutlet UITextField *bzText;//备注

@property (nonatomic,copy)NSString *tjID;//当前id
@property (nonatomic,copy)NSString *identifier;//组织机构ID
@end
@implementation GCB_JZL_DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(GCB_JZL_DetailModel *)model {
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
    _userLabel.text = model.createperson;
    _ksdjText.text = model.kangshendengji;
    _bzText.text = model.remark;
    _tjID = [NSString stringWithFormat:@"%@",model.tjId];
    _identifier = model.org_code;
}

//开盘时间
- (IBAction)kpTimeClick:(UIButton *)sender {
    
}
//浇筑部位
- (IBAction)jzbwClick:(UIButton *)sender {
    
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

//提交
- (IBAction)submitClick:(id)sender {
    NSString *urlString = FormatString(baseUrl, @"appWZproject.do?AppWZRenwudanEdit");
    NSDictionary * dic = @{@"isAdd":@"0",
                           @"id":_tjID,
                           @"renwuno":self.rwbhText.text,
                           @"kaipanriqi":self.kptimeBut.titleLabel.text,
                           @"jzbw":self.jzbwBut.titleLabel.text,
                           @"gcmc":self.gcmcText.text,
                           @"kangdongdengji":self.kddjText.text,
                           @"jiaozhufangshi":self.jzfsBut.titleLabel.text,
                           @"createtime":self.cjtimeLabel.text,
                           @"jihuafangliang":self.jhflText.text,
                           @"departid":_identifier,
                           @"shuinibiaohao":self.sjqdBut.titleLabel.text,
                           @"tanluodu":self.tldBut.titleLabel.text,
                           @"createperson":self.userLabel.text,
                           @"kangshendengji":self.ksdjText.text,
                           @"remark":self.bzText.text
                           };
    
    NSError  * err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary * newDic = @{@"data":jsonStr};
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setValue:@"0"forKey:@"isAdd"];
    [dictM setValue:@"11" forKey:@"tanluodu"];
    [dictM setValue:@"110" forKey:@"kangdongdengji"];
    
    NSData *jsonDa = [NSJSONSerialization dataWithJSONObject:dictM options:NSJSONWritingPrettyPrinted error:&err];
//    NSDictionary * dicc = @{@"data":jsonDa};
    NSString *str = [dictM yy_modelToJSONString];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:str];
//    str = [arr yy_modelToJSONString];
    
//    [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dicc[@"data"] success:^(id json) {
//
//        if ([json[@"success"] boolValue]){
//            [Tools tip:@"提交成功,请刷新数据"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                [self.viewController.navigationController popViewControllerAnimated:YES];
//            });
//        }else{
//            [Tools tip:@"抱歉，提交失败"];
//        }
//    } failure:^(NSError *error) {
//        [Tools tip:@"网络故障，提交失败"];
//    }];

    
    
    
//    NSString * jsonStr1 = [[[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
//    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];

    NSDictionary *headerFieldValueDictionary = newDic.copy;
    if (headerFieldValueDictionary != nil) {
//        NSDictionary *dict = headerFieldValueDictionary[@"data"];
//        for (NSString *httpHeaderField in dict.allKeys) {
//            NSString *value = dict[httpHeaderField];
//            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//        }
        [manger.requestSerializer setValue:str forHTTPHeaderField:@"data"];
//        [manger.requestSerializer setValue:@"900" forHTTPHeaderField:@"Content-Length"];
         NSLog(@"%@",manger.requestSerializer.HTTPRequestHeaders);
    }
    
//    manger.requestSerializer = requestSerializer;
    [manger POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Tools tip:@"网络故障，提交失败"];
    }];
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
