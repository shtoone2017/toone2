//
//  LQ_BHZ_SB_Controller.h
//  toone
//
//  Created by shtoone on 16/12/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQ_BHZ_SB_Controller : UITableViewController
@property (nonatomic,copy) void (^callBlock)(NSString*,NSString*);

@end
