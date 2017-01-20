//
//  MyTableViewController.h
//  toone
//
//  Created by shtoone on 17/1/9.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewController : UITableViewController
-(void)reloadData:(NSString *) urlString;
@property (nonatomic,copy)NSString * startTime;
@property (nonatomic,copy)NSString * endTime;
@end
