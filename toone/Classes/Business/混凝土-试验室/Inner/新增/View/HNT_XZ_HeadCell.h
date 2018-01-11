//
//  HNT_XZ_HeadCell.h
//  toone
//
//  Created by 上海同望 on 2018/1/10.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNT_XZ_HeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *startTimeView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *qddjView;
@property (weak, nonatomic) IBOutlet UILabel *qddjLabel;

@property (weak, nonatomic) IBOutlet UIView *zzjgView;
@property (weak, nonatomic) IBOutlet UILabel *zzjgLabel;


@property (weak, nonatomic) IBOutlet UILabel *gcmcLabel;
@property (weak, nonatomic) IBOutlet UIView *gcmcView;


@property (weak, nonatomic) IBOutlet UILabel *sgbwLabel;
@property (weak, nonatomic) IBOutlet UIView *sgbwView;


@property (weak, nonatomic) IBOutlet UILabel *lqLabel;
@property (weak, nonatomic) IBOutlet UIView *lqView;


@property (nonatomic, copy) NSString *departType;
@property (nonatomic, copy) NSString *biaoshiid;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
-(void)hiddenView;

@end
