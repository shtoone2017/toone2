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

#define BF_SB_Name @"BF_SB_Name"
#define BF_SB_ID @"BF_SB_ID"

@interface ScreenView()<UITableViewDelegate,UITableViewDataSource,CalendarViewControllerDelegate>

@property (nonatomic,strong) NSMutableDictionary *paraDic;  //参数字典

@property (nonatomic,assign) BOOL isShow;

@end

@implementation ScreenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableDictionary *)paraDic
{
    if (!_paraDic) {
        _paraDic = [NSMutableDictionary dictionary];
    }
    return _paraDic;
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
//    _tbView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_tbView];
    
    self.paraDic = [NSMutableDictionary dictionaryWithDictionary:@{BF_SB_Name:@"",BF_SB_ID:@""}];
    
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
        if (_type == ScreenViewTypeBF)
        {
            if (indexPath.row < 4)
            {
                cell.txtField.enabled = NO;
                if (indexPath.row == 0)
                {
                    //所属机构
                    NSString *txtStr = [UserDefaultsSetting shareSetting].departName;
                    cell.txtField.text = txtStr;
//                    NSLog(@"组织结构:    %@",[UserDefaultsSetting shareSetting].departId);
                }
                else if (indexPath.row == 1)
                {
                    //磅房
                    cell.txtField.text = _paraDic[BF_SB_Name];
                }
                else if (indexPath.row == 2)
                {
                    //材料
                }
                else if (indexPath.row == 3)
                {
                    //时间
                    BFViewController *vc = (BFViewController *)[self viewController];
                    if (vc.selectTime)
                    {
                        cell.txtField.text = vc.selectTime;
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
    if (_type == ScreenViewTypeBF)
    {
        if (indexPath.row < 4)
        {
            if (indexPath.row == 0)
            {
                //所属机构
                NodeViewController *vc = [[NodeViewController alloc] init];
                vc.type = NodeTypeZZJG;
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
            else if(indexPath.row == 1)
            {
                //磅房设备列表
                HNT_BHZ_SB_Controller *vc = [[HNT_BHZ_SB_Controller alloc] init];
                vc.type = ScreenViewTypeBF;
                vc.callBlock = ^(NSString *name, NSString *bfID) {
                    [self.paraDic setObject:name forKey:BF_SB_Name];
                    [self.paraDic setObject:bfID forKey:BF_SB_ID];
                };
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row == 2)
            {
                //材料
                NodeViewController *vc = [[NodeViewController alloc] init];
                vc.type = NodeTypeCL;
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row == 3)
            {
                BFViewController *vc = (BFViewController *)[self viewController];
                [vc calendarWithTimeString:nil obj:nil];
            }
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
