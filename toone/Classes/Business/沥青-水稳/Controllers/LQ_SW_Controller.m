
//
//  LQ_SW_Controller.m
//  toone
//
//  Created by sg on 2017/3/10.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_SW_Controller.h"

@interface LQ_SW_Controller ()

@end

@implementation LQ_SW_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPanGestureRecognizer];
    [self loadUI];
    [self loadData];
}
-(void)dealloc{
    FuncLog;
}
-(void)loadUI{
    //self.containerView.backgroundColor = BLUECOLOR;
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
}
-(void)loadData{

}
-(void)searchButtonClick:(UIButton*)sender{
    NSString * startTimeStamp = [TimeTools timeStampWithTimeString:self.startTime];
    NSString * endTimeStamp = [TimeTools timeStampWithTimeString:self.endTime];
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    NSString * urlString = [NSString stringWithFormat:AppHntMain_3,userGroupId,startTimeStamp,endTimeStamp];
//    //    __weak typeof(self)  weakSelf = self;
//    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
//        NSMutableArray * datas = [NSMutableArray array];
//        if ([json[@"success"] boolValue]) {
//            if ([json[@"data"] isKindOfClass:[NSArray class]]) {
//                for (NSDictionary * dict in json[@"data"]) {
//                    HNT_BHZ_Model * model = [HNT_BHZ_Model modelWithDict:dict];
//                    [datas addObject:model];
//                }
//            }
//        }
//        
//        self.datas = datas;
//        [self.tableView reloadData];
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [self.tableView.mj_header endRefreshing];
//    } failure:^(NSError *error) {
//    }];
}
@end
