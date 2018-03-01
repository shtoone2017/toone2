//
//  Exp_Final.m
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "Exp_Final.h"
#import "YS_SB_Controller.h"
#import "SGymd.h"

#define cell_rowHeight 46
@interface Exp_Final()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabview;

@end

@implementation Exp_Final

- (void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    [_tabview reloadData];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (kDevice_Is_iPhoneX) {
        self.frame = CGRectMake(0, 88, Screen_w, Screen_h-64);
    }else {
        self.frame = CGRectMake(0, 64, Screen_w, Screen_h-64);
    }
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    _tabview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    _tabview.delegate = self;
    _tabview.dataSource = self;
    _tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabview.rowHeight = cell_rowHeight;
    [_tabview  registerNib:[UINib nibWithNibName:@"Exp_FinalCell" bundle:nil] forCellReuseIdentifier:@"Exp_FinalCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(huifangReloadTableview:) name:Notification_HuiFang object:nil];
}

- (void)huifangReloadTableview:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    Exp_FinalModel *model = [_dataArr objectAtIndex:[[dic objectForKey:@"rowNum"] integerValue]];
    model.contentName = [dic objectForKey:@"time"];
    [_dataArr setObject:model atIndexedSubscript:[[dic objectForKey:@"rowNum"] integerValue]];
    [_tabview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Exp_FinalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Exp_FinalCell"];
    Exp_FinalModel *model = [_dataArr objectAtIndex:indexPath.row];
    cell.titleLab.text = model.title;
    cell.contentLab.text = model.contentName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Exp_FinalModel *model = [_dataArr objectAtIndex:indexPath.row];

    if (model.type == YS_Search_Type_StartTime || model.type == YS_Search_Type_EndTime)
    {
        //时间选择
        NSDate *date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        NSString *dateStr = [formatter stringFromDate:date];
        ((MyViewController *)[self viewController]).isDetailSecond = YES;
         [(MyViewController *)[self viewController] calendarWithTimeString:dateStr obj:nil];
        ((MyViewController *)[self viewController]).dateBlock = ^(NSString *dateStr) {
            model.contentName = dateStr;
            model.contentId = dateStr;
            [_dataArr setObject:model atIndexedSubscript:indexPath.row];
            [_tabview reloadData];
        };
        return;
    }
    if (model.type == YS_Search_Type_StarTime || model.type == YS_Search_Type_EndTimes) {
        SGymd *ymd = [[SGymd alloc] init];
        ymd.block = ^(NSString * string){
            model.contentName = string;
            model.contentId = string;
            [_dataArr setObject:model atIndexedSubscript:indexPath.row];
            [_tabview reloadData];
        };
        return;
    }
    //其他压实选择
    if (model.type == YS_Search_Type_None)
    {
        //不跳转
        if (_CellBlock)
        {
            _CellBlock(indexPath.row);
        }
    }
    else
    {
        YS_SB_Controller *sbVc = [[YS_SB_Controller alloc] init];
        switch (model.type)
        {
            case YS_Search_Type_StartStack||YS_Search_Type_EndStack:
                sbVc.type = SBListTypeYSZH;
                break;
            case YS_Search_Type_RoadID:
                sbVc.type = SBListTypeYSLX;
                break;
            case YS_Search_Type_Layer:
                sbVc.type = SBListTypeYSMC;
                break;
            case YS_Search_Type_Divce_YLJ:
                sbVc.type = SBListTypeYSSB_YLJ;
                break;
            case YS_Search_Type_Divce_TPJ:
                sbVc.type = SBListTypeYSSB_TPJ;
                break;
            case YS_Search_Type_Divce_YLJ_Zuobiao:
                sbVc.type = SBListTypeYSSB_YLJ_Zuobiao;
                break;
            default:
                break;
        }
        [[self viewController].navigationController pushViewController:sbVc animated:YES];
        sbVc.YScallBlock = ^(NSString *name,  id num) {
            //设备实时坐标 传model,其他传id字符串
            if (sbVc.type == SBListTypeYSSB_YLJ_Zuobiao)
            {
                model.tempModel = num;
            }
            else
            {
                model.contentId = num;
            }
            model.contentName = name;
            [self.dataArr setObject:model atIndexedSubscript:indexPath.row];
            [_tabview reloadData];
        };
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((Screen_w-120)/2, 30, 120, 30);
    [btn setTitle:@"查询" forState:(UIControlStateNormal)];
    btn.backgroundColor = [UIColor colorWithRed:27/255.0f green:169/255.0f blue:212/255.0f alpha:1];
    [btn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:btn];
    return footer;
}

- (IBAction)closeAction:(id)sender {
//    [UIView animateWithDuration:0.15 animations:^{
//
//        self.transform = CGAffineTransformMakeScale(1, 0.0001);
//    } completion:^(BOOL finished) {
//
//        [self removeFromSuperview];
//    }];
    [self removeFromSuperview];
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)searchAction
{
    [self removeFromSuperview];
    if (_SearchBlock)
    {
        _SearchBlock(_dataArr);
    }
}

@end
