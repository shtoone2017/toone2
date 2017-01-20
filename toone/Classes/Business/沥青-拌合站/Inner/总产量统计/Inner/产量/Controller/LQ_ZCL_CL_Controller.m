//
//  LQ_ZCL_CL_Controller.m
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_ZCL_CL_Controller.h"
#import "LQ_ZCL_CL_Model.h"
#import "LQ_ZCL_Cl_Cell.h"
#import "LQ_ZCL_CL1_Cell.h"
#import "NetworkTool.h"
#import "BarModel.h"

@interface LQ_ZCL_CL_Controller ()
@property (nonatomic, strong) LQ_ZCL_CL_Model *model;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray * datas1;
@property (nonatomic, assign) int leix;
@property (nonatomic, copy) NSString *urlString;

@end
@implementation LQ_ZCL_CL_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //初始化加载
    NSString *shebStr = @"";
    NSString *userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *startTimeStamp = [TimeTools timeStampWithTimeString:super.startTime];
    NSString *endTimeStamp = [TimeTools timeStampWithTimeString:super.endTime];
    NSString *leixing = @"1";//季度
    NSString *urlString = [NSString stringWithFormat:LQTotal,shebStr,startTimeStamp,endTimeStamp,userGroupId,leixing];
    [self reloadData:urlString];
}

-(void)setUI {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.frame = CGRectMake(0, 100, Screen_w, Screen_h);
    [self.tableView registerNib:[UINib nibWithNibName:@"LQ_ZCL_Cl_Cell" bundle:nil] forCellReuseIdentifier:@"LQ_ZCL_Cl_Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LQ_ZCL_CL1_Cell" bundle:nil] forCellReuseIdentifier:@"LQ_ZCL_CL1_Cell"];
}

-(void)reloadData:(NSString *)urlString {
    self.urlString = urlString;
    __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSMutableArray * datas = [NSMutableArray array];
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict[@"success"] boolValue]) {
            for (NSDictionary * dic in dict[@"data"]) {
                weakSelf.model = [LQ_ZCL_CL_Model modelWithDict:dic];
                [datas addObject:weakSelf.model];
            }
        }else {
            
        }
        NSMutableArray * bars1 = [NSMutableArray array];
        for (LQ_ZCL_CL_Model * model in datas) {
            BarModel * bar1 = [[BarModel alloc] init];
            bar1.name = [NSString stringWithFormat:@"%@-%@",model.xa,model.xb];
            bar1.value = model.changliang;
            [bars1 addObject:bar1];
        }
        weakSelf.datas1 = bars1;
        weakSelf.datas = datas;
        [self.tableView reloadData];
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count +1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 420;
    }else{
        return 20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LQ_ZCL_Cl_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_ZCL_Cl_Cell"];
        cell.datas1 = self.datas1;
        //改变时间名称
        NSString *lexing = [self getParamValueFromUrl:self.urlString paramName:@"leixing"];
        self.leix = [lexing intValue];
        [cell muLabel:self.leix];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LQ_ZCL_CL1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_ZCL_CL1_Cell"];
        LQ_ZCL_CL_Model * model = self.datas[indexPath.row-1];
        [cell model:model withIndex:indexPath.row];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(NSString *)getParamValueFromUrl:(NSString *)url paramName:(NSString *)paramName
{
    if (![paramName hasSuffix:@"="]) {
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    NSString *str = nil;
    NSRange   start = [url rangeOfString:paramName];
    if (start.location != NSNotFound) {
        unichar  c = '?';
        if (start.location != 0) {
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#') {
            NSRange     end = [[url substringFromIndex:start.location + start.length] rangeOfString:@"&"];
            NSUInteger  offset = start.location + start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return str;
}

-(NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(NSMutableArray *)datas1 {
    if (!_datas1) {
        _datas1 = [NSMutableArray array];
    }
    return _datas1;
}

@end



