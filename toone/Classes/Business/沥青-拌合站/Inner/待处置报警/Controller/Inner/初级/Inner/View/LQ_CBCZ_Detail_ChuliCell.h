//
//  HNT_CBCZ_Detail_ChuliCell.h
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNT_CBCZ_Detail_HeadMsg;
@interface LQ_CBCZ_Detail_ChuliCell : UITableViewCell
@property (nonatomic,strong) HNT_CBCZ_Detail_HeadMsg * headMsg;

@property (nonatomic,weak) UIViewController * weakController;
@property (nonatomic,copy) NSString *  chuli ;//  处理与否
@property (nonatomic,copy) NSString *  shenhe ;//  审核
@end
