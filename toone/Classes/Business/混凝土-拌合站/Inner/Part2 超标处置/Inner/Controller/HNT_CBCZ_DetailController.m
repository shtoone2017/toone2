//
//  HNT_CBCZ_DetailController.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_DetailController.h"
#import "HNT_SCCX_Detail_DataCell.h"
#import "HNT_SCCX_Detail_HeadMsgCell.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
#import "HNT_SCCX_Detail_Data.h"


#import "HNT_CBCZ_Detail_ChuLi_Cell.h"
#import "HNT_CBCZ_Detail_ChuLi_Cell2.h"
#import "HNT_CBCZ_Detail_ShenPi_Cell.h"
//#define SGCOLOR(r,g,b,a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//#define Color1                  SGCOLOR(224,243,241,1.0)
//#define Color2                  SGCOLOR(232,232,253,1.0)


#import "HNT_CBCZ_Detail_ChuLi_Controller.h"
#import "HNT_CBCZ_Detail_ShenPi_Controller.h"
@interface HNT_CBCZ_DetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) HNT_CBCZ_Detail_HeadMsg * headMsg;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (nonatomic,assign) BOOL  filePathImageHas;
@end

@implementation HNT_CBCZ_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUi];
}

-(void)dealloc{
    FuncLog;
}
-(void)loadUi{
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tb registerNib:[UINib nibWithNibName:@"HNT_SCCX_Detail_HeadMsgCell" bundle:nil] forCellReuseIdentifier:@"HNT_SCCX_Detail_HeadMsgCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"HNT_SCCX_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"HNT_SCCX_Detail_DataCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"HNT_CBCZ_Detail_ChuLi_Cell" bundle:nil] forCellReuseIdentifier:@"HNT_CBCZ_Detail_ChuLi_Cell"];
     [self.tb registerNib:[UINib nibWithNibName:@"HNT_CBCZ_Detail_ChuLi_Cell2" bundle:nil] forCellReuseIdentifier:@"HNT_CBCZ_Detail_ChuLi_Cell2"];
     [self.tb registerNib:[UINib nibWithNibName:@"HNT_CBCZ_Detail_ShenPi_Cell" bundle:nil] forCellReuseIdentifier:@"HNT_CBCZ_Detail_ShenPi_Cell"];
}

-(NSMutableArray *)datas{
    if (!_datas) {
        //添加指示器
        [Tools showActivityToView:self.view];
        
        NSString * urlString = [NSString stringWithFormat:CBCZDetail,self.bianhao];
        __weak typeof(self)  weakSelf = self;
        [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
            NSMutableArray * datas = [NSMutableArray array];
            if ([json[@"success"] boolValue]) {
                if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"data"]) {
                        HNT_SCCX_Detail_Data * data = [HNT_SCCX_Detail_Data modelWithDict:dict];
                        [datas addObject:data];
                    }
                }
                if ([json[@"headMsg"] isKindOfClass:[NSDictionary class]]) {
                    HNT_CBCZ_Detail_HeadMsg * headMsg = [HNT_CBCZ_Detail_HeadMsg modelWithDict:json[@"headMsg"]];
                    weakSelf.headMsg = headMsg;
                    //判断有没有图片
                    NSString * urlString = FormatString(baseUrl, self.headMsg.filePath);
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    if (data.length > 100) {
                        self.filePathImageHas = YES;
                        data = nil;
                    }
                }
            }
            //
            weakSelf.datas = datas;
            [weakSelf.tb reloadData];
            
#pragma mark - 因布局设计有卡顿现象，优化方法如下
//            weakSelf.tb.contentOffset = CGPointMake(0, 220);
//            [UIView animateWithDuration:0.15 animations:^{
//                weakSelf.tb.contentOffset = CGPointMake(0, 0);
//            } completion:^(BOOL finished) {
                //移除指示器
                [Tools removeActivity];
                
