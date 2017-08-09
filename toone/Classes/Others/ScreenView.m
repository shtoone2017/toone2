//
//  ScreenView.m
//  toone
//
//  Created by 景晓峰 on 2017/8/7.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ScreenView.h"
#import "LabelTextFieldCell.h"
#import "NodeViewController.h"
#import "HNT_BHZ_SB_Controller.h"
#import "BFViewController.h"
#import "CJCalendarViewController.h"



@interface ScreenView()<UITableViewDelegate,UITableViewDataSource,CalendarViewControllerDelegate>

@property (nonatomic,assign) BOOL isShow;

@property (nonatomic,strong) NSMutableDictionary *nameDic;  //显示内容

@property (nonatomic,strong) BFViewController *parentVC;

@end

@implementation ScreenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BFViewController *)parentVC
{
    if (!_parentVC)
    {
        _parentVC = (BFViewController *)[self viewController];
    }
    return _parentVC;
}

- (NSMutableDictionary *)paraDic
{
    if (!_paraDic) {
        _paraDic = [NSMutableDictionary dictionary];
    }
    return _paraDic;
}

- (NSMutableDictionary *)nameDic
{
    if (!_nameDic) {
        _nameDic = [NSMutableDictionary dictionary];
    }
    return _nameDic;
}


- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr type:(NSInteger)type
{
    if (self == [super initWithFrame:frame])
    {
        _titleArr = titleArr;
        _type = type;
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.rowHeight = 70;
    _tbView.sectionFooterHeight = 80;
//    _tbView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_tbView];
    
//    jinchangshijian1 true 进场时间1
//    jinchangshijian2 true 进场时间2
//    chuchangshijian1 true 出场时间1
//    chuchangshijian2 true 出场时间2
//    orgcode true 组织机构编号
//    pageNo true 当前页
//    maxPageItems true 每页条数
//    pici true 批次
//    cheliangbianhao true 车辆编号
//    gprsbianhao true 设备编号（shebeibianhao）
//    cailiaono
    if (_type == ScreenViewTypeBF_JC)
    {
        self.paraDic = [NSMutableDictionary dictionaryWithDictionary:@{jinchangshijian1:@"",jinchangshijian2:@"",cheliangbianhao:@"",orgcode:@"",pici:@"",gprsbianhao:@"",cailiaono:@""}];
    }
    
    
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeGes];
    
}

- (void)hiddenAction
{
    _isShow = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(Screen_w, 0, weakSelf.bounds.size.width, weakSelf.bounds.size.height);
        if (_block)
        {
            _block(_isShow);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = [NSString stringWithFormat:@"cellId%ld%ld",(long)indexPath.section,(long)indexPath.row];
    LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelTextFieldCell" owner:self options:nil] lastObject];
        cell.lab.text = _titleArr[indexPath.row];
        if (_type == ScreenViewTypeBF_JC)
        {
            if (indexPath.row < 5)
            {
                cell.txtField.enabled = NO;
                if (indexPath.row == 0)
                {
                    //所属机构
                    NSString *txtStr = _nameDic[LIST_ZZJG];
                    cell.txtField.text = txtStr;
//                    NSLog(@"组织结构:    %@",[UserDefaultsSetting shareSetting].departId);
                }
                else if (indexPath.row == 1)
                {
                    //磅房
                    cell.txtField.text = _nameDic[LIST_SB_NUM];
                }
                else if (indexPath.row == 2)
                {
                    //材料
                    cell.txtField.text = _nameDic[LIST_CL_NUM];
                }
                else if (indexPath.row == 3)
                {
                    if (!_nameDic[LIST_JCTime1]) {
                        cell.txtField.text = self.parentVC.startTime;
                    }
                    else
                    {
                        cell.txtField.text = _nameDic[LIST_JCTime1];
                    }
                }
                else if (indexPath.row == 4)
                {
                    if (!_nameDic[LIST_JCTime2]) {
                        cell.txtField.text = self.parentVC.endTime;
                    }
                    else
                    {
                        cell.txtField.text = _nameDic[LIST_JCTime2];
                    }
                }
                    
            }
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == ScreenViewTypeBF_JC)
    {
        if (indexPath.row < 5)
        {
            if (indexPath.row == 0)
            {
                //所属机构
                NodeViewController *vc = [[NodeViewController alloc] init];
                vc.type = NodeTypeZZJG;
                vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                    [self.nameDic setObject: name forKey:LIST_ZZJG];
                    [self.paraDic setObject:identifier forKey:orgcode];
                };
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
            else if(indexPath.row == 1)
            {
                //磅房设备列表
                HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                vc.type = ScreenViewTypeBF_JC;
                vc.callBlock = ^(NSString *name, NSString *bfID) {
                    [self.nameDic setObject:name forKey:LIST_SB_NUM];
                    [self.paraDic setObject:bfID forKey:gprsbianhao];
                };
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row == 2)
            {
                //材料
                NodeViewController *vc = [[NodeViewController alloc] init];
                vc.type = NodeTypeCL;
                vc.CLBlock = ^(NSString *name, NSString *identifier) {
                    [self.nameDic setObject: name forKey:LIST_CL_NUM];
                    [self.paraDic setObject:identifier forKey:cailiaono];
                };
                
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row == 3 || indexPath.row == 4)
            {
                LabelTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                BFViewController *vc = (BFViewController *)[self viewController];
                vc.block = ^{
                    if (indexPath.row == 3)
                    {
                        [self.nameDic setObject:cell.txtField.text forKey:jinchangshijian1];
                        [self.paraDic setObject:cell.txtField.text forKey:LIST_JCTime1];
                    }
                    else
                    {
                        [self.nameDic setObject:cell.txtField.text forKey:jinchangshijian2];
                        [self.paraDic setObject:cell.txtField.text forKey:LIST_JCTime2];
                    }
                   
                };
                [vc calendarWithTimeString:nil obj:cell.txtField];
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    NSArray *titleArr = @[@"重置",@"查询"];
    for (int i = 0; i<2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = 100+i;
        if (i==0)
        {
            btn.frame = CGRectMake(self.bounds.size.width/2-30-80, 30, 80, 30);
        }
        else
        {
            btn.frame = CGRectMake(self.bounds.size.width/2+30, 30, 80, 30);
        }
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = BLUECOLOR;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
    }
    return footerView;
}

- (void)btnAction:(UIButton *)sender
{
    if (sender.tag == 100)
    {
        //重置
        
    }
    else
    {
        //查询
        
    }
}


//获取view的controller
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
