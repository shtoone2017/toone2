//
//  HNT_CLHS_ChatCell.h
//  toone
//
//  Created by 十国 on 2016/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SW_CLHS_ChatCell : UITableViewCell
@property (nonatomic,strong) NSArray * datas1;

@property (nonatomic,strong) NSArray * datas2;
@property (weak, nonatomic) IBOutlet UIButton *unitButton;
@property (nonatomic,copy) NSString * hsTitle;
@end
