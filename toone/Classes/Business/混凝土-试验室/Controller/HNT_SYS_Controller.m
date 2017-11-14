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
@interface HNT_SYS_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic,strong) NSMutableArray * datas;
//@property (nonatomic,strong)  SW_ZZJG_Data * condition;
//@property (weak, nonatomic) IBOutlet UIView *containerView;
//@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;
@end

@implementation HNT_SYS_Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addPanGestureRecognizer];
    [self loadUI];
//    [self loadData];
}
-(void)dealloc{
    FuncLog;
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
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArr = @[@"压力试验",@"万能试验",@"统计分析"];
    NSArray *imgArr = @[@"SYS_YL",@"SYS_WN",@"SYS_TJ"];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HNT_SYS_FrameModel * frameModel = self.datas[indexPath.row];
//    HNT_SYS_Model * model = frameModel.models.firstObject;
//    [self performSegueWithIdentifier:@"HNT_SYS_InnerController" sender:model.userGroupId];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
