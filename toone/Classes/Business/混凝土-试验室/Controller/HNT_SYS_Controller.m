//
//  HNT_sysController.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//
#import "Exp1View.h"
#import "HNT_SYS_Controller.h"
#import "HNT_SYS_Model.h"
#import "HNT_SYS_FrameModel.h"
#import "HNT_SYS_Cell.h"
#import "HNT_SYS_InnerController.h"
#import "SW_ZZJG_Controller.h"
#import "SYS_MAIN_Cell.h"
#import "HNT_YLSY_Controller.h"
#import "HNT_WNSY_Controller.h"
#import "HNT_TJFX_Controller.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
#import "HNT_XZ_Controller.h"
#import "HNT_DQ_Controller.h"
#import "InputController.h"
#import "XXCXViewController.h"

@interface HNT_SYS_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *dataNum;//到期数量
@property (nonatomic, copy) NSString *departType;
@property (nonatomic, copy) NSString *biaoshiid;

@end

@implementation HNT_SYS_Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addPanGestureRecognizer];
    [self loadData];
    [self loadUI];
}
-(void)dealloc{
    FuncLog;
}

-(void)loadData {
        NSString *currentTime = [TimeTools timeStampWithTimeString:self.endTime];
//    NSString *currentTime = @"1516420800";
        NSString *endTime = [TimeTools timeStampWithTimeString:[TimeTools time_1_dayAgo:1]];
//    NSString *endTime = @"1516507200";
    
    _departType = [UserDefaultsSetting shareSetting].userType;
    _biaoshiid = [UserDefaultsSetting shareSetting].biaoshi;
    
    NSString * urlString = [NSString stringWithFormat:Hnt_SYS_list,_departType,_biaoshiid,currentTime,endTime];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            
            _dataNum = [NSString stringWithFormat:@"%@",json[@"data"]];
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadUI{
//    self.containerView.backgroundColor = BLUECOLOR;
//    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
//    btn.tag  = 2;
//    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HNT_SYS_Cell class] forCellReuseIdentifier:@"HNT_SYS_Cell"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([UserDefaultsSetting shareSetting].sysqrcodeReal) {
        return 6;
    }else {
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CELLID";
    SYS_MAIN_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SYS_MAIN_Cell" owner:self options:nil] firstObject];
    }
    if (indexPath.row == 4) {
        cell.numLabel.hidden = NO;
        if (_dataNum) {
            cell.numLabel.text = _dataNum;
        }
    }else {
        cell.numLabel.hidden = YES;
    }
    if ([UserDefaultsSetting shareSetting].sysqrcodeReal) {
        NSArray *titleArr = @[@"压力试验",@"万能试验",@"统计分析",@"新增养护功能",@"今日试验提醒",@"养护试验查阅"];
        NSArray *imgArr = @[@"SYS_YL",@"SYS_WN",@"SYS_TJ",@"SYS_XZ",@"SYS_TX",@"SYS_CK"];
        cell.title.text = titleArr[indexPath.row];
        cell.img.image = [UIImage imageNamed:imgArr[indexPath.row]];
    }else {
        NSArray *titleArr = @[@"压力试验",@"万能试验",@"统计分析",@"今日试验提醒",@"养护试验查阅"];
        NSArray *imgArr = @[@"SYS_YL",@"SYS_WN",@"SYS_TJ",@"SYS_TX",@"SYS_CK"];
        cell.title.text = titleArr[indexPath.row];
        cell.img.image = [UIImage imageNamed:imgArr[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row){
        case 0:{
            //压力
            HNT_YLSY_Controller *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_YLSY_Controller"];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:{
            //万能
            HNT_WNSY_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_WNSY_Controller"];
            [self.navigationController pushViewController:ylVC animated:YES];
        }
            break;
        case 2:{
            //统计分析
            HNT_TJFX_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_TJFX_Controller"];
            [self.navigationController pushViewController:ylVC animated:YES];
        }
            break;
        case 3:{//新增
            if (![UserDefaultsSetting shareSetting].sysqrcodeReal) {
                [self.navigationController pushViewController:[[HNT_DQ_Controller alloc] init] animated:YES];
            }else {
                [self.navigationController pushViewController:[[HNT_XZ_Controller alloc] init] animated:YES];
            }
        }
            break;
        case 4:{//提醒
            if (![UserDefaultsSetting shareSetting].sysqrcodeReal) {
                XXCXViewController *vc = [[XXCXViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                [self.navigationController pushViewController:[[HNT_DQ_Controller alloc] init] animated:YES];
            }
        }
            break;
        case 5:{//查看
            XXCXViewController *vc = [[XXCXViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *headerImg = [UIImageView new];
    headerImg.image = [UIImage imageNamed:@"SYS_Header_IMG2.jpg"];
    return headerImg;
}

@end
