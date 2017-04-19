
//
//  DataVC.m
//  toone
//
//  Created by sg on 2017/4/19.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "DataVC.h"

@interface DataVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tb;

@end

@implementation DataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.tb  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.callBlock) {
        self.callBlock(self.datas[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
