//
//  SYS_ScanningController.m
//  toone
//
//  Created by 上海同望 on 2017/11/30.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SYS_ScanningController.h"
#import "SYS_Scanning_HeadCell.h"
#import "SYS_Scanning_DataCell.h"

@interface SYS_ScanningController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic,strong) NSArray *time;
@property (nonatomic,strong) NSArray *name;

@end
@implementation SYS_ScanningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadUI];
    [self loadData];
}

-(void)loadData {
    if (_conditonDict[@"startTime"]) {
        _time = [_conditonDict[@"startTime"] componentsSeparatedByString:@"&"];
        _name = [_conditonDict[@"userName"] componentsSeparatedByString:@"&"];
    }
}

-(void)loadUI {
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    self.tb.separatorColor = [UIColor clearColor];
    [self.tb registerNib:[UINib nibWithNibName:@"SYS_Scanning_HeadCell" bundle:nil] forCellReuseIdentifier:@"SYS_Scanning_HeadCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"SYS_Scanning_DataCell" bundle:nil] forCellReuseIdentifier:@"SYS_Scanning_DataCell"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.name.count+1?:1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 250;
    }else{
        
        return 20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SYS_Scanning_HeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SYS_Scanning_HeadCell"];
        cell.dayLabel.text = _conditonDict[@"lq"];
        if (_time.count) {
            cell.starLabel.text = [[NSString stringWithFormat:@"%@",_time[0]] substringToIndex:11];;
            cell.endLabel.text = [[NSString stringWithFormat:@"%@",[_time lastObject]] substringToIndex:11];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }else{
        SYS_Scanning_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SYS_Scanning_DataCell"];
        cell.startTime.text = self.time[indexPath.row-1];
        cell.userName.text = self.name[indexPath.row-1];
        cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return nil;
}

@end
