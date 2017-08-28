//
//  GCB_JCH_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCH_Controller.h"
#import "GCB_JCH_Model.h"
#import "GCB_JCH_Cell.h"
#import "GCB_JCH_ChartModel.h"
#import "BarModel.h"
#import "NodeViewController.h"

@interface GCB_JCH_Controller ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;

@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) NSMutableArray * ChartDatas;
@property (nonatomic,copy) NSString * departId;//组织机构id

@end
@implementation GCB_JCH_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.departId = @"";
    
    [self loadUI];
    [self loadData];
    
}
-(void)loadUI {
    self.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",super.startTime,super.endTime];
    self.view.backgroundColor = [UIColor snowColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GCB_JCH_Cell" bundle:nil] forCellReuseIdentifier:@"GCB_JCH_Cell"];
}
#pragma mark - 网络请求
-(void)loadData {
    [Tools showActivityToView:self.view];
    
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = [NSString stringWithFormat:AppJCH,self.departId,startTimeStamp,endTimeStamp];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    GCB_JCH_Model * model = [GCB_JCH_Model modelWithDict:dict];
                    [datas addObject:model];
                }
            }
        }
        NSMutableArray * bars = [NSMutableArray array];//y
        NSMutableArray * names = [NSMutableArray array];
//        for (GCB_JCH_Model * model in datas) {
//            BarModel * bar = [[BarModel alloc] init];
//            for (NSUInteger i = 0; i <= 3; i++) {
//                switch (i) {
//                    case 1:{
//                        bar.value = model.xiaohao;
//                        bar.name = model.cailiaoName;
//                        [bars addObject:bar];
//                        break;
//                    }
//                    case 2:{
//                        bar.value = model.chuchang;
//                        bar.name = model.cailiaoName;
//                        [bars addObject:bar];
//                        break;
//                    }
//                    case 3:{
//                        bar.name = model.cailiaoName;
//                        bar.value = model.jinchang;
//                        [bars addObject:bar];
//                        break;
//                    }
//                    default:
//                        break;
//                }
//            }
//        }
        for (GCB_JCH_Model *model in datas) {
            [bars addObject:model.xiaohao];
            [bars addObject:model.chuchang];
            [bars addObject:model.jinchang];
            [names addObject:model.cailiaoName];
        }
        NSMutableArray *a = [NSMutableArray array];
        for (NSInteger j = 0; j<names.count; j++) {
            for (NSInteger i=0; i<3; i++) {
                [a addObject:names[j]];
            }
        }
        weakSelf.ChartDatas = bars;
        weakSelf.datas = a;
//        weakSelf.ChartDatas = bars;
//        weakSelf.datas = datas;
        [weakSelf.tableView reloadData];
        
        [Tools removeActivity];
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCB_JCH_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCB_JCH_Cell" forIndexPath:indexPath];
//    cell.datas = _ChartDatas;
    [cell setchart:_ChartDatas add:_datas];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
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
    Exp5View * e = [[Exp5View alloc] init];
    e.sbLabel = @"组织机构";
    e.frame = CGRectMake(0, 64+36, Screen_w, 195);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {
            sender.enabled = YES;
            [backView removeFromSuperview];
            //
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",weakSelf.startTime,weakSelf.endTime];
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        if (type == ExpButtonTypeChoiceSBButton) {//组织机构
            UIButton * btn = (UIButton*)obj1;
            __weak typeof(self) weakSelf = self;
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                weakSelf.departId = identifier;
                [btn setTitle:name forState:UIControlStateNormal];
//                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:e];
}


@end
