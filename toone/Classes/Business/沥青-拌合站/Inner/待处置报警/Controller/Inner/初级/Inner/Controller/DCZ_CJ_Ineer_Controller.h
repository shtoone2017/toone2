//
//  DCZ_CJ_Ineer_Controller.h
//  toone
//
//  Created by shtoone on 17/1/5.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EXPrimaryModel;

@interface DCZ_CJ_Ineer_Controller : UITableViewController
@property (nonatomic,copy) NSString *  chuli ;//  处置与否
@property (nonatomic, strong) NSNumber * bianhao;//编号
@property (nonatomic, strong) EXPrimaryModel *ChaoBiaoModel;
@end
