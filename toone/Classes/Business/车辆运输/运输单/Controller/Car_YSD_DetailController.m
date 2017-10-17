//
//  Car_YSD_DetailController.m
//  toone
//
//  Created by 上海同望 on 2017/10/17.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_YSD_DetailController.h"
#import "Car_YSD_Model.h"
#import "Car_YSD_DetailCell.h"
#import "Car_YSD_IconCell.h"
#import "UIImageView+WebCache.h"

@interface Car_YSD_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) Car_YSD_Model * headModel;

@end
@implementation Car_YSD_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据详情";
    [self loadUI];
    [self loadData];
    
}
-(void)loadUI{
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    [self.tb registerNib:[UINib nibWithNibName:@"Car_YSD_DetailCell" bundle:nil] forCellReuseIdentifier:@"Car_YSD_DetailCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"Car_YSD_IconCell" bundle:nil] forCellReuseIdentifier:@"Car_YSD_IconCell"];
}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    NSString *token = [UserDefaultsSetting_SW shareSetting].Token;
    NSString * urlString = [NSString stringWithFormat:CarDetail,token,_fcdbh,_bhzbh];
    __weak typeof(self)  weakSelf = self;
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"code"] integerValue] == 1) {
            
            if ([json[@"data"] isKindOfClass:[NSDictionary class]]) {
                Car_YSD_Model * head = [Car_YSD_Model modelWithDict:json[@"data"]];
                weakSelf.headModel = head;
            }
            [weakSelf.tb reloadData];
            [Tools removeActivity];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 320;
    }
    if (indexPath.section == 1) {
        return 220;
    }
    if (indexPath.section == 2) {
        return 220;
    }
    return 0.0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"签收照片";
        case 2:return @"拒收图片";
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Car_YSD_DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Car_YSD_DetailCell"];
        Car_YSD_Model * model = self.headModel;
        cell.model = model;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        Car_YSD_IconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Car_YSD_IconCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        Car_YSD_Model * model = self.headModel;
        NSString *icon = Car_Detail_Icon(model.QSZP);
        cell.qsIcon = icon;
//        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:icon]];
        return cell;
    }
    if (indexPath.section == 2) {
        Car_YSD_IconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Car_YSD_IconCell"];
        Car_YSD_Model * model = self.headModel;
        NSString *icon = Car_Detail_Icon(model.JSPZ);
        cell.iconName = icon;
//        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:Car_Detail_Icon(model.JSPZ)] placeholderImage:nil];
        return cell;
    }
    return nil;
}

@end
