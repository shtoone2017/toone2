//
//  HNT_SCCX_Detail_HeadMsgCell.h
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNT_SCCX_Detail_HeadMsg,HNT_CBCZ_Detail_HeadMsg,HNT_SCCX_Detail_HeadModel;
@interface HNT_SCCX_Detail_HeadMsgCell : UITableViewCell
@property (nonatomic,strong) HNT_SCCX_Detail_HeadMsg * headMsg;
@property (nonatomic,strong) HNT_CBCZ_Detail_HeadMsg * headMsg2;
@property (nonatomic,strong) HNT_SCCX_Detail_HeadModel * headModel;
@end
