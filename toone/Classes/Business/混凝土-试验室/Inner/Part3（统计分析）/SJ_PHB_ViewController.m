//
//  SJ_PHB_ViewController.m
//  toone
//
//  Created by 景晓峰 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SJ_PHB_ViewController.h"
#import "SJ_PHBModel.h"
#import "SJ_PHBCell.h"
#import "NodeViewController.h"
#import "HNT_BHZ_SB_Controller.h"


@interface SJ_PHB_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    TPKeyboardAvoidingTableView *_tbView;
    SJ_PHBModel *dataModel;
    BOOL _isChange;
    UIButton *rightBtn;
    NSMutableArray *_tfArr;
    NSArray *_keysArr;
}

@property (nonatomic,strong)NSMutableDictionary *paraDic;

@end

@implementation SJ_PHB_ViewController

- (NSMutableDictionary *)paraDic
{
    if (!_paraDic)
    {
        _paraDic = [NSMutableDictionary dictionary];
    }
    return _paraDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设计配合比";
    _tfArr = [NSMutableArray array];
    _keysArr = @[@"llphbno",@"kangshendengji",@"kangzhedu",@"fenliao1name",@"fenliao2name",@"guliao1name",@"guliao2name",@"guliao3name",@"guliao4name",@"fenliao3name",@"waijiaji1name",@"shuiname",@"fenliao1phb",@"fenliao2phb",@"guliao1phb",@"guliao2phb",@"guliao3phb",@"guliao4phb",@"fenliao3phb",@"waijiaji1phb",@"shuiphb",@"xishichanliang",@"jg3chanliang",@"heshachanliang",@"shuijiaobi",@"biaoguanmidu",@"fangliang",@"jusuosuanchanliang",@"shalv",@"remark"];
    
#warning 根据角色  以及状态  显示 修改 按钮
//    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 80, 20);
//    [rightBtn setTitle:@"修改" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(changeInfo) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self getData];
}

- (void)changeInfo
{
    rightBtn.hidden = YES;
    _isChange = YES;
    [_tbView reloadData];
}

- (void)setUpUI
{
    //创建列表
    _tbView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0,70,Screen_w,Screen_h-70) style:UITableViewStyleGrouped];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tbView.sectionFooterHeight = 0.00001;
    _tbView.estimatedRowHeight = 30.0;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
}

