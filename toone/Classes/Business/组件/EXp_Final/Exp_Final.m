//
//  Exp_Final.m
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "Exp_Final.h"
#import "YS_SB_Controller.h"
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
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    _tabview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    _tabview.delegate = self;
    _tabview.dataSource = self;
    _tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabview.rowHeight = cell_rowHeight;
    [_tabview  registerNib:[UINib nibWithNibName:@"Exp_FinalCell" bundle:nil] forCellReuseIdentifier:@"Exp_FinalCell"];
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
    /*
     YS_Search_Type_StartStack = 0,
     YS_Search_Type_EndStack,
     YS_Search_Type_RoadID,
     YS_Search_Type_StartTime,
     YS_Search_Type_EndTime,
     YS_Search_Type_Layer
     */
    Exp_FinalModel *model = [_dataArr objectAtIndex:indexPath.row];

    if (model.type == YS_Search_Type_StartTime || model.type == YS_Search_Type_EndTime)
    {
        //时间选择
    }
    //其他压实选择
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
        default:
            break;
    }
    sbVc.YScallBlock = ^(NSString *name, NSNumber *num) {
        model.contentName = name;
        model.contentId = [NSString stringWithFormat:@"%@",num];
        [_dataArr setObject:model atIndexedSubscript:indexPath.row];
        [_tabview reloadData];
    };
    [[self viewController].navigationController pushViewController:sbVc animated:YES];
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

@end
