//
//  TP_SB_Controller.m
//  toone
//
//  Created by 十国 on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_SB_Controller.h"
#import "TP_SB_Model2.h"
#import "MyNavigationController.h"
#define LIGHTRED                SGCOLOR(250, 105, 107, 1.0)
@interface TP_SB_Controller ()<UITableViewDelegate,UITableViewDataSource>
- (IBAction)click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic ,copy) NSString * machineType;
@property (nonatomic,strong) NSArray * datas;
@end

@implementation TP_SB_Controller
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((MyNavigationController*)self.navigationController).myColor = BLUECOLOR;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备";
    self.machineType = @"8";
    [self loadData];
    self.tb.tableFooterView = [[UIView alloc] init];
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case 2:{
            self.machineType = @"8";
            [self changeButtonShape:sender];
            [self loadData];
            break;
        }
        case 3:{
            self.machineType = @"9";
            [self changeButtonShape:sender];
            [self loadData];
            break;
        }
        case 4:{
            self.machineType = @"10";
            [self changeButtonShape:sender];
            [self loadData];
            break;
        }
    }
}
-(void)changeButtonShape:(UIButton*)sender{

    
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button1 .titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.button2 .titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.button3 .titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:16.0f];
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