- (void)getData
{
    NSString *urlString = [NSString stringWithFormat:@"%@appWZSys.do?AppLilunPeihebiCK",baseUrl];
    WS(weakSelf);
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString parmas:@{@"llphbno":_detailNum} completeBlock:^(id result) {
        if (result && result != nil)
        {
            NSDictionary *dict = (NSDictionary *)result;
            dataModel = [[SJ_PHBModel alloc] initWithDictionary:dict[@"data"] error:nil];
        }
        [weakSelf setUpUI];
    }];
    
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId;
    if (indexPath.section == 0)
    {
        cellId = @"SJ_PHBCell1";
    }
    else if (indexPath.section == 1)
    {
        cellId = @"SJ_PHBCell2";
    }
    else
    {
        cellId = @"SJ_PHBCell3";
    }
    
    SJ_PHBCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SJ_PHBCell" owner:self options:nil] objectAtIndex:indexPath.section];
        if (indexPath.section == 0)
        {
            cell.SJ_BH_TF.text = dataModel.llphbno;
            cell.SJ_KZD_TF.text = dataModel.kangzhedu;
            cell.SJ_KSDJ_TF.text = dataModel.kangshendengji;
            [cell.SJ_TLD_Btn setTitle:dataModel.tanluodu forState:UIControlStateNormal];
            [cell.SJ_SJQD_Btn setTitle:dataModel.sjqd forState:UIControlStateNormal];
            [cell.SJ_ZZJG_Btn setTitle:dataModel.departname forState:UIControlStateNormal];
            WS(weakSelf);
            cell.block = ^(NSInteger senderTag,UIButton *sender)
            {
                switch (senderTag)
                {
                    case 100:
                    {
                        //组织机构
                        NodeViewController *vc = [[NodeViewController alloc] init];
                        vc.type = NodeTypeZZJG;
                        vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                            [weakSelf.paraDic setObject:identifier forKey:@"departId"];
                            
//                            SJ_PHBCell *cell = [_tbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                            [sender setTitle:name forState:UIControlStateNormal];
                        };
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 101:
                    {
                        //设计强度
                        HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                        vc.type = SBListTypeSJQD;
                        vc.callBlock = ^(NSString *name, NSString *bfID) {
                            [weakSelf.paraDic setObject:bfID forKey:@"sjqd"];
                            [sender setTitle:name forState:UIControlStateNormal];
                        };
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 102:
                    {
                        //塌落度
                        HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                        vc.type = SBListTypeTLD;
                        vc.callBlock = ^(NSString *name, NSString *bfID) {
                            [weakSelf.paraDic setObject:bfID forKey:@"tanluodu"];
                            [sender setTitle:name forState:UIControlStateNormal];
                        };
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    default:
                        break;
                }
            };
        }
        else if (indexPath.section == 1)
        {
            cell.SJ_YC_SN_NAME.text = dataModel.fenliao1mingzi;
            cell.SJ_YC_SN_PB.text = dataModel.fenliao1phb;
            cell.SJ_YC_FM_NAME.text = dataModel.fenliao2mingzi;
            cell.SJ_YC_FM_PB.text = dataModel.fenliao2phb;
            cell.SJ_YC_XG_NAME.text = dataModel.guliao1mingzi;
            cell.SJ_YC_XG_PB.text = dataModel.guliao1phb;
            cell.SJ_YC_CG1_NAME.text = dataModel.guliao2mingzi;
            cell.SJ_YC_CG1_PB.text = dataModel.guliao2phb;
            cell.SJ_YC_CG2_NAME.text = dataModel.guliao3mingzi;
            cell.SJ_YC_CG2_PB.text = dataModel.guliao3phb;
            cell.SJ_YC_CG3_NAME.text = dataModel.guliao4mingzi;
            cell.SJ_YC_CG3_PB.text = dataModel.guliao4phb;
            cell.SJ_YC_KF_NAME.text = dataModel.fenliao3mingzi;
            cell.SJ_YC_KF_PB.text = dataModel.fenliao3phb;
            cell.SJ_YC_WJJ_NAME.text = dataModel.waijiaji1mingzi;
            cell.SJ_YC_WJJ_PB.text = dataModel.waijiaji1phb;
            cell.SJ_YC_Shui_NAME.text = dataModel.shuimingzi;
            cell.SJ_YC_Shui_PB.text = dataModel.shuiphb;
        }
        else
        {
            cell.SJ_CL_XS.text = dataModel.xishichanliang;
            cell.SJ_CL_JG3.text = dataModel.jg3chanliang;
            cell.SJ_CL_HS.text = dataModel.heshachanliang;
            cell.SJ_CL_SHB.text = dataModel.shuiphb;
            cell.SJ_CL_BGMD.text = dataModel.biaoguanmidu;
            cell.SJ_CL_RL.text = dataModel.fangliang;
            cell.SJ_CL_JSSCL.text = dataModel.jusuosuanchanliang;
            cell.SJ_CL_SL.text = dataModel.shalv;
            cell.SJ_CL_BZ.text = dataModel.remark;
        }
    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    NSArray *subViews = [cell.contentView subviews];
    for (id view in subViews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField *tempTF = (UITextField *)view;
            if (_isChange)
            {
                tempTF.enabled = YES;
                tempTF.backgroundColor = [UIColor lightGrayColor01];
            }
            else
            {
                tempTF.enabled = NO;
                tempTF.backgroundColor = [UIColor whiteColor];
            }
        }
        else if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *tempBtn = (UIButton *)view;
            if (_isChange)
            {
                tempBtn.enabled = YES;
                tempBtn.backgroundColor = [UIColor lightGrayColor01];
            }
            else
            {
                tempBtn.enabled = NO;
                tempBtn.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 2)
//    {
//        return 80;
//    }
//    return 0.0001;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//    if (section == 2)
//    {
//        NSArray *titleArr;
//        if (_isChange)
//        {
//            titleArr = @[@"退出",@"保存"];
//        }
//        else
//        {
//            titleArr = @[@"删除",@"提交"];
//        }
//        UIView *footer = [UIView new];
//        for (int i = 0; i<2; i++)
//        {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//            if (i==0)
//            {
//                btn.frame = CGRectMake(self.view.bounds.size.width/2-30-80, 20, 80, 30);
//            }
//            else
//            {
//                btn.frame = CGRectMake(self.view.bounds.size.width/2+30, 20, 80, 30);
//            }
//            btn.layer.cornerRadius = 5;
//            btn.layer.masksToBounds = YES;
//            btn.backgroundColor = BLUECOLOR;
//            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
//            [footer addSubview:btn];
//        }
//        return footer;
//    }
//    return nil;
//}

- (void)btnAction:(UIButton *)btn
{
    WS(weakSelf);
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"是否%@?",btn.titleLabel.text] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([btn.titleLabel.text isEqualToString:@"保存"])
        {
            //获取到所有的textfield
            if (_tfArr && _tfArr.count > 0)
            {
                [_tfArr removeAllObjects];
            }
            for (int i = 0; i<3; i++)
            {
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
                SJ_PHBCell *cell = [_tbView cellForRowAtIndexPath:index];
                if (!cell)
                {
                    cell = (SJ_PHBCell *)[weakSelf tableView:_tbView cellForRowAtIndexPath:index];
                }
                
                NSArray *subViews = [cell.contentView subviews];
                for (id view in subViews)
                {
                    if ([view isKindOfClass:[UITextField class]])
                    {
                        UITextField *tempTF = (UITextField *)view;
                        [_tfArr addObject:tempTF];
                    }
                }
            }
            
            //将所有的textfield上的内容赋值给参数字典
            for (int i = 0; i<_keysArr.count; i++)
            {
                UITextField *tf = _tfArr[i];
                [weakSelf.paraDic setObject:tf.text forKey:_keysArr[i]];
            }
            
            //将btn上的内容加上去
            NSArray *btnKeyArr = @[@"departId",@"sjqd",@"tanluodu"];
            for (int i = 0; i<btnKeyArr.count; i++)
            {
                if ([weakSelf checkHasKey:btnKeyArr[i]] == NO)
                {
                    switch (i) {
                        case 0:
                            [weakSelf.paraDic setObject:dataModel.departid forKey:btnKeyArr[i]];
                            break;
                        case 1:
                            [weakSelf.paraDic setObject:dataModel.sjqd forKey:btnKeyArr[i]];
                            break;
                        case 2:
                            [weakSelf.paraDic setObject:dataModel.tanluodu forKey:btnKeyArr[i]];
                            break;
                            
                        default:
                            break;
                    }
                    
                }
            }
            [weakSelf requestToEdit];
            
        }
        else if([btn.titleLabel.text isEqualToString:@"退出"])
        {
            _isChange = NO;
            rightBtn.hidden = NO;
            [_tbView reloadData];
        }
        else if([btn.titleLabel.text isEqualToString:@"提交"])
        {
            
        }
        else
        {
            //删除
            
        }
    }];
    [alertCtr addAction:cancelAction];
    [alertCtr addAction:okAction];
    [self presentViewController:alertCtr animated:YES completion:nil];
}

- (BOOL)checkHasKey:(NSString *)keyStr
{
    for (NSString *akey in [_paraDic allKeys])
    {
        if ([akey isEqualToString:keyStr])
        {
            return YES;
        }
        break;
    }
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titleArr = @[@"基本信息",@"原材设置",@"掺量信息"];
    UIView *headerView = [UIView new];
    UILabel *titleLab = [UILabel new];
    titleLab.frame = CGRectMake(25, 10, 150, 25);
    titleLab.text = titleArr[section];
    titleLab.textColor = BLUECOLOR;
    [headerView addSubview:titleLab];
    //    headerView.backgroundColor = [UIColor yellowColor];
    return headerView;
}

- (void)requestToEdit
{
    NSString *urlString = [NSString stringWithFormat:@"%@appWZSys.do?AppsjphbEdit",baseUrl];
    WS(weakSelf);
    [[NetworkTool sharedNetworkTool] postObjectWithURLString:urlString parmas:_paraDic completeBlock:^(id result) {
        if (result && result != nil)
        {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
