//
//  YS_SB_Controller.m
//  toone
//
//  Created by 上海同望 on 2018/1/29.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_SB_Controller.h"
#import "YS_SB_Model.h"
#import "YS_deviceModel.h"

@interface YS_SB_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tbleView;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) NSMutableArray * data;


@end
@implementation YS_SB_Controller

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    switch (_type) {
        case SBListTypeYSZH:{
            self.title = @"选择桩号";
            [self datas];
        }
            break;
        case SBListTypeYSLX:{
            self.title = @"选择路线";
            [self datas];
        }
            break;
        case SBListTypeYSMC:{
            self.title = @"选择面层";
            [self loadData];
        }
            break;
        case SBListTypeYSSB_YLJ:{
            self.title = @"选择压路机设备";
            [self datas];
        }
            break;
        case SBListTypeYSSB_TPJ:{
            self.title = @"选择摊铺机设备";
            [self datas];
        }
            break;
        case SBListTypeYSSB_YLJ_Zuobiao:{
            self.title = @"选择设备";
            [self datas];
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, Screen_w, Screen_h) style:UITableViewStylePlain];
    _tbleView.delegate =self;
    _tbleView.dataSource = self;
    self.tbleView.rowHeight = 40;
    self.tbleView.tableFooterView = [[UIView alloc] init];
    [self.tbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YS_SB_Controller"];
    [self.view addSubview:self.tbleView];
}
-(void)loadData {
    NSMutableArray * datas = [NSMutableArray array];
    NSDictionary *dic1 = @{@"name":@"上面层",@"num":@"1"};
    NSDictionary *dic2 = @{@"name":@"中间层",@"num":@"2"};
    NSDictionary *dic3 = @{@"name":@"下面层",@"num":@"3"};
    [datas addObject:dic1];
    [datas addObject:dic2];
    [datas addObject:dic3];
    
    NSMutableArray * data = [NSMutableArray array];
    for (NSDictionary *dict in datas) {
        YS_SB_Model * model = [YS_SB_Model modelWithDict:dict];
        model.mcName = dict[@"name"];
        model.mcNum = dict[@"num"];
        [data addObject:model];
    }
    self.data = data;
}

-(NSMutableArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        
        NSString * urlString;
        if (_type == SBListTypeYSZH) {
            urlString = @"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetStake?road_id=f9a816c15f7aa4ca015f7cbf18aa004d";
        }else if (_type == SBListTypeYSLX) {
            urlString = @"http://121.40.150.65:8083/gxzjzqms3.6.6LQYS/rest/rs_DeviceController/GetRoad";
        }
        else if (_type == SBListTypeYSSB_YLJ)//1压路机 2摊铺机
        {
            urlString = [NSString stringWithFormat:@"%@?road_id=%@&device_type=1",YS_Device,[UserDefaultsSetting shareSetting].road_id];
        }
        else if (_type == SBListTypeYSSB_TPJ)
        {
            urlString = [NSString stringWithFormat:@"%@?road_id=%@&device_type=2",YS_Device,[UserDefaultsSetting shareSetting].road_id];
        }
        else if (_type == SBListTypeYSSB_YLJ_Zuobiao)
        {
            urlString = [NSString stringWithFormat:@"%@?Road_id=%@",YS_Device_Zuobiao,[UserDefaultsSetting shareSetting].road_id];
        }
        
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if (_type == SBListTypeYSSB_YLJ_Zuobiao)
            {
                datas = [YS_deviceModel arrayOfModelsFromDictionaries:[json valueForKey:@"data"]];
            }
            else
            {
                if ([json isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json) {
                        
                        YS_SB_Model * model = [YS_SB_Model modelWithDict:dict];
                        model.roadId = dict[@"id"];
                        [datas addObject:model];
                    }
                }
            }

            weakSelf.datas = datas;
            [weakSelf.tbleView reloadData];
            [Tools removeActivity];
        } failure:^(NSError *error) {
        }];
        
    }
    return _datas;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == SBListTypeYSMC) {
        return self.data.count;
    }else {
        return self.datas.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YS_SB_Controller" forIndexPath:indexPath];
    if (_type == SBListTypeYSZH) {//桩号
        YS_SB_Model * model = self.datas[indexPath.row];
        cell.textLabel.text = model.stake_name;
    }
    else if (_type == SBListTypeYSLX) {//路线
        YS_SB_Model * model = self.datas[indexPath.row];
        cell.textLabel.text = model.road_name;
    }
    else if (_type == SBListTypeYSMC) {//面层
        YS_SB_Model * model = self.data[indexPath.row];
        cell.textLabel.text = model.mcName;
    }
    else if (_type == SBListTypeYSSB_YLJ || _type == SBListTypeYSSB_TPJ)
    {
        YS_SB_Model * model = self.datas[indexPath.row];
        cell.textLabel.text = model.device_name;
    }
    else if (_type == SBListTypeYSSB_YLJ_Zuobiao)
    {
        YS_deviceModel *model = self.datas[indexPath.row];
        cell.textLabel.text = model.device_name;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == SBListTypeYSZH) {//桩号
        YS_SB_Model * model = self.datas[indexPath.row];
        if (self.YScallBlock) {
            NSString *str = [NSString stringWithFormat:@"%@",model.stake_no];
            self.YScallBlock(model.stake_name,str);
        }
    }
    else if (_type == SBListTypeYSLX) {
        YS_SB_Model * model = self.datas[indexPath.row];
        [UserDefaultsSetting shareSetting].road_id =  model.roadId;
        [UserDefaultsSetting shareSetting].road_name =  model.road_name;
        if (self.YScallBlock) {
            self.YScallBlock(model.road_name, model.roadId);
        }
    }
    else if (_type == SBListTypeYSMC) {
        YS_SB_Model * model = self.data[indexPath.row];
        if (self.YScallBlock) {
            self.YScallBlock(model.mcName, model.mcNum);
        }
    }
    else if (_type == SBListTypeYSSB_YLJ || _type == SBListTypeYSSB_TPJ)
    {
        YS_SB_Model * model = self.datas[indexPath.row];
        if (self.YScallBlock) {
            self.YScallBlock(model.device_name, model.device_code);
        }
    }
    else if (_type == SBListTypeYSSB_YLJ_Zuobiao)
    {
        YS_deviceModel *model = self.datas[indexPath.row];
        if (self.YScallBlock) {
            self.YScallBlock(model.device_name,model);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
