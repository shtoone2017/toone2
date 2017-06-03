//
//  TP_SB_Controller.m
//  toone
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_CLSB_Controller.h"
#import "TP_SB_Model2.h"
#import "MyNavigationController.h"
#define LIGHTRED                SGCOLOR(250, 105, 107, 1.0)
@interface TP_CLSB_Controller ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic ,copy) NSString * machineType;
@property (nonatomic,strong) NSArray * datas;
@end

@implementation TP_CLSB_Controller
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((MyNavigationController*)self.navigationController).myColor = BLUECOLOR;
//    ((MyNavigationController*)self.navigationController).myColor = [UIColor clearColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出料设备";
    self.machineType = @"10";
    [self loadData];
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(void)loadData{
   // getMachineList_2
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString * urlString = [NSString stringWithFormat:getMachineList_2,userGroupId,self.machineType];
    
    if (self.datas) {
        self.datas = nil;
        [self.tb reloadData];
    }
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"]  isKindOfClass:[NSArray class]]) {
                NSMutableArray * datas = [NSMutableArray array];
                for (NSDictionary * dict in json[@"data"] ) {
                    TP_SB_Model2 * model = [TP_SB_Model2 modelWithDict:dict];
                    [datas addObject:model];
                }
                self.datas = datas;
            }
        }
        [self.tb reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TP_SB_Model2 * model = self.datas[indexPath.row] ;
    cell.textLabel.text = model.banhezhanminchen;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TP_SB_Model2 * model = self.datas[indexPath.row] ;
    if (self.callBack) {
        self.callBack(model.gprsbianhao,model.banhezhanminchen);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
