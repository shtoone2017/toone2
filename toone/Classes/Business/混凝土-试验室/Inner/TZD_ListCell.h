//
//  TZD_ListCell.h
//  toone
//
//  Created by 景晓峰 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZD_ListCell : UITableViewCell

@property (nonatomic,copy) void(^block)(NSInteger tag);

@property (weak, nonatomic) IBOutlet UILabel *TZD_List_ZZJG;
@property (weak, nonatomic) IBOutlet UIButton *TZD_List_TZD_NUM;
@property (weak, nonatomic) IBOutlet UIButton *TZD_List_SJ_NUM;
@property (weak, nonatomic) IBOutlet UIButton *TZD_List_RWD_NUM;
@property (weak, nonatomic) IBOutlet UILabel *TZD_List_SY_Date;
@property (weak, nonatomic) IBOutlet UILabel *TZD_List_JZBW;

@end
