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
#import "NodeViewController.h"
#import "SYS_PHBViewController.h"
#import "SYS_TZDViewController.h"
#import "SYS_MAIN_Cell.h"
#import "HNT_YLSY_Controller.h"
#import "HNT_WNSY_Controller.h"
#import "HNT_TJFX_Controller.h"
#import "MyNavigationController.h"


@interface HNT_SYS_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic,strong) NSMutableArray * datas;
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;

@property (strong, nonatomic)  BBFlashCtntLabel *departName_Label2;
@property (nonatomic,copy) NSString * departId;//组织机构id
@property (nonatomic,copy)NSString *depName;//
@end

@implementation HNT_SYS_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addPanGestureRecognizer];
    [self loadUI];
    _departId = [UserDefaultsSetting shareSetting].departId;
}
-(void)dealloc{
    FuncLog;
}
-(void)loadUI{
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HNT_SYS_Cell class] forCellReuseIdentifier:@"HNT_SYS_Cell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)searchButtonClick:(UIButton *)sender {
    [super pan];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArr = @[@"设计配合比",@"配比通知单",@"压力试验",@"万能试验",@"统计分析"];
    NSArray *imgArr = @[@"SJ_PHB",@"PB_TZD",@"SYS_YL",@"SYS_WN",@"SYS_TJ"];
    static NSString *cellId = @"CELLID";
    SYS_MAIN_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SYS_MAIN_Cell" owner:self options:nil] firstObject];
    }
    cell.title.text = titleArr[indexPath.row];
    cell.img.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row)
    {
        case 0:
        {
            //设计配合比
            SYS_PHBViewController *vc = [[SYS_PHBViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            //配比通知单
            SYS_TZDViewController *vc = [[SYS_TZDViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            //压力
//            HNT_YLSY_Controller *vc = [[HNT_YLSY_Controller alloc] init];
            HNT_YLSY_Controller *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_YLSY_Controller"];
            VC.userGroupId = _departId;
            VC.zt = @"1";
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3:
        {
            //万能
//            HNT_WNSY_Controller *vc = [[HNT_WNSY_Controller alloc] init];
            HNT_WNSY_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_WNSY_Controller"];
            ylVC.userGroupId = _departId;
//            ylVC.zt = @"1";
            [self.navigationController pushViewController:ylVC animated:YES];
        }
            break;
            
        default:
        {
            //统计分析
//            HNT_TJFX_Controller *vc = [[HNT_TJFX_Controller alloc] init];
//            vc.userGroupId = _departId;
            HNT_TJFX_Controller *ylVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNT_TJFX_Controller"];
            ylVC.zt = @"1";
            ylVC.userGroupId = _departId;
            [self.navigationController pushViewController:ylVC animated:YES];
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *headerImg = [UIImageView new];
    headerImg.image = [UIImage imageNamed:@"SYS_Header_IMG2.jpg"];
    return headerImg;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 38.0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSArray *titleArr = @[@"试验管理"];
//    UIView *headerView = [UIView new];
//    UILabel *titleLab = [UILabel new];
//    titleLab.frame = CGRectMake(15, 10, 150, 25);
//    titleLab.text = titleArr[section];
//    titleLab.textColor = BLUECOLOR;
//    [headerView addSubview:titleLab];
//    headerView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
//    return headerView;
//}

@end
