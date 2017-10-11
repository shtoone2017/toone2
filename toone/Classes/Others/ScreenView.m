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
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(40, 0, self.bounds.size.width-40, self.bounds.size.height-80) style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.rowHeight = 48;
    _tbView.sectionFooterHeight = 80;
    _tbView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_tbView];

    [self clearAllPara];
    
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeGes];
    
}

- (void)clearAllPara
{
    if (_type == ScreenViewTypeBF_JC)
    {
        self.paraDic = [NSMutableDictionary dictionaryWithDictionary:@{jinchangshijian1:@"",chuchangshijian1:@"",orgcode:@"",gprsbianha:@"",cailiaono:@""}];
        self.nameDic = [NSMutableDictionary dictionaryWithDictionary:@{LIST_JCTime1:@"",LIST_CCTime1:@"",LIST_ZZJG:@"",LIST_SB_NUM:@"",LIST_CL_NUM:@""}];
    }
    else if (_type == ScreenViewTypeLC)
    {
        self.nameDic = [NSMutableDictionary dictionaryWithDictionary:@{LC_Title_ZZJG:@"",LC_Title_CLMC:@""}];
        
        self.paraDic = [NSMutableDictionary dictionaryWithDictionary:@{LC_PARA_ZZJG:@"",LC_PARA_CLMC:@""}];
    }
    else if (_type == ScreenViewTypePHB)
    {
        self.paraDic = [NSMutableDictionary dictionaryWithDictionary:@{PHB_PARA_ZZJG:@"",PHB_PARA_SJQD:@"",PHB_PARA_TIME1:@"",PHB_PARA_TIME2:@""}];
        
        self.nameDic = [NSMutableDictionary dictionaryWithDictionary:@{PHB_Title_ZZJG:@"",PHB_Title_SJQD:@"",PHB_Title_TIME1:@"",PHB_Title_TIME2:@""}];
    }
    else if (_type == ScreenViewTypeTZD)
    {
        self.paraDic = [NSMutableDictionary dictionaryWithDictionary:@{TZD_PARA_ZZJG:@"",TZD_PARA_TIME1:@"",TZD_PARA_TIME2:@""}];
        
        self.nameDic = [NSMutableDictionary dictionaryWithDictionary:@{TZD_Title_ZZJG:@"",TZD_Title_TIME1:@"",TZD_Title_TIME2:@""}];
    }
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
                    cell.txtField.text = _nameDic[LIST_ZZJG];
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
                    cell.txtField.text = _nameDic[LIST_JCTime1];
                    
                }
                else if (indexPath.row == 4)
                {
                    cell.txtField.text = _nameDic[LIST_CCTime1];
                }
            }
        }
        else if(_type == ScreenViewTypeLC)
        {
            cell.txtField.enabled = NO; 
            if (indexPath.row == 0)
            {
                //所属机构
                cell.txtField.text = _nameDic[LC_Title_ZZJG];
            }
            else
            {
                //材料
                cell.txtField.text = _nameDic[LC_Title_CLMC];
            }
        }
        else if (_type == ScreenViewTypePHB)
        {
            cell.txtField.enabled = NO;
            NSArray *keys = @[PHB_Title_ZZJG,PHB_Title_SJQD,PHB_Title_TIME1,PHB_Title_TIME2];
            cell.txtField.text = [_nameDic objectForKey:[keys objectAtIndex:indexPath.row]];
        }
        else if (_type == ScreenViewTypeTZD)
        {
            cell.txtField.enabled = NO;
            NSArray *keys = @[TZD_Title_ZZJG,TZD_Title_TIME1,TZD_Title_TIME2];
            cell.txtField.text = [_nameDic objectForKey:[keys objectAtIndex:indexPath.row]];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == ScreenViewTypeBF_JC)
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
            vc.type = SBListTypeBF;
            vc.callBlock = ^(NSString *name, NSString *bfID) {
                [self.nameDic setObject:name forKey:LIST_SB_NUM];
                [self.paraDic setObject:bfID forKey:gprsbianha];
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
                    [self.nameDic setObject:cell.txtField.text forKey:LIST_JCTime1];
                    
                    if (cell.txtField.text.length > 0)
                    {
                        NSString *startTime = [TimeTools timeStampWithTimeString:cell.txtField.text];
                        [self.paraDic setObject:startTime forKey:jinchangshijian1];
                    }
                }
                else
                {
                    [self.nameDic setObject:cell.txtField.text forKey:LIST_CCTime1];
                    if (cell.txtField.text.length > 0)
                    {
                        NSString *endTime = [TimeTools timeStampWithTimeString:cell.txtField.text];
                        [self.paraDic setObject:endTime forKey:chuchangshijian1];
                    }
                    
                }
                
            };
            [vc calendarWithTimeString:nil obj:cell.txtField];
        }
    }
    else if(_type == ScreenViewTypeLC)
    {
        if (indexPath.row == 0)
        {
            //所属机构
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                [self.nameDic setObject: name forKey:LC_Title_ZZJG];
                [self.paraDic setObject:identifier forKey:LC_PARA_ZZJG];
            };
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
        else
        {
            //材料
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeCL;
            vc.CLBlock = ^(NSString *name, NSString *identifier) {
                [self.nameDic setObject: name forKey:LC_Title_CLMC];
                [self.paraDic setObject:identifier forKey:LC_PARA_CLMC];
            };
            
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
    }
    else if(_type == ScreenViewTypePHB)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                //所属机构
                NodeViewController *vc = [[NodeViewController alloc] init];
                vc.type = NodeTypeZZJG;
                vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                    [self.nameDic setObject: name forKey:PHB_Title_ZZJG];
                    [self.paraDic setObject:identifier forKey:PHB_PARA_ZZJG];
                };
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                vc.type = SBListTypeSJQD;
                vc.callBlock = ^(NSString *name, NSString *bfID) {
                    [self.nameDic setObject:name forKey:PHB_Title_SJQD];
                    [self.paraDic setObject:bfID forKey:PHB_PARA_SJQD];
                };
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
            {
                LabelTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                BFViewController *vc = (BFViewController *)[self viewController];
                vc.block = ^{
                    if (indexPath.row == 2)
                    {
                        [self.nameDic setObject:cell.txtField.text forKey:PHB_Title_TIME1];
                        if (cell.txtField.text.length > 0)
                        {
                            NSString *startTime = [TimeTools timeStampWithTimeString:cell.txtField.text];
                            [self.paraDic setObject:startTime forKey:PHB_PARA_TIME1];
                        }
                       
                    }
                    else
                    {
                        [self.nameDic setObject:cell.txtField.text forKey:PHB_Title_TIME2];
                        if (cell.txtField.text.length > 0)
                        {
                            NSString *endTime = [TimeTools timeStampWithTimeString:cell.txtField.text];
                            [self.paraDic setObject:endTime forKey:PHB_PARA_TIME2];
                            
                        }
                        
                    }
                    
                };
                [vc calendarWithTimeString:nil obj:cell.txtField];
            }
            break;
        }

    }
    else if(_type == ScreenViewTypeTZD)
    {
        if (indexPath.row == 0)
        {
            //所属机构
            NodeViewController *vc = [[NodeViewController alloc] init];
            vc.type = NodeTypeZZJG;
            vc.ZZJGBlock = ^(NSString *name, NSString *identifier) {
                [self.nameDic setObject: name forKey:TZD_Title_ZZJG];
                [self.paraDic setObject:identifier forKey:TZD_PARA_ZZJG];
            };
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1 || indexPath.row == 2)
        {
            LabelTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            BFViewController *vc = (BFViewController *)[self viewController];
            vc.block = ^{
                if (indexPath.row == 1)
                {
                    [self.nameDic setObject:cell.txtField.text forKey:TZD_Title_TIME1];
                    
                    if (cell.txtField.text.length > 0)
                    {
                        NSString *startTime = [TimeTools timeStampWithTimeString:cell.txtField.text];
                        [self.paraDic setObject:startTime forKey:TZD_PARA_TIME1];
                    }
                }
                else
                {
                    [self.nameDic setObject:cell.txtField.text forKey:TZD_Title_TIME2];
                    if (cell.txtField.text.length > 0)
                    {
                        NSString *endTime = [TimeTools timeStampWithTimeString:cell.txtField.text];
                        [self.paraDic setObject:endTime forKey:TZD_PARA_TIME2];
                    }
                }
                
            };
            [vc calendarWithTimeString:nil obj:cell.txtField];
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
        [self clearAllPara];
        [_tbView reloadData];
    }
    else
    {
        //查询
        [self hiddenAction];
        if (_paraBlock)
        {
            _paraBlock(_paraDic);
        }
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