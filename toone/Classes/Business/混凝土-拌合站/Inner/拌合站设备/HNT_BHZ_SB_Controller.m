//
//  HNT_BHZ_SB_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_BHZ_SB_Controller.h"
#import "HNT_BHZ_SB_Model.h"
#import "GCB_JCB_Controller.h"
@interface HNT_BHZ_SB_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tbleView;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic, strong) NSArray * ztArr;
@property (nonatomic, strong) NSArray * statesArr;
@property (nonatomic, strong) NSArray * tongtypeArr;
@property (nonatomic, strong) NSArray * wscArr;//未生产
@property (nonatomic, strong) NSArray * sczArr;//生产中
@property (nonatomic, strong) NSArray * ylqdArr;//压力设计强度
@property (nonatomic, strong) NSArray * yllqArr;//压力龄期
@end

@implementation HNT_BHZ_SB_Controller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    switch (_type)
    {
        case SBListTypeSJQD:
        {
            self.title = @"选择设计强度";
            [self datas];
        }
            break;
        case SBListTypeTLD:
        {
            self.title = @"选择塌落度";
            [self datas];
        }
            break;
        case SBListTypeSGD:
        {
            self.title = @"选择施工队";
            [self datas];
        }
            break;
        case SBListTypeJZFS:
        {
            self.title = @"选择浇注方式";
            [self datas];
        }
            break;
        case SBListTypeYLQD:
        {
            self.title = @"设计强度";
            
        }
            break;
        case SBListTypeYLLQ:
        {
            self.title = @"龄期";
            
        }
            break;
        case SBListTypeRWDZT:
        {
            self.title = @"任务单状态";
            
        }
            break;
        case SBListTypeTon:
        {
            self.title = @"选择时间";
            
        }
            break;
        case SBListTypeStat:
        {
            self.title = @"出场类型";
            
        }
            break;
        case SBListTypeRWSCZ:
        {
            self.title = @"选择状态";
            
        }
            break;
        case SBListTypeRWWSC:
        {
            self.title = @"选择状态";
            
        }
            break;

        default:
            self.title = @"选择设备";
            [self datas];
            break;
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, Screen_w, Screen_h) style:UITableViewStylePlain];
//    self.tbleView.backgroundColor = [UIColor cyanColor];
    _tbleView.delegate =self;
    _tbleView.dataSource = self;
    self.tbleView.rowHeight = 40;
    self.tbleView.tableFooterView = [[UIView alloc] init];
    [self.tbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HNT_BHZ_SB_Controller"];
    [self.view addSubview:self.tbleView];
}
-(NSMutableArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        
        NSString * departId = departId = self.departId ?:@"";
        
        NSString * urlString;
        if (_type == SBListTypeBF)
        {
            //磅房设备URL
//            departId = [UserDefaultsSetting shareSetting].departId;
            urlString = [NSString stringWithFormat:@"%@AppGB.do?AppDiBangList&departId=%@",baseUrl,departId];
        }
        else if (_type == SBListTypeSJQD)
        {
            urlString = [NSString stringWithFormat:@"%@app.do?appTypes&typegroupcode=%@",baseUrl,@"SJQD"];
        }
        else if (_type == SBListTypeTLD)
        {
            urlString = [NSString stringWithFormat:@"%@app.do?appTypes&typegroupcode=%@",baseUrl,@"TLD"];
        }
        else if (_type == SBListTypeJZFS)
        {
            urlString = [NSString stringWithFormat:@"%@app.do?appTypes&typegroupcode=%@",baseUrl,@"JZFS"];
        }
        else if (_type == SBListTypeCBCZ)
        {
            urlString = [NSString stringWithFormat:getShebeiList_1,departId];
        }
        else if (_type == SBListTypeSGD)
        {
            urlString = [NSString stringWithFormat:App_SGD,departId];
        }

        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        HNT_BHZ_SB_Model * model = [HNT_BHZ_SB_Model modelWithDict:dict];
                        model.useId = dict[@"id"];
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
-(NSArray *)ztArr {//任务单
    if (_ztArr == nil) {
        _ztArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zhuangtai.plist" ofType:nil]];
    }
    return _ztArr;
}
-(NSArray *)sczArr {//生产中
    if (_sczArr == nil) {
        _sczArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"scz.plist" ofType:nil]];
    }
    return _sczArr;
}
-(NSArray *)yllqArr {//压力龄期
    if (_yllqArr == nil) {
        _yllqArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lq.plist" ofType:nil]];
    }
    return _yllqArr;
}
-(NSArray *)ylqdArr {//压力设计强度
    if (_ylqdArr == nil) {
        _ylqdArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sjqd.plist" ofType:nil]];
    }
    return _ylqdArr;
}
-(NSArray *)wscArr {
    if (_wscArr == nil) {
        _wscArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wsc.plist" ofType:nil]];
    }
    return _wscArr;
}