//            }];
            
        } failure:^(NSError *error) {
        }];
    }
    return _datas;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (EqualToString(self.chuli, @"1")) {
      return self.datas.count+3;
    }else if(EqualToString(self.chuli, @"0")){
        return self.datas.count+2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (EqualToString(self.chuli, @"1")) {
        if (indexPath.row == 0) {
            return 425;
        }else if(indexPath.row > 0 && indexPath.row < (self.datas.count+1)){
            return 20;
        }else if(indexPath.row == self.datas.count+1){
            if (self.filePathImageHas) {
                return 450;
            }else{
                return 220;
            }
        }else if (indexPath.row == self.datas.count+2){
            if (EqualToString(self.shenhe, @"1")) {
                return 190;
            }else{
                return 40;
            }
        }
    }else  if (EqualToString(self.chuli, @"0")){
        if (indexPath.row == 0) {
            return 425;
        }else if(indexPath.row > 0 && indexPath.row < (self.datas.count+1)){
            return 20;
        }else if(indexPath.row == self.datas.count+1){
            return 40;
        }
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //已处置
    if (EqualToString(self.chuli, @"1")) {
        if (indexPath.row == 0) {
            HNT_SCCX_Detail_HeadMsgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_HeadMsgCell"];
            cell.headMsg2 = self.headMsg;
            return cell;
        }else if(indexPath.row > 0 && indexPath.row < (self.datas.count+1)){
            HNT_SCCX_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_DataCell"];
            HNT_SCCX_Detail_Data * data = self.datas[indexPath.row-1];
            cell.data = data;
            cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
            return cell;
        }else if(indexPath.row == self.datas.count+1){
            if (self.filePathImageHas) {
                HNT_CBCZ_Detail_ChuLi_Cell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_CBCZ_Detail_ChuLi_Cell2"];
                cell.headMsg = self.headMsg;
                return cell;
            }else{
                HNT_CBCZ_Detail_ChuLi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_CBCZ_Detail_ChuLi_Cell"];
                cell.headMsg = self.headMsg;
                return cell;
            }
        }else if (indexPath.row == self.datas.count+2){
            if (EqualToString(self.shenhe, @"1")) {
                HNT_CBCZ_Detail_ShenPi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_CBCZ_Detail_ShenPi_Cell"]
                ;
                cell.headMsg = self.headMsg;
                return cell;
            }else{
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if ([UserDefaultsSetting shareSetting].hntchaobiaoSp) {
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                    btn.frame = CGRectMake(0, 0, Screen_w, 40);
                    [btn setTitle:@"点击这里开始审核..." forState:UIControlStateNormal];
                    [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                    [cell.contentView addSubview:btn];
                    [btn addTarget:self action:@selector(goto_shenpi) forControlEvents:UIControlEventTouchUpInside];
                }
                return cell;
            }
        }
    }
    //****
    //****
    //****
    else  if (EqualToString(self.chuli, @"0")){
        if (indexPath.row == 0) {
            HNT_SCCX_Detail_HeadMsgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_HeadMsgCell"];
            cell.headMsg2 = self.headMsg;
            return cell;
        }else if(indexPath.row > 0 && indexPath.row < (self.datas.count+1)){
            HNT_SCCX_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_DataCell"];
            HNT_SCCX_Detail_Data * data = self.datas[indexPath.row-1];
            cell.data = data;
            cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
            return cell;
        }else if(indexPath.row == self.datas.count+1){
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if ([UserDefaultsSetting shareSetting].hntchaobiaoReal) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(0, 0, Screen_w, 40);
                [btn setTitle:@"点击这里开始处置..." forState:UIControlStateNormal];
                [btn setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [cell.contentView addSubview:btn];
                [btn addTarget:self action:@selector(goto_chuzhi) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
    }
    
    return nil;
}
-(void)goto_chuzhi{
    HNT_CBCZ_Detail_ChuLi_Controller * vc = [[HNT_CBCZ_Detail_ChuLi_Controller alloc] init];
    vc.bianhao = self.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goto_shenpi{
    HNT_CBCZ_Detail_ShenPi_Controller * vc = [[HNT_CBCZ_Detail_ShenPi_Controller alloc] init];
    vc.bianhao = self.bianhao;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
