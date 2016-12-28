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
#import "HNT_CBCZ_Detail_ChuliCell.h"

#define SGCOLOR(r,g,b,a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define Color1                  SGCOLOR(224,243,241,1.0)
#define Color2                  SGCOLOR(232,232,253,1.0)
@interface HNT_CBCZ_DetailController ()
@property (nonatomic,strong) NSMutableArray * datas;
@property (nonatomic,strong) HNT_CBCZ_Detail_HeadMsg * headMsg;
@end

@implementation HNT_CBCZ_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUi];

    
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
}

- (void)keyboardWillChange:(NSNotification  *)notification{
    // 1.获取键盘的Y值
    NSDictionary *dict  = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    //动画时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 2.计算需要移动的距离
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height);
    } completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    FuncLog;
}
-(void)loadUi{
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HNT_SCCX_Detail_HeadMsgCell" bundle:nil] forCellReuseIdentifier:@"HNT_SCCX_Detail_HeadMsgCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HNT_SCCX_Detail_DataCell" bundle:nil] forCellReuseIdentifier:@"HNT_SCCX_Detail_DataCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HNT_CBCZ_Detail_ChuliCell" bundle:nil] forCellReuseIdentifier:@"HNT_CBCZ_Detail_ChuliCell"];
}

-(NSMutableArray *)datas{
    if (!_datas) {
        NSString * urlString = [NSString stringWithFormat:AppHntChaobiaoDetail_1,self.bianhao];
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
                }
            }
            //
            weakSelf.datas = datas;
            [weakSelf.tableView reloadData];
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
    return self.datas.count+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 630;
    }else if(indexPath.row > 0 && indexPath.row < (self.datas.count+1)){
        return 20;
    }else{
        return 720;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HNT_SCCX_Detail_HeadMsgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_HeadMsgCell"];
        cell.headMsg2 = self.headMsg;
        return cell;
    }else if(indexPath.row >0 && indexPath.row < self.datas.count+1){
        
        HNT_SCCX_Detail_DataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_SCCX_Detail_DataCell"];
        HNT_SCCX_Detail_Data * data = self.datas[indexPath.row-1];
        cell.data = data;
        cell.contentView.backgroundColor = indexPath.row%2==0 ? Color1: Color2;
        return cell;
    }
    else {
        HNT_CBCZ_Detail_ChuliCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HNT_CBCZ_Detail_ChuliCell"];
        cell.headMsg = self.headMsg;
        cell.weakController = self;
        cell.chuli = self.chuli;
        cell.shenhe = self.shenhe;
        return cell;
    }
    return nil;
}


@end