-(NSArray *)statesArr {//
    if (_statesArr == nil) {
        _statesArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"states.plist" ofType:nil]];
    }
    return _statesArr;
}
-(NSArray *)tongtypeArr {//
    if (_tongtypeArr == nil) {
        _tongtypeArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tongjitype.plist" ofType:nil]];
    }
    return _tongtypeArr;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == SBListTypeRWDZT) {
       return self.ztArr.count;
    }else if (_type == SBListTypeTon) {
        return self.tongtypeArr.count;
    }else if (_type == SBListTypeStat) {
        return self.statesArr.count;
    }else if (_type == SBListTypeRWSCZ) {//生产中
        return self.sczArr.count;
    }else if (_type == SBListTypeRWWSC) {
        return self.wscArr.count;
    }else if (_type == SBListTypeYLQD) {//压力设计强度
        return self.ylqdArr.count;
    }else if (_type == SBListTypeYLLQ) {//龄期
        return self.yllqArr.count;
    }else {
        return self.datas.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_BHZ_SB_Controller" forIndexPath:indexPath];
    if (_type == SBListTypeRWDZT) {//任务单
        NSDictionary * dict = self.ztArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else if (_type == SBListTypeRWSCZ) {//生产中
        NSDictionary * dict = self.sczArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else if (_type == SBListTypeRWWSC) {//
        NSDictionary * dict = self.wscArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else if (_type == SBListTypeTon) {//时间类型
        NSDictionary * dict = self.tongtypeArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else if (_type == SBListTypeStat) {//出场类型
        NSDictionary * dict = self.statesArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else if (_type == SBListTypeYLQD) {//压力设计强度
        NSDictionary * dict = self.ylqdArr[indexPath.row];
        cell.textLabel.text = dict[@"name"];
    }else if (_type == SBListTypeYLLQ) {//龄期
        NSDictionary * dict = self.yllqArr[indexPath.row];
        cell.textLabel.text = dict[@"name"];
    }else {
        
        HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
        if (_type == SBListTypeJZFS || _type == SBListTypeSJQD || _type == SBListTypeTLD)
        {
            cell.textLabel.text = model.typecode;
        }
        else if (_type == SBListTypeSGD) {
            cell.textLabel.text = model.name;
        }
        else
        {
            cell.textLabel.text = model.banhezhanminchen;
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == SBListTypeRWDZT) {
        
        NSDictionary * dict = self.ztArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }else if (_type == SBListTypeRWSCZ) {//生产中
        
        NSDictionary * dict = self.sczArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }else if (_type == SBListTypeRWWSC) {
        
        NSDictionary * dict = self.wscArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }else if (_type == SBListTypeTon) {
        
        NSDictionary * dict = self.tongtypeArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }else if (_type == SBListTypeStat) {
        
        NSDictionary * dict = self.statesArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }else if (_type == SBListTypeYLQD) {//压力设计强度
        
        NSDictionary * dict = self.ylqdArr[indexPath.row];
        self.callBlock(dict[@"name"], nil);
    }else if (_type == SBListTypeYLLQ) {//龄期
        
        NSDictionary * dict = self.yllqArr[indexPath.row];
        self.callBlock(dict[@"name"], nil);
    }else {
        
        HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
        if (self.callBlock) {
            if (_type == SBListTypeJZFS || _type == SBListTypeSJQD || _type == SBListTypeTLD)
            {
                self.callBlock(model.typename,model.typecode);
            }
            else if (_type == SBListTypeSGD) {
                self.callBlock(model.name,model.useId);
            }
            else
            {
                self.callBlock(model.banhezhanminchen,model.gprsbianhao);
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
