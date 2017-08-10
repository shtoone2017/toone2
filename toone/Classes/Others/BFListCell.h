//
//  BFListCell.h
//  toone
//
//  Created by 景晓峰 on 2017/8/10.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *JC_BF_Name;
@property (weak, nonatomic) IBOutlet UILabel *JC_CL_Name;
@property (weak, nonatomic) IBOutlet UILabel *JC_GYS_Name;
@property (weak, nonatomic) IBOutlet UILabel *JC_SJ;


@property (weak, nonatomic) IBOutlet UILabel *CC_BF_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_CL_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_GYS_Name;
@property (weak, nonatomic) IBOutlet UILabel *CC_SJ;
@property (weak, nonatomic) IBOutlet UILabel *CC_TYPE;




@end
