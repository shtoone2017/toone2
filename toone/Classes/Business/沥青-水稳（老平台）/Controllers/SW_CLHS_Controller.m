//
//  HNT_CLHS_Controller.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "SW_CLHS_Controller.h"
#import "SW_CLHS_Model.h"
#import "SW_CLHS_ChatCell.h"
#import "SW_CLHS_Cell.h"
#import "LQ_SB_Controller.h"
#import "BarModel.h"
@interface SW_CLHS_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * datas;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sjLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * datas1;
@property (nonatomic,strong) NSMutableArray * datas2;

//***************
@property (nonatomic,copy) NSString * shebeibianhao;//设备编号
@end

@implementation SW_CLHS_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shebeibianhao = @"";
    
    [self loadUi];
    [self loadData];
}
-(void)loadUi{
    self.view.backgroundColor = [UIColor snowColor];
    self.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",super.startTime,super.endTime];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SW_CLHS_ChatCell" bundle:nil] forCellReuseIdentifier:@"SW_CLHS_ChatCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SW_CLHS_Cell" bundle:nil] forCellReuseIdentifier:@"SW_CLHS_Cell"];
}

#pragma mark - 网络请求
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * urlString = swmaterial;
    NSDictionary * dict = @{@"departType":self.conditonDict[@"departType"],
                            @"biaoshiid":self.conditonDict[@"biaoshiid"],
                            @"endTime":endTimeStamp,
                            @"startTime":startTimeStamp,
                            @"shebeibianhao":self.shebeibianhao,
                            };
    __weak typeof(self)  weakSelf = self;
    
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:dict success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dict in json[@"data"]) {
                    SW_CLHS_Model * model = [SW_CLHS_Model modelWithDict:dict];
                    [datas addObject:model];
                }
            }
        }
        NSMutableArray * bars1 = [NSMutableArray array];
        NSMutableArray * bars2 = [NSMutableArray array];
        for (SW_CLHS_Model * model in datas) {
            BarModel * bar1 = [[BarModel alloc] init];
            bar1.name = model.name;
            bar1.value = model.mbpeibi;
            [bars1 addObject:bar1];
            
            BarModel * bar2 = [[BarModel alloc] init];
            bar2.name = model.name;
            bar2.value = model.yongliang;
            [bars2 addObject:bar2];
            
        }
        weakSelf.datas1 = bars1;
        weakSelf.datas2 = bars2;
        //1.
        weakSelf.datas = datas;
        [weakSelf.tableView reloadData];
        
        //移除指示器
        [Tools removeActivity];
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 865;
    }
        
    return 20;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SW_CLHS_ChatCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_CLHS_ChatCell"];
        cell.datas1 = self.datas1;
        cell.datas2 = self.datas2;
        [cell.unitButton addTarget:self action:@selector(choiceUnit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        
        SW_CLHS_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"SW_CLHS_Cell"];
        SW_CLHS_Model * data = self.datas[indexPath.row-1];
        cell.data = data;
        cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
        return cell;
    }
    return nil;
}
-(void)choiceUnit:(UIButton*)sender{
    if (EqualToString(sender.currentTitle, @"千克/kg")) {
        [sender setTitle:@"吨/t" forState:UIControlStateNormal];
        
        
        for (SW_CLHS_Model * data in self.datas) {
            data.yongliang = FormatFloat3([data.yongliang floatValue] / 1000);
            data.mbpeibi = FormatFloat3([data.mbpeibi floatValue] / 1000);
            data.wucha = FormatFloat3([data.wucha floatValue] / 1000);
        }
        [self.tableView reloadData];
    }else{
        [sender setTitle:@"千克/kg" forState:UIControlStateNormal];
        
        
        for (SW_CLHS_Model * data in self.datas) {
            data.yongliang = FormatFloat([data.yongliang floatValue] * 1000);
            data.mbpeibi = FormatFloat([data.mbpeibi floatValue] * 1000);
            data.wucha = FormatFloat([data.wucha floatValue] * 1000);
        }
        [self.tableView reloadData];
    }
}
- (IBAction)searchButtonClick:(UIButton *)sender {
    sender.enabled = NO;
    //1.
    UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(0, 64+36, Screen_w, Screen_h  -64-36);
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    backView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        backView.hidden = NO;
    });
    [self.view addSubview:backView];
    
    //2.
    Exp5View * e = [[Exp5View alloc] init];
    e.frame = CGRectMake(0, 64+36, Screen_w, 195);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2){
        //        NSLog(@"ExpButtonType~~~ %d",type);
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {
            sender.enabled = YES;
            [backView removeFromSuperview];
            //
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            weakSelf.sjLabel.text = [NSString stringWithFormat:@"%@  ->  %@",weakSelf.startTime,weakSelf.endTime];
            [weakSelf loadData];
            FuncLog;
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf performSegueWithIdentifier:@"LQ_SB_Controller2" sender:btn];
        }
    };
    [self.view addSubview:e];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[LQ_SB_Controller class]]) {
        LQ_SB_Controller * controller = vc;
        __weak UIButton * weakBtn = sender;
        __weak __typeof(self)  weakSelf = self;
        controller.title = @"选择设备";
        controller.conditonDict = @{@"departType":self.conditonDict[@"departType"],
                                    @"biaoshiid":self.conditonDict[@"biaoshiid"],
                                    @"machineType":@"6",
                                    };
        controller.callBlock = ^(NSString * banhezhanminchen,NSString*gprsbianhao){
            [weakBtn setTitle:banhezhanminchen forState:UIControlStateNormal];
            weakSelf.shebeibianhao = gprsbianhao;
        };
        
    }
    
}
-(void)dealloc{
    FuncLog;
}

@end
