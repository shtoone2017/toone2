//
//  DayDetailsCell.h
//  toone
//
//  Created by shtoone on 17/1/3.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DayQueryModel;

@interface DayDetailsCell : UITableViewCell

-(void)model:(DayQueryModel*)model withIndex:(long)index;
@end
