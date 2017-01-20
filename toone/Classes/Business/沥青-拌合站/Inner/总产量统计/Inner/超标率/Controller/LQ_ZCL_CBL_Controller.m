//
//  LQ_ZCL_CBL_Controller.m
//  toone
//
//  Created by shtoone on 17/1/11.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_ZCL_CBL_Controller.h"

#import "LQ_ZCL_CB1_Cell.h"
#import "LQ_ZCL_CL_Model.h"
#import "NetworkTool.h"

@interface LQ_ZCL_CBL_Controller ()
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) LQ_ZCL_CL_Model *model;
@property (nonatomic, assign) int leix;
@property (nonatomic, strong) NSMutableArray *chaoX;
@property (nonatomic, strong) NSMutableArray *chaoBiaoDatas;

@end
@implementation LQ_ZCL_CBL_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setUI];
    //初始化加载
    NSString *shebStr = @"";
    NSString *userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString *startTimeStamp = [TimeTools timeStampWithTimeString:super.startTime];
    NSString *endTimeStamp = [TimeTools timeStampWithTimeString:super.endTime];
    NSString *leixing = @"2";//时间种类
    NSString *urlString = [NSString stringWithFormat:LQTotal,shebStr,startTimeStamp,endTimeStamp,userGroupId,leixing];
    [self reloadData:urlString];
}

-(void)setUI {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.frame = CGRectMake(0, 100, Screen_w, Screen_h);
//    [self.tableView registerNib:[UINib nibWithNibName:@"LQ_ZCL_CB_Cell" bundle:nil] forCellReuseIdentifier:@"LQ_ZCL_CB_Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LQ_ZCL_CB1_Cell" bundle:nil] forCellReuseIdentifier:@"LQ_ZCL_CB1_Cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)reloadData:(NSString *)urlString {
  
    self.urlString = urlString;
    __weak typeof(self)  weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        NSMutableArray * datas = [NSMutableArray array];
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *chaoBiaoAxisNames= [NSMutableArray array];
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict[@"success"] boolValue]) {

            for (NSDictionary * dic in dict[@"data"]) {
                weakSelf.model = [LQ_ZCL_CL_Model modelWithDict:dic];
                [datas addObject:weakSelf.model];
                 NSMutableArray *subArray = [NSMutableArray array];
                [subArray addObject:weakSelf.model.highPer];
                [subArray addObject:weakSelf.model.middlePer];
                [subArray addObject:weakSelf.model.primaryPer];
                [array addObject:subArray];
                [chaoBiaoAxisNames addObject:[NSString stringWithFormat:@"%@-%@",weakSelf.model.xa,weakSelf.model.xb]];
            }
            
            weakSelf.chaoBiaoDatas = array;
            weakSelf.datas = datas;
            weakSelf.chaoX = chaoBiaoAxisNames;
            [weakSelf.tableView reloadData];
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 330;
    }else{
        return  self.datas ? 20*self.datas.count : 1.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LQ_ZCL_CB1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQ_ZCL_CB1_Cell"];
        [cell method:self.chaoBiaoDatas axisNames:_chaoX];
        //改变时间种类
        NSString *lexing = [self getParamValueFromUrl:self.urlString paramName:@"leixing"];
        self.leix = [lexing intValue];
        [cell muLabel:self.leix];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        int index = 0;
//        [cell.contentView removeFromSuperview];
//        [cell.contentView.layer removeFromParentViewController];
        for (LQ_ZCL_CL_Model * model in self.datas) {
            CGFloat w = (self.view.bounds.size.width -20)/4;
            UILabel * label1 = [[UILabel alloc] init];
            label1.frame = CGRectMake(10, index*20.0,w, 20);
            label1.text = [NSString stringWithFormat:@"%@-%@",model.xa,model.xb];
            label1.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:label1];
            
            UILabel * label2 = [[UILabel alloc] init];
            label2.frame = CGRectMake(10+w, index*20.0,w, 20);
            label2.text =model.highps;
            label2.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label2];
            
            UILabel * label3 = [[UILabel alloc] init];
            label3.frame = CGRectMake(10+2*w, index*20.0,w, 20);
            label3.text =model.middleps;
            label3.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label3];
            
            UILabel * label4 = [[UILabel alloc] init];
            label4.frame = CGRectMake(10+3*w, index*20.0,w, 20);
            label4.textAlignment = NSTextAlignmentCenter;
            label4.text =  model.primaryps;
            [cell.contentView addSubview:label4];
            
            label1.font = [UIFont systemFontOfSize:12.0];
            label1.textColor = [UIColor lightGrayColor];
            label2.font = [UIFont systemFontOfSize:12.0];
            label2.textColor = [UIColor lightGrayColor];
            label3.font = [UIFont systemFontOfSize:12.0];
            label3.textColor = [UIColor lightGrayColor];
            label4.font = [UIFont systemFontOfSize:12.0];
            label4.textColor = [UIColor lightGrayColor];
            label1.backgroundColor = [UIColor whiteColor];
            label2.backgroundColor = [UIColor whiteColor];
            label3.backgroundColor = [UIColor whiteColor];
            label4.backgroundColor = [UIColor whiteColor];
            
            index++;
        }
        return cell;
    }
    return nil;
}
//截取URL参数
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

@end
