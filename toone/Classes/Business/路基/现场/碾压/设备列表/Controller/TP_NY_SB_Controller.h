//
//  TP_NY_SB_Controller.h
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TP_NY_SB_Controller : UITableViewController
@property (nonatomic,copy) void (^callBlock)(NSString*,NSString*);

@end
