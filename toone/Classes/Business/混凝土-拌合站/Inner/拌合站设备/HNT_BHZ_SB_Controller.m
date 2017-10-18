//
//  HNT_BHZ_SB_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_BHZ_SB_Controller.h"
#import "HNT_BHZ_SB_Model.h"
@interface HNT_BHZ_SB_Controller ()<UITableViewDelegate,UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  UITableView *tbleView;
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic, strong) NSArray * statesArr;//列表查询签收状态
@property (nonatomic, strong) NSArray * qsArr;
@property (nonatomic, strong) NSArray * jsyyArr;

@end

@implementation HNT_BHZ_SB_Controller
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_type == SBListTypeStatu) {
        self.title = @"选择签收状态";
    }else if (_type == SBListTypeQS) {
        self.title = @"选择状态";
    }else if (_type == SBListTypeJSYY) {
        self.title = @"选择拒收原因";
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
    [self.tbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HNT_BHZ_SB_Controller"];
    [self.view addSubview:self.tbleView];
}
-(NSMutableArray *)datas{
    if (!_datas) {
        [Tools showActivityToView:self.view];
        
        NSString * departId = self.departId;
        NSString * urlString = [NSString stringWithFormat:getShebeiList_1,departId];
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        HNT_BHZ_SB_Model * model = [HNT_BHZ_SB_Model modelWithDict:dict];
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
    if (_type == SBListTypeStatu) {
        return self.statesArr.count;
    }else if (_type == SBListTypeQS) {
        return self.qsArr.count;
    }else if (_type == SBListTypeJSYY) {
        return self.jsyyArr.count;
    }
    else {
        return self.datas.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_BHZ_SB_Controller" forIndexPath:indexPath];
    if (_type == SBListTypeStatu) {
        NSDictionary * dict = self.statesArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else if (_type == SBListTypeQS) {
        NSDictionary * dict = self.qsArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }else if (_type == SBListTypeJSYY) {
        NSDictionary * dict = self.jsyyArr[indexPath.row];
        cell.textLabel.text = dict[@"banhezhanminchen"];
    }
    else {
        HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
        cell.textLabel.text = model.banhezhanminchen;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor oldLaceColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == SBListTypeStatu) {

        NSDictionary * dict = self.statesArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }else if (_type == SBListTypeQS) {
        
        NSDictionary * dict = self.qsArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }else if (_type == SBListTypeJSYY) {
        
        NSDictionary * dict = self.jsyyArr[indexPath.row];
        self.callBlock(dict[@"banhezhanminchen"], dict[@"departid"]);
    }
    else {
        
        HNT_BHZ_SB_Model * model = self.datas[indexPath.row];
        if (self.callBlock) {
            self.callBlock(model.banhezhanminchen,model.gprsbianhao);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSArray *)statesArr {
    if (_statesArr == nil) {
        _statesArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"stutas.plist" ofType:nil]];
    }
    return _statesArr;
}
-(NSArray *)qsArr {
    if (_qsArr == nil) {
        _qsArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"restul.plist" ofType:nil]];
    }
    return _qsArr;
}
-(NSArray *)jsyyArr {
    if (_jsyyArr == nil) {
        _jsyyArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rejection.plist" ofType:nil]];
    }
    return _jsyyArr;
}

@end
