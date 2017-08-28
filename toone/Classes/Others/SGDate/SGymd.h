//
//  SGymd.h
//  SGDate
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 jzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGymd : UIView
@property (nonatomic,retain) NSDate * currentDate;
@property (nonatomic,copy) void(^block)(NSString*);
@end